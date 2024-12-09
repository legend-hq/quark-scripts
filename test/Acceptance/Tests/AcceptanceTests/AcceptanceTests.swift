@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation
import SwiftKeccak
import Testing

@testable import Acceptance

func getTests() -> [AcceptanceTest] {
    return [
        .init(
            name: "Alice transfers 10 USDC to Bob on Ethereum",
            given: [
                .tokenBalance(.alice, .amt(100, .usdc), .ethereum),
                .quote(.basic),
            ],
            when: .transfer(from: .alice, to: .bob, amount: .amt(10, .usdc), on: .ethereum),
            expect: .single(
                .multicall([
                    .transferErc20(tokenAmount: .amt(10, .usdc), recipient: .bob),
                    .quotePay(payment: .amt(0.10, .usdc), payee: .stax, quote: .basic),
                ]))
        ),
        .init(
            name: "Alice transfers 10 USDC to Bob via Bridge",
            given: [
                .tokenBalance(.alice, .amt(100, .usdc), .arbitrum),
                .quote(.basic),
            ],
            when: .transfer(from: .alice, to: .bob, amount: .amt(10, .usdc), on: .arbitrum),
            expect: .single(
                .multicall([
                    .transferErc20(tokenAmount: .amt(10, .usdc), recipient: .bob),
                    .quotePay(payment: .amt(0.04, .usdc), payee: .stax, quote: .basic),
                ]))
        )
    ]
}

enum Call: Equatable {
    case bridge(
        bridge: String, srcNetwork: Network, destinationNetwork: Network, tokenAmount: TokenAmount)
    case transferErc20(tokenAmount: TokenAmount, recipient: Account)
    case quotePay(payment: TokenAmount, payee: Account, quote: Quote)
    case multicall(_ calls: [Call])
    case unknownFunctionCall(String, String, ABI.Value)
    case unknownScriptCall(EthAddress, Hex)

    static let allFunctions: [(String, Hex, [ABI.Function])] = [
        ("AcrossActions", AcrossActions.creationCode, AcrossActions.functions),
        ("TransferActions", TransferActions.creationCode, TransferActions.functions),
        ("Multicall", Multicall.creationCode, Multicall.functions),
        ("QuotePay", QuotePay.creationCode, QuotePay.functions),
    ]

    static func tryDecodeCall(scriptAddress: EthAddress, calldata: Hex, network: Network) -> Call {

        if scriptAddress == getScriptAddress(AcrossActions.creationCode) {
            print("DECODE ACROSS")
            switch try? AcrossActions.depositV3Fn.decodeInput(input: calldata) {
            case let .tuple14(
                .address(_),
                .address(_),
                .address(_),
                .address(inputToken),
                .address(_),
                .uint256(inputAmount),
                .uint256(_),
                .uint256(destinationChainId),
                .address(_),
                .uint32(_),
                .uint32(_),
                .uint32(_),
                .bytes(_),
                .bool(_)
            ):
                return .bridge(
                    bridge: "Across",
                    srcNetwork: network,
                    destinationNetwork: Network.fromChainId(BigInt(destinationChainId)),
                    tokenAmount: Token.getTokenAmount(amount: inputAmount, network: network, address: inputToken))
            default:
                break
            }
        }

        if scriptAddress == getScriptAddress(TransferActions.creationCode) {
            print("DECODE TRANSFER")
            switch try? TransferActions.transferERC20TokenFn.decodeInput(input: calldata) {
            case let .tuple3(.address(token), .address(recipient), .uint256(amount)):
            print("ADDRESSS \(token)")
                return .transferErc20(
                    tokenAmount: Token.getTokenAmount(amount: amount, network: network, address: token),
                    recipient: Account.from(address: recipient))
            default:
                break
            }
        }

        if scriptAddress == getScriptAddress(QuotePay.creationCode) {
            print("DECODE QUOTE PAY")
            switch try? QuotePay.payFn.decodeInput(input: calldata) {
            case let .tuple4(
                .address(payee), .address(paymentToken), .uint256(quotedAmount), .bytes32(quoteId)):

                print("quotedAmount: \(quotedAmount)")
                return .quotePay(
                    payment: Token.getTokenAmount(amount: quotedAmount, network: network, address: paymentToken),
                    payee: Account.from(address: payee),
                    quote: Quote.findQuote(quoteId: quoteId, prices: [:], fees: [:]))
            default:
                break
            }
        }

        if scriptAddress == getScriptAddress(Multicall.creationCode) {
            switch try? Multicall.runFn.decodeInput(input: calldata) {
            case let .tuple2(.array(.address, callContracts), .array(.bytes, callDatas)):
                let calls = zip(callContracts, callDatas).map {
                    switch ($0, $1) {
                    case let (.address(scriptAddressInner), .bytes(calldataInner)):
                        return Call.tryDecodeCall(
                            scriptAddress: scriptAddressInner, calldata: calldataInner,
                            network: network)
                    default:
                        fatalError("Mismatched types for Multicall: \(($0.schema, $1.schema))")
                    }
                }
                return .multicall(calls)
            default:
                break
            }
        }

        for (name, creationCode, functions) in Call.allFunctions {
            if scriptAddress == getScriptAddress(creationCode) {
                for function in functions {
                    if let value = try? function.decodeInput(input: calldata) {
                        return .unknownFunctionCall(name, function.name, value)
                    }
                }
            }
        }
        return .unknownScriptCall(scriptAddress, calldata)
    }

