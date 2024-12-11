@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum CometClaimRewards {
    public static let creationCode: Hex = "0x608080604052346015576101d5908161001a8239f35b5f80fdfe60806040526004361015610011575f80fd5b5f3560e01c637a53b63714610024575f80fd5b346101595760603660031901126101595760043567ffffffffffffffff81116101595761005590369060040161016c565b60243567ffffffffffffffff81116101595761007590369060040161016c565b90926044356001600160a01b0381169291908390036101595781840361015d575f5b8481106100a057005b6001600160a01b036100bb6100b683888661019d565b6101c1565b16906100cb6100b682868a61019d565b823b1561015957604051635b81a7bf60e11b81526001600160a01b0390911660048201526024810186905260016044820152915f908390606490829084905af1801561014e57610120575b6001915001610097565b67ffffffffffffffff821161013a57600191604052610116565b634e487b7160e01b5f52604160045260245ffd5b6040513d5f823e3d90fd5b5f80fd5b63b4fa3fb360e01b5f5260045ffd5b9181601f840112156101595782359167ffffffffffffffff8311610159576020808501948460051b01011161015957565b91908110156101ad5760051b0190565b634e487b7160e01b5f52603260045260245ffd5b356001600160a01b0381168103610159579056"
    public static let runtimeCode: Hex = "0x60806040526004361015610011575f80fd5b5f3560e01c637a53b63714610024575f80fd5b346101595760603660031901126101595760043567ffffffffffffffff81116101595761005590369060040161016c565b60243567ffffffffffffffff81116101595761007590369060040161016c565b90926044356001600160a01b0381169291908390036101595781840361015d575f5b8481106100a057005b6001600160a01b036100bb6100b683888661019d565b6101c1565b16906100cb6100b682868a61019d565b823b1561015957604051635b81a7bf60e11b81526001600160a01b0390911660048201526024810186905260016044820152915f908390606490829084905af1801561014e57610120575b6001915001610097565b67ffffffffffffffff821161013a57600191604052610116565b634e487b7160e01b5f52604160045260245ffd5b6040513d5f823e3d90fd5b5f80fd5b63b4fa3fb360e01b5f5260045ffd5b9181601f840112156101595782359167ffffffffffffffff8311610159576020808501948460051b01011161015957565b91908110156101ad5760051b0190565b634e487b7160e01b5f52603260045260245ffd5b356001600160a01b0381168103610159579056"

    public static let InvalidInputError = ABI.Function(
            name: "InvalidInput",
            inputs: []
    )


    public enum RevertReason : Equatable, Error {
        case invalidInput
        case unknownRevert(String, String)
    }
    public static func rewrapError(_ error: ABI.Function, value: ABI.Value) -> RevertReason {
        switch (error, value) {
        case (InvalidInputError, _):
            return .invalidInput
            case let (e, v):
            return .unknownRevert(e.name, String(describing: v))
            }
    }
    public static let errors: [ABI.Function] = [InvalidInputError]
    public static let functions: [ABI.Function] = [claimFn]
    public static let claimFn = ABI.Function(
            name: "claim",
            inputs: [.array(.address), .array(.address), .address],
            outputs: []
    )

    public static func claim(cometRewards: [EthAddress], comets: [EthAddress], recipient: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<(), RevertReason> {
            do {
                let query = try claimFn.encoded(with: [.array(.address, cometRewards.map {
                                    .address($0)
                                }), .array(.address, comets.map {
                                    .address($0)
                                }), .address(recipient)])
                let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                let decoded = try claimFn.decode(output: result)

                switch decoded {
                case  .tuple0:
                    return .success(())
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, claimFn.outputTuple)
                }
            } catch let EVM.QueryError.error(e, v) {
                return .failure(rewrapError(e, value: v))
            }
    }


    public static func claimDecode(input: Hex) throws -> ([EthAddress], [EthAddress], EthAddress) {
        let decodedInput = try claimFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple3(.array(.address, cometRewards), .array(.address, comets), .address(recipient)):
            return  (cometRewards.map { $0.asEthAddress! }, comets.map { $0.asEthAddress! }, recipient)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, claimFn.inputTuple)
        }
    }

    }