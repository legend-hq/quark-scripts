@testable import Acceptance
@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation
import SwiftKeccak
import Testing

let allTests: [AcceptanceTest] = [
    .init(
        name: "Alice transfers 10 USDC to Bob on Ethereum",
        given: [
            .tokenBalance(.alice, .amt(100, .usdc), .ethereum),
            .quote(.basic),
        ],
        when: .transfer(from: .alice, to: .bob, amount: .amt(10, .usdc), on: .ethereum),
        expect: .success(
            .single(
                .multicall([
                    .transferErc20(tokenAmount: .amt(10, .usdc), recipient: .bob),
                    .quotePay(payment: .amt(0.10, .usdc), payee: .stax, quote: .basic),
                ])))
    ),
    .init(
        name: "Alice transfers 10 USDC to Bob on Arbitrum",
        given: [
            .tokenBalance(.alice, .amt(100, .usdc), .arbitrum),
            .quote(.basic),
        ],
        when: .transfer(from: .alice, to: .bob, amount: .amt(10, .usdc), on: .arbitrum),
        expect: .success(
            .single(
                .multicall([
                    .transferErc20(tokenAmount: .amt(10, .usdc), recipient: .bob),
                    .quotePay(payment: .amt(0.04, .usdc), payee: .stax, quote: .basic),
                ])))
    ),
    .init(
        name: "Alice transfers MAX USDC to Bob on Arbitrum",
        given: [
            .tokenBalance(.alice, .amt(100, .usdc), .arbitrum),
            .quote(.basic),
        ],
        when: .transfer(from: .alice, to: .bob, amount: .amt(100, .usdc), on: .arbitrum),
        expect: .revert(
            .unableToConstructQuotePay(
                Token.usdc.symbol,
                toWei(tokenAmount: TokenAmount.amt(0.04, .usdc))
            )
        )
    ),
    .init(
        name: "Alice transfers MAX USDC to Bob on Arbitrum via Bridge",
        given: [
            .tokenBalance(.alice, .amt(50, .usdc), .arbitrum),
            .tokenBalance(.alice, .amt(50, .usdc), .base),
            .quote(.basic),
        ],
        when: .transfer(from: .alice, to: .bob, amount: .amt(100, .usdc), on: .arbitrum),
        expect: .revert(
            .unableToConstructQuotePay(
                Token.usdc.symbol,
                toWei(tokenAmount: TokenAmount.amt(0.06, .usdc))
            )
        )
    ),
    .init(
        name: "Alice supplies 0.5 WETH to cUSDCv3 on Ethereum",
        given: [
            .tokenBalance(.alice, .amt(1.0, .weth), .ethereum),
            .quote(.basic),
        ],
        when: .payWith(
            currency: .weth,
            .cometSupply(from: .alice, market: .cusdcv3, amount: .amt(0.5, .weth), on: .ethereum)
        ),
        expect: .success(.single(
            .multicall([
                .supplyToComet(tokenAmount: .amt(0.5, .weth), market: .cusdcv3, network: .ethereum),
                .quotePay(payment: .amt(0.000025000001, .weth), payee: .stax, quote: .basic),
            ]))
        )
    ),
    // @skip: Alice cannot supply ETH to comet because Actions.cometSupply doesn't wrap ETH
    .init(
        name: "Alice supplies 0.5 ETH to cUSDCv3 on Ethereum",
        given: [
            .tokenBalance(.alice, .amt(1.0, .eth), .ethereum),
            .quote(.basic),
        ],
        when: .payWith(
            currency: .eth,
            .cometSupply(from: .alice, market: .cusdcv3, amount: .amt(0.5, .eth), on: .ethereum)
        ),
        expect: .success(.single(
            .multicall([
                .supplyToComet(tokenAmount: .amt(0.5, .eth), market: .cusdcv3, network: .ethereum),
                .quotePay(payment: .amt(0.000025000001, .eth), payee: .stax, quote: .basic),
            ]))
        ),
        skip: true
    ),
    .init(
        name: "WIP: Alice repays 75 USDC of a 100 USDC borrow against 0.3 WETH on cUSDCv3 on Ethereum",
        given: [
            .tokenBalance(.alice, .amt(0.5, .weth), .ethereum),
            .cometPositions(.cusdcv3, .ethereum, [
                .supplied(.alice, .amt(0.3, .weth)),
                .supplied(.alice, .amt(0.1, .weth)),
                .borrowed(.alice, .amt(100, .usdc)),
            ]),
            .quote(.basic),
        ],
        when: .transfer(from: .alice, to: .bob, amount: .amt(50, .usdc), on: .arbitrum),
        // FIXME: this should not revert! borrowed funds should be added to token balance
        expect: .revert(
            .fundsUnavailable(
                Token.usdc.symbol,
                toWei(tokenAmount: .amt(50, .usdc)),
                toWei(tokenAmount: .amt(0, .usdc))
            )
        )
    ),
]