    var description: String {
        switch self {
        case let .bridge(bridge, chainId, destinationChainId, tokenAmount):
            return
                "bridge(\(bridge), \(tokenAmount.amount) \(tokenAmount.token.symbol) from \(chainId.description) to \(destinationChainId.description))"
        case let .transferErc20(tokenAmount, recipient):
            return
                "transferErc20(\(tokenAmount.amount) \(tokenAmount.token.symbol) to \(recipient.description))"
        case let .quotePay(payment, payee, quoteId):
            return
                "quotePay(\(payment.amount) \(payment.token.symbol) to \(payee.description), quoteId: \(quoteId))"
        case let .multicall(calls):
            return "multicall(\(calls.map { $0.description }.joined(separator: ", ")))"
        case let .unknownFunctionCall(name, function, value):
            return "unknownFunctionCall(\(name), \(function), \(value))"
        case let .unknownScriptCall(scriptSource, calldata):
            return "unknownScriptCall(\(scriptSource.description), \(calldata.description))"
        }
    }
}

func getScriptAddress(_ creationCode: Hex) -> EthAddress {
    // Create2 address calculation according to EIP-1014
    // address = keccak256(0xff ++ deployingAddress ++ salt ++ keccak256(bytecode))[12:]
    let codeJarAddress = EthAddress("0x2b68764bCfE9fCD8d5a30a281F141f69b69Ae3C8")

    // Pack the data according to create2 spec:
    // 1. 0xff - prevents collision with create
    // 2. deploying contract address
    // 3. salt (32 bytes of 0 in this case)
    // 4. keccak256 hash of initialization code
    var packed = Data()
    packed.append(Data([0xFF]))  // prefix byte
    packed.append(codeJarAddress.data)  // deploying address
    packed.append(Data(repeating: 0, count: 32))  // salt
    packed.append(SwiftKeccak.keccak256(creationCode.data))  // hash of init code

    // Take keccak256 hash and extract last 20 bytes for address
    let hash = SwiftKeccak.keccak256(packed)
    return EthAddress(Hex(hash.subdata(in: 12..<32)))!
}

enum Account: Equatable {
    case alice
    case bob
    case stax
    case unknownAccount(EthAddress)

    static let knownCases: [Account] = [.alice, .bob, .stax]

    var description: String {
        switch self {
        case .alice:
            return "Alice"
        case .bob:
            return "Bob"
        case .stax:
            return "stax"
        case let .unknownAccount(address):
            return "UnknownAccount(\(address.description))"
        }
    }

    var address: EthAddress {
        switch self {
        case .alice:
            return EthAddress("0x00000000000000000000000000000000000A1BC5")
        case .bob:
            return EthAddress("0x00000000000000000000000000000000000B0B0B")
        case .stax:
            return EthAddress("0x7ea8d6119596016935543d90Ee8f5126285060A1")
        case let .unknownAccount(address):
            return address
        }
    }

    static func from(address: EthAddress) -> Account {
        for knownCase in Account.knownCases {
            if address == knownCase.address {
                return knownCase
            }
        }
        return .unknownAccount(address)
    }
}

enum Comet: Equatable {
    case cusdcv3
    case unknownComet(EthAddress)

    static let knownCases: [Comet] = [.cusdcv3]

