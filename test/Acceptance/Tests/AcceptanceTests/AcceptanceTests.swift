@testable import Acceptance
@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation
import Testing

enum Account: String, CaseIterable {
    case alice
    case bob

    var address: EthAddress {
        switch self {
        case .alice:
            return EthAddress("0x00000000000000000000000000000000000A1BC5")
        case .bob:
            return EthAddress("0x00000000000000000000000000000000000B0B0B")
        }
    }
}

enum Token: String, CaseIterable {
    case usdc
    case eth

    func address(network: Network) -> EthAddress? {
        switch (network, self) {
        case (.ethereum, .usdc):
            return EthAddress("0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48")
        case (.ethereum, .eth):
            return EthAddress("0x0000000000000000000000000000000000000000")
        default:
            return nil
        }
    }

    var symbol: String {
        switch self {
        case .usdc:
            return "USDC"
        case .eth:
            return "ETH"
        }
    }

    var decimals: Int {
        switch self {
        case .usdc:
            return 6
        case .eth:
            return 18
        }
    }

    var usdPrice: Float {
        switch self {
        case .usdc:
            return 1.0
        case .eth:
            return 2000.0
        }
    }
}

typealias TokenAmount = (Float, Token)

func toWei(tokenAmount: TokenAmount) -> BigUInt {
    return BigUInt(tokenAmount.0 * pow(10, Float(tokenAmount.1.decimals)))
}

enum Given {
    case tokenBalance(Account, TokenAmount, Network)
    case quote(prices: [Token: Float], fees: [Network: Float])
}

enum When {
    case transfer(from: Account, to: Account, amount: TokenAmount, on: Network)
}

typealias ContractCall = (String, String, ABI.Value)

enum Call {
    case transferErc20(tokenAmount: TokenAmount, recipient: Account)

    var asContractCall: ContractCall {
        switch self {
        case let .transferErc20 (tokenAmount, recipient):
            return ("TransferActions", TransferActions.transferERC20TokenFn.description, .tuple3(.address(tokenAmount.1.address(network: .ethereum)!), .address(recipient.address), .uint256(toWei(tokenAmount: tokenAmount))))
        }
    }
}

func tryDecodeCall(scriptSource: Hex, calldata: Hex) -> ContractCall? {
    if scriptSource == TransferActions.creationCode {
        for function in TransferActions.functions {
            let decoded = try function.decode(calldata)
            if decoded.name == "transferERC20Token" {
                return (function.name, function.description, decoded.inputs)
            }
        }
    }
    return nil
}

enum Expect {
    case revert(QuarkBuilder.RevertReason)
    case call(Call)
}

class AcceptanceTest {
    let name: String
    let given: [Given]
    let when: When
    let expect: Expect

    init(name: String, given: [Given], when: When, expect: Expect) {
        self.name = name
        self.given = given
        self.when = when
        self.expect = expect
    }
}

class Context {
    var chainAccounts: [QuarkBuilder.Accounts.ChainAccounts]

    let allNetworks: [Network] = [.ethereum, .base, .arbitrum]

    init() {
        chainAccounts = []
        for network in allNetworks {
            for account in Account.allCases {
                chainAccounts.append(QuarkBuilder.Accounts.ChainAccounts(
                    chainId: BigUInt(network.chainId),
                    quarkSecrets: [.init(account: account.address, nonceSecret: Hex("0x5555555555555555555555555555555555555555555555555555555555555555"))],
                    assetPositionsList: [],
                    cometPositions: [],
                    morphoPositions: [],
                    morphoVaultPositions: []
                ))
            }
        }
    }

    func given(_ given: Given) {
        switch given {
        case let .tokenBalance(account, amount, network):
            // Change chainAccounts to new chainAccounts s.t. `assetPositionsList` has the given token balance where
            // the chainId is the given network.
            let chainId = BigUInt(network.chainId)
            let balance = BigUInt(amount.0 * pow(10, Float(amount.1.decimals)))
            let accountBalances = [QuarkBuilder.Accounts.AccountBalance(account: account.address, balance: balance)]
            let assetPositions = QuarkBuilder.Accounts.AssetPositions(
                asset: amount.1.address(network: network)!,
                symbol: amount.1.symbol,
                decimals: BigUInt(amount.1.decimals),
                usdPrice: BigUInt(amount.1.usdPrice),
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
                return chainAccount
            }
        case let .quote(prices, fees):
            print(prices, fees)
        }
    }

    func when(_ when: When) async throws -> Result<QuarkBuilder.QuarkBuilderBase.BuilderResult, QuarkBuilder.RevertReason> {
        print(when)
        switch when {
        case let .transfer(from, to, amount, network):
            return try await QuarkBuilder.transfer(
                transferIntent: .init(
                    chainId: BigUInt(network.chainId),
                    assetSymbol: amount.1.symbol,
                    amount: toWei(tokenAmount: amount),
                    sender: from.address,
                    recipient: to.address,
                    blockTimestamp: 0,
                    preferAcross: false
                ),
                chainAccountsList: chainAccounts,
                payment: .init(isToken: false, currency: "ETH", maxCosts: []),
                withFunctions: [:]
            )
        }
    }

    func expect(_ expect: Expect) throws {
        print(expect)
    }
}

func getTests() -> [AcceptanceTest] {
    return [
        AcceptanceTest(
            name: "Alice transfers 10 USDC to Bob on Ethereum",
            given: [.tokenBalance(.alice, (100, .usdc), .ethereum)],
            when: .transfer(from: .alice, to: .bob, amount: (10, .usdc), on: .ethereum),
            expect: .call(.transferErc20(tokenAmount: (10, .usdc), recipient: .bob))
        ),
    ]
}

@Test func example() async throws {
    let tests = getTests()
    for test in tests {
        let context = Context()
        for given in test.given {
            context.given(given)
        }
        case let .revert(revertReason):
            #expect(result == .failure(revertReason))
        case let .call(call):
            switch result {
            case .failure:
                #expect(false, "Expected success, got failure")
            case let .success(builderResult):
                #expect(builderResult == Acceptance.QuarkBuilder.QuarkBuilderBase.BuilderResult(
                    scriptSource: TransferActions.creationCode,
                    calldata: call.asContractCall.2.encode()
                )
            )
        }

        let result = try await context.when(test.when)
        
    }
}