let tests = allTests.filter { !$0.skip }
let filteredTests = tests.contains { $0.only } ? tests.filter { $0.only } : tests

enum Call: CustomStringConvertible, Equatable {
    case bridge(bridge: String, srcNetwork: Network, destinationNetwork: Network, tokenAmount: TokenAmount)
    case transferErc20(tokenAmount: TokenAmount, recipient: Account)
    case supplyToComet(tokenAmount: TokenAmount, market: Comet, network: Network)
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
            if let (
                _,
                _,
                _,
                inputToken,
                _,
                inputAmount,
                _,
                destinationChainId,
                _,
                _,
                _,
                _,
                _,
                _
            ) = try? AcrossActions.depositV3Decode(input: calldata) {
                return .bridge(
                    bridge: "Across",
                    srcNetwork: network,
                    destinationNetwork: Network.fromChainId(BigInt(destinationChainId)),
                    tokenAmount: Token.getTokenAmount(
                        amount: inputAmount,
                        network: network,
                        address: inputToken
                    )
                )
            }
        }

        if scriptAddress == getScriptAddress(TransferActions.creationCode) {
            if let (token, recipient, amount) = try? TransferActions.transferERC20TokenDecode(input: calldata) {
                return .transferErc20(tokenAmount: Token.getTokenAmount(amount: amount, network: network, address: token), recipient: Account.from(address: recipient))
            }
        }

        if scriptAddress == getScriptAddress(QuotePay.creationCode) {
            if let (payee, paymentToken, quotedAmount, quoteId) = try? QuotePay.payDecode(input: calldata) {
                return .quotePay(payment: Token.getTokenAmount(amount: quotedAmount, network: network, address: paymentToken), payee: Account.from(address: payee), quote: Quote.findQuote(quoteId: quoteId, prices: [:], fees: [:]))
            }
        }

        if scriptAddress == getScriptAddress(Multicall.creationCode) {
            if let (callContracts, callDatas) = try? Multicall.runDecode(input: calldata) {
                let calls = zip(callContracts, callDatas).map { Call.tryDecodeCall(scriptAddress: $0, calldata: $1, network: network) }
                return .multicall(calls)
            }
        }

        if scriptAddress == getScriptAddress(CometSupplyActions.creationCode) {
            if let (comet, asset, amount) = try? CometSupplyActions.supplyDecode(input: calldata) {
                return .supplyToComet(
                    tokenAmount: Token.getTokenAmount(amount: amount, network: network, address: asset),
                    market: Comet.from(network: network, address: comet),
                    network: network
                )
            } else if let (comet, to, asset, amount) = try? CometSupplyActions.supplyToDecode(input: calldata) {
                print("supplyTo(\(comet) to: \(to) \(asset) \(amount))")
            } else if let (comet, from, to, asset, amount) = try? CometSupplyActions.supplyFromDecode(input: calldata) {
                print("supplyFrom(\(comet) from: \(from) to: \(to) \(asset) \(amount))")
            } else if let (comet, assets, amounts) = try? CometSupplyActions.supplyMultipleAssetsDecode(input: calldata) {
                print("supplyMultipleAssets(\(comet) \(assets) \(amounts))")
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
        case let .supplyToComet(tokenAmount, market, network):
            return
                "supplyToComet(\(tokenAmount.amount) \(tokenAmount.token.symbol) to \(market.description) on \(network.description))"
        case let .multicall(calls):
            return "multicall(\(calls.map { $0.description }.joined(separator: ", ")))"
        case let .unknownFunctionCall(name, function, value):
            return "unknownFunctionCall(\(name), \(function), \(value))"
        case let .unknownScriptCall(scriptSource, calldata):
            return "unknownScriptCall(\(scriptSource.description), \(calldata.description))"
        }
    }

    var descriptionExt: String {
        switch self {
        case let .multicall(calls):
            return "multicall:\n\(calls.map { "\n\t\t- \($0.descriptionExt)" }.joined(separator: "\n"))\n"
        default:
            return description
        }
    }
}