    func address(network: Network) -> EthAddress {
        switch (network, self) {
        // TODO?: add cases for some more (network, market) pairs?
        // eventually this should be migrated to use builderpack instead.
        case (.ethereum, .cusdcv3):
            return EthAddress("0xc3d688B66703497DAA19211EEdff47f25384cdc3")
        case (_, .unknownComet(address)):
            return address
        }
    }

    var description: String {
        switch self {
        case .cusdcv3:
            return "cUSDCv3"
        case .unknownComet(address):
            return address
        }
    }

    static func from(address: EthAddress) -> Comet {
        for knownNetwork in Network.knownCases {
            for knownCase in Comet.knownCases {
                if address == knownCase.address {
                    return knownCase
                }
            }
        }
        return .unknownComet(address)
    }
}

enum Quote: Hashable, Equatable {
    case basic
    case custom(quoteId: Hex, prices: [Token: Float], fees: [Network: Float])

    static let knownCases: [Quote] = [.basic]

    var params: (quoteId: Hex, prices: [Token: Float], fees: [Network: Float]) {
        switch self {
        case let .custom(quoteId, prices, fees):
            return (quoteId, prices, fees)
        case .basic:
            return (
                Hex("0x00000000000000000000000000000000000000000000000000000000000000CC"),
                [.usdc: 1.0], [.ethereum: 0.10, .base: 0.02, .arbitrum: 0.04]
            )
        }
    }

    var prices: [Token: Float] {
        params.prices
    }

    var fees: [Network: Float] {
        params.fees
    }

    var quoteId: Hex {
        params.quoteId
    }

    static func findQuote(quoteId: Hex, prices: [Token: Float], fees: [Network: Float]) -> Quote {
        for knownCase in Quote.knownCases {
            if knownCase.params.quoteId == quoteId {
                return knownCase
            }
        }
        return .custom(quoteId: quoteId, prices: prices, fees: fees)
    }
}

// TODO: These could come from builder pack
enum Token: Hashable, Equatable {
    case usdc
    case eth
    case unknownToken(EthAddress)

    static let knownCases: [Token] = [.usdc, .eth]
    static let ETHEREUM_USDC_ADDRESS = EthAddress("0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48")
    static let BASE_USDC_ADDRESS = EthAddress("0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913")
    static let ARBITRUM_USDC_ADDRESS = EthAddress("0xaf88d065e77c8cC2239327C5EDb3A432268e5831")
    static let ETHEREUM_ETH_ADDRESS = EthAddress("0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE")

    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }

    var description: String {
        switch self {
        case .usdc:
            return "USDC"
        case .eth:
            return "ETH"
        case let .unknownToken(address):
            return "UnknownToken(\(address.description))"
        }
    }

    func address(network: Network) -> EthAddress {
        switch (network, self) {
        case (.ethereum, .usdc):
            return Token.ETHEREUM_USDC_ADDRESS
        case (.base, .usdc):
            return Token.BASE_USDC_ADDRESS
        case (.arbitrum, .usdc):
            return Token.ARBITRUM_USDC_ADDRESS
        case (_, .eth):
            return Token.ETHEREUM_ETH_ADDRESS
        default:
            customFatalError("Unknown token \(self) for network \(network)")
        }
    }

    static func from(network: Network, address: EthAddress) -> Token {
        switch (network, address) {
        case (.ethereum, Token.ETHEREUM_USDC_ADDRESS):
            return .usdc
        case (.base, Token.BASE_USDC_ADDRESS):
            return .usdc
        case (.arbitrum, Token.ARBITRUM_USDC_ADDRESS):
            return .usdc
        case (.ethereum, Token.ETHEREUM_ETH_ADDRESS):
            return .eth
        default:
            return .unknownToken(address)
        }
    }

    var symbol: String {
        switch self {
        case .usdc:
            return "USDC"
        case .eth:
            return "ETH"
        case let .unknownToken(address):
            return "UnknownToken(\(address.description))"
        }
    }

    var decimals: Int {
        switch self {
        case .usdc:
            return 6
        case .eth:
            return 18
        case .unknownToken:
            return 0
        }
    }

    var usdPrice: Float {
        switch self {
        case .usdc:
            return 1.0
        case .eth:
            return 2000.0
        case .unknownToken:
            return 0
        }
    }

    static func getTokenAmount(amount: BigUInt, network: Network, address: EthAddress) -> TokenAmount {
        let token = Token.from(network: network, address: address)
        return TokenAmount(amount: Float(amount) / pow(10, Float(token.decimals)), token: token)
    }
}

