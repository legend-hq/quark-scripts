@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum Multicall {
    public static let creationCode: Hex = "0x60a080604052346021573060805261038d9081610026823960805181607a0152f35b5f80fdfe60806040526004361015610011575f80fd5b5f3560e01c634d618e3b14610024575f80fd5b3461027b57604036600319011261027b5760043567ffffffffffffffff811161027b576100559036906004016102c2565b9060243567ffffffffffffffff811161027b576100769036906004016102c2565b92307f00000000000000000000000000000000000000000000000000000000000000006001600160a01b0316146102b3578381036102a4576100bf6100ba8261033d565b610317565b81815293601f196100cf8361033d565b015f5b81811061029357505036839003601e19015f5b83811061015357866040518091602082016020835281518091526040830190602060408260051b8601019301915f905b82821061012457505050500390f35b919360019193955060206101438192603f198a820301865288516102f3565b9601920192018594939192610115565b610166610161828689610355565b610365565b8382101561027f578160051b8601358381121561027b5786019081359167ffffffffffffffff831161027b5760200190823603821361027b57825f939284936040519283928337810184815203915af43d15610273573d9067ffffffffffffffff821161025f576101e0601f8301601f1916602001610317565b9182523d5f602084013e5b1561021057906001916101fe828a610379565b526102098189610379565b50016100e5565b9061025b61022261016183888b610355565b6040516330e9b98760e11b815260048101939093526001600160a01b0316602483015260606044830152909182919060648301906102f3565b0390fd5b634e487b7160e01b5f52604160045260245ffd5b6060906101eb565b5f80fd5b634e487b7160e01b5f52603260045260245ffd5b806060602080938a010152016100d2565b63b4fa3fb360e01b5f5260045ffd5b635c387d6760e11b5f5260045ffd5b9181601f8401121561027b5782359167ffffffffffffffff831161027b576020808501948460051b01011161027b57565b805180835260209291819084018484015e5f828201840152601f01601f1916010190565b6040519190601f01601f1916820167ffffffffffffffff81118382101761025f57604052565b67ffffffffffffffff811161025f5760051b60200190565b919081101561027f5760051b0190565b356001600160a01b038116810361027b5790565b805182101561027f5760209160051b01019056"
    public static let runtimeCode: Hex = "0x60806040526004361015610011575f80fd5b5f3560e01c634d618e3b14610024575f80fd5b3461027b57604036600319011261027b5760043567ffffffffffffffff811161027b576100559036906004016102c2565b9060243567ffffffffffffffff811161027b576100769036906004016102c2565b92307f00000000000000000000000000000000000000000000000000000000000000006001600160a01b0316146102b3578381036102a4576100bf6100ba8261033d565b610317565b81815293601f196100cf8361033d565b015f5b81811061029357505036839003601e19015f5b83811061015357866040518091602082016020835281518091526040830190602060408260051b8601019301915f905b82821061012457505050500390f35b919360019193955060206101438192603f198a820301865288516102f3565b9601920192018594939192610115565b610166610161828689610355565b610365565b8382101561027f578160051b8601358381121561027b5786019081359167ffffffffffffffff831161027b5760200190823603821361027b57825f939284936040519283928337810184815203915af43d15610273573d9067ffffffffffffffff821161025f576101e0601f8301601f1916602001610317565b9182523d5f602084013e5b1561021057906001916101fe828a610379565b526102098189610379565b50016100e5565b9061025b61022261016183888b610355565b6040516330e9b98760e11b815260048101939093526001600160a01b0316602483015260606044830152909182919060648301906102f3565b0390fd5b634e487b7160e01b5f52604160045260245ffd5b6060906101eb565b5f80fd5b634e487b7160e01b5f52603260045260245ffd5b806060602080938a010152016100d2565b63b4fa3fb360e01b5f5260045ffd5b635c387d6760e11b5f5260045ffd5b9181601f8401121561027b5782359167ffffffffffffffff831161027b576020808501948460051b01011161027b57565b805180835260209291819084018484015e5f828201840152601f01601f1916010190565b6040519190601f01601f1916820167ffffffffffffffff81118382101761025f57604052565b67ffffffffffffffff811161025f5760051b60200190565b919081101561027f5760051b0190565b356001600160a01b038116810361027b5790565b805182101561027f5760209160051b01019056"

    public static let AlreadyInitializedError = ABI.Function(
            name: "AlreadyInitialized",
            inputs: []
    )

    public static let InvalidCallContextError = ABI.Function(
            name: "InvalidCallContext",
            inputs: []
    )

    public static let InvalidInputError = ABI.Function(
            name: "InvalidInput",
            inputs: []
    )

    public static let MulticallErrorError = ABI.Function(
            name: "MulticallError",
            inputs: [.uint256, .address, .bytes]
    )


    public enum RevertReason : Equatable, Error {
        case alreadyInitialized
        case invalidCallContext
        case invalidInput
        case multicallError(BigUInt, EthAddress, Hex)
        case unknownRevert(String, String)
    }
    public static func rewrapError(_ error: ABI.Function, value: ABI.Value) -> RevertReason {
        switch (error, value) {
        case (AlreadyInitializedError, _):
            return .alreadyInitialized
            case (InvalidCallContextError, _):
            return .invalidCallContext
            case (InvalidInputError, _):
            return .invalidInput
            case (MulticallErrorError, let .tuple3(.uint256(callIndex), .address(callContract), .bytes(err))):
            return .multicallError(callIndex, callContract, err)
            case let (e, v):
            return .unknownRevert(e.name, String(describing: v))
            }
    }
    public static let errors: [ABI.Function] = [AlreadyInitializedError, InvalidCallContextError, InvalidInputError, MulticallErrorError]
    public static let functions: [ABI.Function] = [runFn]
    public static let runFn = ABI.Function(
            name: "run",
            inputs: [.array(.address), .array(.bytes)],
            outputs: [.array(.bytes)]
    )

    public static func run(callContracts: [EthAddress], callDatas: [Hex], withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<[Hex], RevertReason> {
            do {
                let query = try runFn.encoded(with: [.array(.address, callContracts.map {
                                    .address($0)
                                }), .array(.bytes, callDatas.map {
                                    .bytes($0)
                                })])
                let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                let decoded = try runFn.decode(output: result)

                switch decoded {
                case let .tuple1(.array(.bytes, var0)):
                    return .success(var0.map {
                                $0.asHex!
                            })
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, runFn.outputTuple)
                }
            } catch let EVM.QueryError.error(e, v) {
                return .failure(rewrapError(e, value: v))
            }
    }


    public static func runDecode(input: Hex) throws -> ([EthAddress], [Hex]) {
        let decodedInput = try runFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.array(.address, callContracts), .array(.bytes, callDatas)):
            return  (callContracts.map { $0.asEthAddress! }, callDatas.map { $0.asHex! })
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, runFn.inputTuple)
        }
    }

    }