extension Array where Element == Call {
    var descriptionExt: String {
        if count == 1 {
            return self[0].descriptionExt
        } else {
            return "multicall:\n\(map { "\n\t\t- \($0.descriptionExt)" }.joined(separator: "\n"))\n"
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
    packed.append(Data([0xFF])) // prefix byte
    packed.append(codeJarAddress.data) // deploying address
    packed.append(Data(repeating: 0, count: 32)) // salt
    packed.append(SwiftKeccak.keccak256(creationCode.data)) // hash of init code

    // Take keccak256 hash and extract last 20 bytes for address
    let hash = SwiftKeccak.keccak256(packed)
    return EthAddress(Hex(hash.subdata(in: 12 ..< 32)))!
}

enum Account: Hashable, Equatable {
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

enum Comet: Hashable, Equatable {
    case cusdcv3
    case unknownComet(EthAddress)

    enum Given {
        case supplied(Account, TokenAmount)
        case borrowed(Account, TokenAmount)
    }

    static let knownCases: [Comet] = [.cusdcv3]

    func address(network: Network) -> EthAddress {
        switch (network, self) {
        // TODO?: add cases for some more (network, market) pairs?
        // eventually this should be migrated to use builderpack instead.
        case (.ethereum, .cusdcv3):
            return EthAddress("0xc3d688B66703497DAA19211EEdff47f25384cdc3")
        case (_, .cusdcv3):
            fatalError("no market .cusdcv3 for network \(network.description)")
        case let (_, .unknownComet(address)):
            return address
        }
    }

    var baseAsset: Token {
        switch self {
        case .cusdcv3: return .usdc
        case .unknownComet: return .unknownToken("0x0000000000000000000000000000000000000000")
        }
    }

    var description: String {
        switch self {
        case .cusdcv3:
            return "cUSDCv3"
        case let .unknownComet(address):
            return "Comet at \(address.description)"
        }
    }

    static func from(network: Network, address: EthAddress) -> Comet {
        switch (network, address) {
        case (.ethereum, "0xc3d688B66703497DAA19211EEdff47f25384cdc3"):
            return .cusdcv3
        case _:
            return .unknownComet(address)
        }
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
                Dictionary(
                    uniqueKeysWithValues: Token.knownCases.map { token in
                        (token, token.defaultUsdPrice)
                    }
                ),
                [
                    .ethereum: 0.10,
                    .base: 0.02,
                    .arbitrum: 0.04,
                ]
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

// TODO: These should come from builder pack
enum Token: Hashable, Equatable {
    case usdc
    case eth
    case weth
    case unknownToken(EthAddress)

    static let knownCases: [Token] = [.usdc, .eth, .weth]

    static let networkTokenAddress: [Network: [Token: EthAddress]] = [
        .ethereum: [
            .eth: EthAddress("0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE"),
            .weth: EthAddress("0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"),
            .usdc: EthAddress("0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"),
        ],
        .base: [
            .eth: EthAddress("0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE"),
            .weth: EthAddress("0x4200000000000000000000000000000000000006"),
            .usdc: EthAddress("0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913"),
        ],
        .arbitrum: [
            .eth: EthAddress("0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE"),
            .weth: EthAddress("0x82aF49447D8a07e3bd95BD0d56f35241523fBab1"),
            .usdc: EthAddress("0xaf88d065e77c8cC2239327C5EDb3A432268e5831"),
        ],
    ]

    static var networkAddressToken: [Network: [EthAddress: Token]] {
        networkTokenAddress.mapValues { tokenMap in
            Dictionary(uniqueKeysWithValues: tokenMap.map { ($0.value, $0.key) })
        }
    }

    static func from(network: Network, address: EthAddress) -> Token {
        if let token = Token.networkAddressToken[network]?[address] {
            return token
        } else {
            return .unknownToken(address)
        }
    }

    static func getTokenAmount(amount: BigUInt, network: Network, address: EthAddress)
        -> TokenAmount
    {
        let token = Token.from(network: network, address: address)
        return TokenAmount(amount: Float(amount) / pow(10, Float(token.decimals)), token: token)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }

    var symbol: String {
        switch self {
        case .usdc:
            return "USDC"
        case .eth:
            return "ETH"
        case .weth:
            return "WETH"
        case let .unknownToken(address):
            return "UnknownToken(\(address.description))"
        }
    }

    var decimals: Int {
        switch self {
        case .usdc:
            return 6
        case .eth, .weth:
            return 18
        case .unknownToken:
            return 0
        }
    }

    var defaultUsdPrice: Float {
        switch self {
        case .usdc:
            return 1.0
        case .eth, .weth:
            return 4000.0
        case .unknownToken:
            return 0
        }
    }

    var description: String {
        return symbol
    }

    func address(network: Network) -> EthAddress {
        if let address = Token.networkTokenAddress[network]?[self] {
            return address
        } else {
            customFatalError("Unknown token \(self) for network \(network)")
        }
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
    case cometPositions(Comet, Network, [Comet.Given])
}

indirect enum When {
    case transfer(from: Account, to: Account, amount: TokenAmount, on: Network)
    case cometSupply(from: Account, market: Comet, amount: TokenAmount, on: Network)
    case payWith(currency: Token, When)

    var sender: Account {
        switch self {
        case let .transfer(from, _, _, _):
            return from
        case let .cometSupply(from, _, _, _):
            return from
        case let .payWith(_, intent):
            return intent.sender
        }
    }

    var paymentAssetSymbol: String {
        switch self {
        case let .payWith(token, _):
            return token.symbol
        case _:
            return "USDC"
        }
    }
}

enum CallExpect {
    case single(Call)
    case multi([Call])
}

enum Expect {
    case revert(QuarkBuilder.RevertReason)
    case success(CallExpect)
}

final class AcceptanceTest: CustomTestArgumentEncodable, CustomStringConvertible, Sendable {
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

    func encodeTestArgument(to encoder: some Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(name)
    }

    var description: String {
        return name
    }
}

class Context {
    var chainAccounts: [QuarkBuilder.Accounts.ChainAccounts]
    var prices: [Token: Float]
    var fees: [Network: Float]
    var paymentToken: Token?
    var cometPositionsIsh: [Comet: [Network: [Account: [Token: Float]]]]

    let allNetworks: [Network] = [.ethereum, .base, .arbitrum]

    init(sender: Account) {
        chainAccounts = []
        prices = [:]
        fees = [:]
        paymentToken = .none
        cometPositionsIsh = [:]

        for network in allNetworks {
            let assetPositionsList: [QuarkBuilder.Accounts.AssetPositions] = Token.knownCases.map {
                token in
                QuarkBuilder.Accounts.AssetPositions(
                    asset: token.address(network: network),
                    symbol: token.symbol,
                    decimals: BigUInt(token.decimals),
                    usdPrice: BigUInt(token.defaultUsdPrice),
                    accountBalances: [
                        QuarkBuilder.Accounts.AccountBalance(
                            account: sender.address, balance: BigUInt(0)
                        ),
                    ]
                )
            }

            chainAccounts.append(
                QuarkBuilder.Accounts.ChainAccounts(
                    chainId: BigUInt(network.chainId),
                    quarkSecrets: [
                        .init(
                            account: sender.address,
                            nonceSecret: Hex(
                                "0x5555555555555555555555555555555555555555555555555555555555555555"
                            )
                        ),
                    ],
                    assetPositionsList: assetPositionsList,
                    cometPositions: [],
                    morphoPositions: [],
                    morphoVaultPositions: []
                ))
        }
    }

    func given(_ given: Given) {
        switch given {
        case let .tokenBalance(account, amount, network):
            // Change chainAccounts to new chainAccounts s.t. `assetPositionsList` has the given token balance where
            // the chainId is the given network.
            let chainId = BigUInt(network.chainId)
            let balance = BigUInt(amount.amount * pow(10, Float(amount.token.decimals)))
            chainAccounts = chainAccounts.map { chainAccount in
                if chainAccount.chainId == chainId {
                    return QuarkBuilder.Accounts.ChainAccounts(
                        chainId: chainAccount.chainId,
                        quarkSecrets: chainAccount.quarkSecrets,
                        assetPositionsList: chainAccount.assetPositionsList.map { assetPosition in
                            if assetPosition.asset == amount.token.address(network: network) {
                                return QuarkBuilder.Accounts.AssetPositions(
                                    asset: amount.token.address(network: network),
                                    symbol: amount.token.symbol,
                                    decimals: BigUInt(amount.token.decimals),
                                    usdPrice: BigUInt(amount.token.defaultUsdPrice),
                                    accountBalances: assetPosition.accountBalances.map {
                                        $0.account == account.address
                                            ? QuarkBuilder.Accounts.AccountBalance(
                                                account: account.address,
                                                balance: balance
                                            )
                                            : $0
                                    }
                                )
                            }
                            return assetPosition
                        },
                        cometPositions: chainAccount.cometPositions,
                        morphoPositions: chainAccount.morphoPositions,
                        morphoVaultPositions: chainAccount.morphoVaultPositions
                    )
                }
                return chainAccount
            }
        case let .cometPositions(comet, network, positionParts):
            let cometPositions = cometPositionsIsh[comet]
            if cometPositions == nil {
                cometPositionsIsh[comet] = [:]
            }
            let networkPositions = cometPositionsIsh[comet]![network]
            if networkPositions == nil {
                cometPositionsIsh[comet]![network] = [:]
            }
            for part in positionParts {
                switch part {
                case let .supplied(account, tokenAmount):
                    let cometAccountPositions = cometPositionsIsh[comet]![network]![account]
                    if cometAccountPositions == nil {
                        cometPositionsIsh[comet]![network]![account] = [:]
                    }
                    if cometPositionsIsh[comet]![network]![account]![tokenAmount.token] != nil {
                        cometPositionsIsh[comet]![network]![account]![tokenAmount.token]! += tokenAmount.amount
                    } else {
                        cometPositionsIsh[comet]![network]![account]![tokenAmount.token] = tokenAmount.amount
                    }
                case let .borrowed(account, tokenAmount):
                    let cometAccountPositions = cometPositionsIsh[comet]![network]![account]
                    if cometAccountPositions == nil {
                        cometPositionsIsh[comet]![network]![account] = [:]
                    }
                    if cometPositionsIsh[comet]![network]![account]![tokenAmount.token] != nil {
                        cometPositionsIsh[comet]![network]![account]![tokenAmount.token]! -= tokenAmount.amount
                    } else {
                        cometPositionsIsh[comet]![network]![account]![tokenAmount.token] = -1.0 * tokenAmount.amount
                    }
                }
            }
        case let .quote(quote):
            prices = quote.prices
            fees = quote.fees
        }
    }

    func when(_ when: When) async throws -> Result<
        QuarkBuilder.QuarkBuilderBase.BuilderResult, QuarkBuilder.RevertReason
    > {
        chainAccounts = chainAccounts.map { chainAccount in
            QuarkBuilder.Accounts.ChainAccounts(
                chainId: chainAccount.chainId,
                quarkSecrets: chainAccount.quarkSecrets,
                assetPositionsList: chainAccount.assetPositionsList,
                cometPositions: reifyCometPositions(cometPositionsIsh),
                morphoPositions: chainAccount.morphoPositions,
                morphoVaultPositions: chainAccount.morphoVaultPositions
            )
        }
        switch when {
        case let .payWith(token, intent):
            paymentToken = token
            return try await self.when(intent)

        case let .cometSupply(from, market, amount, network):
            return try await QuarkBuilder.cometSupply(
                cometSupplyIntent: .init(
                    amount: toWei(tokenAmount: amount),
                    assetSymbol: amount.token.symbol,
                    blockTimestamp: 0,
                    chainId: BigUInt(network.chainId),
                    comet: market.address(network: network),
                    sender: from.address,
                    preferAcross: false,
                    paymentAssetSymbol: paymentToken?.symbol ?? when.paymentAssetSymbol
                ),
                chainAccountsList: chainAccounts,
                quote: .init(
                    quoteId: Hex("0x00000000000000000000000000000000000000000000000000000000000000CC"),
                    issuedAt: 0,
                    expiresAt: BigUInt(Date(timeIntervalSinceNow: 1_000_000).timeIntervalSince1970),
                    assetQuotes: prices.map {
                        .init(symbol: $0.key.symbol, price: BigUInt($0.value * 1e8))
                    },
                    networkOperationFees: fees.map {
                        .init(
                            chainId: BigUInt($0.key.chainId),
                            opType: "BASELINE",
                            price: BigUInt($0.value * 1e8)
                        )
                    }
                )
            )

        case let .transfer(from, to, amount, network):
            return try await QuarkBuilder.transfer(
                transferIntent: .init(
                    chainId: BigUInt(network.chainId),
                    assetSymbol: amount.token.symbol,
                    amount: toWei(tokenAmount: amount),
                    sender: from.address,
                    recipient: to.address,
                    blockTimestamp: 0,
                    preferAcross: false,
                    paymentAssetSymbol: paymentToken?.symbol ?? when.paymentAssetSymbol
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
                            price: BigUInt($0.value * 1e8)
                        )
                    }
                ),
                withFunctions: [:]
            )
        }
    }
}

func reifyCometPositions(_ cometPositionsIsh: [Comet: [Network: [Account: [Token: Float]]]]) -> [QuarkBuilder.Accounts.CometPositions] {
    var cometPositionsList: [QuarkBuilder.Accounts.CometPositions] = []
    for (comet, networkPositions) in cometPositionsIsh {
        for (network, accountPositions) in networkPositions {
            var accounts: [EthAddress] = []
            var supplied: [TokenAmount] = []
            var borrowed: [TokenAmount] = []
            var balances: [Token: [TokenAmount]] = [:]
            for (account, tokenPositions) in accountPositions {
                accounts.append(account.address)
                supplied.append(.amt(0, comet.baseAsset))
                borrowed.append(.amt(0, comet.baseAsset))
                for (token, amount) in tokenPositions {
                    if balances[token] == nil {
                        balances[token] = Array(repeating: .amt(0, token), count: accounts.count)
                    } else {
                        balances[token]!.append(.amt(0, token))
                    }
                    //
                    if token == comet.baseAsset {
                        if amount >= 0 {
                            supplied[accounts.count - 1] = .amt(amount, token)
                        } else {
                            borrowed[accounts.count - 1] = .amt(amount * -1.0, token)
                        }
                    } else {
                        balances[token]![accounts.count - 1] = .amt(amount, token)
                    }
                }
            }
            cometPositionsList.append(QuarkBuilder.Accounts.CometPositions(
                comet: comet.address(network: network),
                basePosition: QuarkBuilder.Accounts.CometBasePosition(
                    asset: comet.baseAsset.address(network: network),
                    accounts: accounts,
                    borrowed: borrowed.map { tokenAmount in toWei(tokenAmount: tokenAmount) },
                    supplied: supplied.map { tokenAmount in toWei(tokenAmount: tokenAmount) }
                ),
                collateralPositions: balances.reduce([]) { positions, pair in
                    let (_, tokenAmounts) = pair
                    return positions + [QuarkBuilder.Accounts.CometCollateralPosition(
                        asset: tokenAmounts[0].token.address(network: network),
                        accounts: accounts,
                        balances: tokenAmounts.map { tokenAmount in
                            toWei(tokenAmount: tokenAmount)
                        }
                    )]
                }
            ))
        }
    }
    return cometPositionsList
}

enum ANSIColor: String {
    case red = "\u{001B}[31m"
    case green = "\u{001B}[32m"
    case yellow = "\u{001B}[33m"
    case blue = "\u{001B}[34m"
    case reset = "\u{001B}[0m"
}

func colorize(_ text: String, with color: ANSIColor) -> String {
    return "\(color.rawValue)\(text)\(ANSIColor.reset.rawValue)"
}

func customFatalError(_ message: String, file: String = #file, line: Int = #line) -> Never {
    print("Error: \(message)")
    print("Location: \(file):\(line)")
    print("Stack trace:")
    Thread.callStackSymbols.forEach { print($0) }
    fatalError(message)
}

func buildResultToCalls(builderResult: QuarkBuilder.QuarkBuilderBase.BuilderResult) -> [Call] {
    return zip(builderResult.quarkOperations, builderResult.actions).map { operation, action in
        Call.tryDecodeCall(scriptAddress: operation.scriptAddress, calldata: operation.scriptCalldata, network: Network.fromChainId(BigInt(action.chainId)))
    }
}

@Test func testCreate2Address() {
    let address = getScriptAddress(Hex("0xaa"))
    #expect(address == EthAddress("0x103B7e61BBaa2F62028Ebf3Ea7C47dC74Bd3a617"))
}

@Test("Acceptance Tests", arguments: filteredTests)
func testAcceptanceTests(test: AcceptanceTest) async throws {
    let context = Context(sender: test.when.sender)
    for given in test.given {
        context.given(given)
    }
    let result: Result<QuarkBuilder.QuarkBuilderBase.BuilderResult, QuarkBuilder.RevertReason>
    do {
        result = try await context.when(test.when)
    } catch let queryError as EVM.QueryError {
        result = .failure(QuarkBuilder.RevertReason.unknownRevert("QueryError", String(describing: queryError)))
    }

    switch (test.expect, result) {
    case let (.revert(expectedRevertReason), .failure(revertReason)):
        #expect(revertReason == expectedRevertReason, "\n\(colorize("Expected Revert:", with: .yellow))\n\t\(colorize(String(describing: expectedRevertReason), with: .reset))\n\n\n\(colorize("Quark Builder Result:", with: .yellow))\n\t\(colorize(String(describing: revertReason), with: .reset))\n\n")
    case let (.revert(expectedRevertReason), .success(builderResult)):
        let calls = buildResultToCalls(builderResult: builderResult)
        #expect(Bool(false), "\n\(colorize("Expected Revert:", with: .yellow))\n\t\(colorize(String(describing: expectedRevertReason), with: .reset))\n\n\n\(colorize("Quark Builder Result:", with: .yellow))\n\t\(calls.descriptionExt)\n\n")
    case let (.success(callExpect), .failure(revertReason)):
        let expectedCalls = switch callExpect {
        case let .single(expectedCall):
            [expectedCall]
        case let .multi(expectedCalls):
            expectedCalls
        }

        #expect(Bool(false), "\n\(colorize("Expected Result:", with: .yellow))\n\t\(expectedCalls.descriptionExt)\n\n\n\(colorize("Quark Builder Failure:", with: .yellow))\n\t\(colorize(String(describing: revertReason), with: .red))\n\n")
    case let (.success(callExpect), .success(builderResult)):
        // #expect(builderResult.eip712Data.domainSeparator == EIP712Helper.DomainSeparator(name: "Quark", version: "1")) // TODO: Check domain separator?
        // #expect(builderResult.paymentCurrency == "USDC") // TODO: Check payment currency?

        let calls = buildResultToCalls(builderResult: builderResult)
        let expectedCalls = switch callExpect {
        case let .single(expectedCall):
            [expectedCall]
        case let .multi(expectedCalls):
            expectedCalls
        }
        #expect(expectedCalls == calls, "\n\(colorize("Expected Result:", with: .yellow))\n\t\(expectedCalls.descriptionExt)\n\n\n\(colorize("Quark Builder Result:", with: .yellow))\n\t\(calls.descriptionExt)\n\n")
    }
}