struct TokenAmount: Equatable {
    let amount: Float
    let token: Token

    static func == (lhs: TokenAmount, rhs: TokenAmount) -> Bool {
        return lhs.amount == rhs.amount && lhs.token == rhs.token
    }

    static func amt(_ amount: Float, _ token: Token) -> TokenAmount {
        return TokenAmount(amount: amount, token: token)
    }
}

func toWei(tokenAmount: TokenAmount) -> BigUInt {
    return BigUInt(tokenAmount.amount * pow(10, Float(tokenAmount.token.decimals)))
}

enum Given {
    case tokenBalance(Account, TokenAmount, Network)
    case quote(Quote)
}

enum When {
    case transfer(from: Account, to: Account, amount: TokenAmount, on: Network)
    case cometSupply(from: Account, market: Comet, amount: TokenAmount)

    var sender: Account {
        switch self {
        case let .transfer(from, _, _, _):
            return from
        }
    }
}

enum Expect {
    case revert(QuarkBuilder.RevertReason)
    case single(Call)
}

class AcceptanceTest {
    let name: String
    let given: [Given]
    let when: When
    let expect: Expect
    let only: Bool
    let skip: Bool

    init(
        name: String, given: [Given], when: When, expect: Expect, only: Bool = false,
        skip: Bool = false
    ) {
        self.name = name
        self.given = given
        self.when = when
        self.expect = expect
        self.only = only
        self.skip = skip

        if only, skip {
            fatalError("Cannot set both `only` and `skip` for a test")
        }
    }
}

class Context {
    var chainAccounts: [QuarkBuilder.Accounts.ChainAccounts]
    var prices: [Token: Float]
    var fees: [Network: Float]

    let allNetworks: [Network] = [.ethereum, .base, .arbitrum]

    init(sender: Account) {
        chainAccounts = []
        prices = [:]
        fees = [:]


        let combinations = zip(Token.knownCases.map { a in allNetworks.map { b in (a, b) } }.joined(), 
                      allNetworks.map { b in Token.knownCases.map { a in (a, b) } }.joined())
        for network in allNetworks {
            chainAccounts.append(
                QuarkBuilder.Accounts.ChainAccounts(
                    chainId: BigUInt(network.chainId),
                    quarkSecrets: [
                        .init(
                            account: sender.address,
                            nonceSecret: Hex(
                                "0x5555555555555555555555555555555555555555555555555555555555555555"
                            ))
                    ],
                    assetPositionsList: [],
                    cometPositions: [],
                    morphoPositions: [],
                    morphoVaultPositions: []
                ))
        }
        print(chainAccounts)
    }

    func given(_ given: Given) {
        switch given {
        case let .tokenBalance(account, amount, network):
            // Change chainAccounts to new chainAccounts s.t. `assetPositionsList` has the given token balance where
            // the chainId is the given network.
            let chainId = BigUInt(network.chainId)
            let balance = BigUInt(amount.amount * pow(10, Float(amount.token.decimals)))
            let accountBalances = [
                QuarkBuilder.Accounts.AccountBalance(account: account.address, balance: balance)
            ]
            let assetPositions = QuarkBuilder.Accounts.AssetPositions(
                asset: amount.token.address(network: network),
                symbol: amount.token.symbol,
                decimals: BigUInt(amount.token.decimals),
                usdPrice: BigUInt(amount.token.usdPrice),
                accountBalances: accountBalances
            )
            chainAccounts = chainAccounts.map { chainAccount in
                if chainAccount.chainId == chainId {
                    return QuarkBuilder.Accounts.ChainAccounts(
                        chainId: chainAccount.chainId,
                        quarkSecrets: chainAccount.quarkSecrets,
                        assetPositionsList: chainAccount.assetPositionsList + [assetPositions],
                        cometPositions: chainAccount.cometPositions,
                        morphoPositions: chainAccount.morphoPositions,
                        morphoVaultPositions: chainAccount.morphoVaultPositions
                    )
                }
                return QuarkBuilder.Accounts.ChainAccounts(
                    chainId: chainAccount.chainId,
                    quarkSecrets: chainAccount.quarkSecrets,
                    assetPositionsList: chainAccount.assetPositionsList + [
                        QuarkBuilder.Accounts.AssetPositions(
                            asset: amount.token.address(network: network),
                            symbol: amount.token.symbol,
                            decimals: BigUInt(amount.token.decimals),
                            usdPrice: BigUInt(amount.token.usdPrice),
                            accountBalances: [.init(account: account.address, balance: BigUInt(0))]
                        )
                    ],
                    cometPositions: chainAccount.cometPositions,
                    morphoPositions: chainAccount.morphoPositions,
                    morphoVaultPositions: chainAccount.morphoVaultPositions
                )
            }
        case let .quote(quote):
            prices = quote.prices
            fees = quote.fees
        }
    }

    func when(_ when: When) async throws -> Result<
        QuarkBuilder.QuarkBuilderBase.BuilderResult, QuarkBuilder.RevertReason
    > {
        switch when {
        case let .transfer(from, to, amount, network):
            // dump("ARE THESE HERE? \(chainAccounts)")


            return try await QuarkBuilder.transfer(
                transferIntent: .init(
                    chainId: BigUInt(network.chainId),
                    assetSymbol: amount.token.symbol,
                    amount: toWei(tokenAmount: amount),
                    sender: from.address,
                    recipient: to.address,
                    blockTimestamp: 0,
                    preferAcross: false,
                    paymentAssetSymbol: "USDC"
                ),
                chainAccountsList: chainAccounts,
                quote: .init(
                    quoteId: Hex(
                        "0x00000000000000000000000000000000000000000000000000000000000000CC"),
                    issuedAt: 0,
                    expiresAt: BigUInt(Date(timeIntervalSinceNow: 1_000_000).timeIntervalSince1970),
                    assetQuotes: prices.map {
                        .init(symbol: $0.key.symbol, price: BigUInt($0.value * 1e8))
                    },
                    networkOperationFees: fees.map {
                        .init(
                            chainId: BigUInt($0.key.chainId),
                            opType: "BASELINE",
                            price: BigUInt($0.value * 1e8))
                    }
                ),
                withFunctions: [:]
            )
        }
    }

    func expect(_ expect: Expect) throws {
        print(expect)
    }
}

func customFatalError(_ message: String, file: String = #file, line: Int = #line) -> Never {
    print("Error: \(message)")
    print("Location: \(file):\(line)")
    print("Stack trace:")
    Thread.callStackSymbols.forEach { print($0) }
    fatalError(message)
}

@Test func testCreate2Address() {
    let address = getScriptAddress(Hex("0xaa"))
    #expect(address == EthAddress("0x103B7e61BBaa2F62028Ebf3Ea7C47dC74Bd3a617"))
}

@Test func testAcceptanceTests() async throws {
    let tests = getTests().filter { !$0.skip }
    let filteredTests = tests.contains { $0.only } ? tests.filter { $0.only } : tests

    for test in filteredTests {
        let context = Context(sender: test.when.sender)
        for given in test.given {
            context.given(given)
        }
        let result = try await context.when(test.when)
        switch test.expect {
        case let .revert(revertReason):
            #expect(result == .failure(revertReason))
        case let .single(expectedCall):
            switch result {
            case let .failure(revertReason):
                #expect(
                    revertReason
                        == .unknownRevert(
                            "Unexpected Revert", "Expected \(expectedCall.description)"))
            case let .success(builderResult):
                #expect(builderResult.version == "0.4.1")  // TODO: Check version?
                #expect(builderResult.quarkOperations.count == 1)  // TODO: Check number of operations?
                #expect(builderResult.actions.count == 1)  // TODO: Check number of actions?
                // #expect(builderResult.eip712Data.domainSeparator == EIP712Helper.DomainSeparator(name: "Quark", version: "1")) // TODO: Check domain separator?
                #expect(builderResult.paymentCurrency == "USDC")  // TODO: Check payment currency?

                // TODO: Handle multiple quark operations
                let operation: QuarkBuilder.IQuarkWallet.QuarkOperation =
                    builderResult.quarkOperations[0]
                let action: QuarkBuilder.Actions.Action = builderResult.actions[0]
                let call = Call.tryDecodeCall(
                    scriptAddress: operation.scriptAddress,
                    calldata: operation.scriptCalldata,
                    network: Network.fromChainId(BigInt(action.chainId))
                )
                #expect(call == expectedCall)
            }
        }
    }
}
