@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum WrapperActions {
    public static let creationCode: Hex = "0x60808060405234601557610bad908161001a8239f35b5f80fdfe60806040526004361015610011575f80fd5b5f5f3560e01c80628342b6146109c357806315a05a4e1461092e5780631e64918f1461081557806329793f7d1461078357806334ce5dc41461066057806348ab02c41461048e5780635869dba8146103f0578063a91a3f1014610357578063b781a58a1461021c5763e3d45a8314610087575f80fd5b346102195760607ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc360112610219576100be610a98565b6100c6610abb565b60443591602060405180937f095ea7b3000000000000000000000000000000000000000000000000000000008252818773ffffffffffffffffffffffffffffffffffffffff8261013d8a89600484016020909392919373ffffffffffffffffffffffffffffffffffffffff60408201951681520152565b0393165af1801561020e5773ffffffffffffffffffffffffffffffffffffffff936020936024926101e3575b508560405195869485937fea598cb00000000000000000000000000000000000000000000000000000000085526004850152165af180156101d8576101ac575080f35b6101cd9060203d6020116101d1575b6101c58183610b18565b810190610b86565b5080f35b503d6101bb565b6040513d84823e3d90fd5b61020290853d8711610207575b6101fa8183610b18565b810190610b95565b610169565b503d6101f0565b6040513d86823e3d90fd5b80fd5b5060407ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc3601126102195780610250610a98565b73ffffffffffffffffffffffffffffffffffffffff6024359116906040517f70a08231000000000000000000000000000000000000000000000000000000008152306004820152602081602481865afa90811561020e57849161031e575b508181106102bb57505050f35b6102c491610ade565b90803b1561031a5782906004604051809481937fd0e30db00000000000000000000000000000000000000000000000000000000083525af180156101d8576103095750f35b8161031391610b18565b6102195780f35b5050fd5b9350506020833d60201161034f575b8161033a60209383610b18565b8101031261034b578392515f6102ae565b5f80fd5b3d915061032d565b5060207ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc360112610219578061038b610a98565b479081610396575050f35b73ffffffffffffffffffffffffffffffffffffffff16803b1561031a5782906004604051809481937fd0e30db00000000000000000000000000000000000000000000000000000000083525af180156101d8576103095750f35b50346102195760407ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc360112610219578073ffffffffffffffffffffffffffffffffffffffff61043e610a98565b16803b1561048b578180916024604051809481937f2e1a7d4d000000000000000000000000000000000000000000000000000000008352833560048401525af180156101d8576103095750f35b50fd5b5060407ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc360112610219576104c1610a98565b73ffffffffffffffffffffffffffffffffffffffff6104de610abb565b16604051917f70a08231000000000000000000000000000000000000000000000000000000008352306004840152602083602481855afa92831561020e57849361062c575b508261052d578380f35b6040517f095ea7b300000000000000000000000000000000000000000000000000000000815273ffffffffffffffffffffffffffffffffffffffff8216600482015260248101849052916020908390604490829088905af1801561020e5773ffffffffffffffffffffffffffffffffffffffff93602093602492610611575b508560405195869485937fea598cb00000000000000000000000000000000000000000000000000000000085526004850152165af180156101d8576105f2575b80808380f35b61060a9060203d6020116101d1576101c58183610b18565b505f6105ec565b61062790853d8711610207576101fa8183610b18565b6105ac565b9092506020813d602011610658575b8161064860209383610b18565b8101031261034b5751915f610523565b3d915061063b565b5060207ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc360112610219578073ffffffffffffffffffffffffffffffffffffffff6106a9610a98565b166040517f70a08231000000000000000000000000000000000000000000000000000000008152306004820152602081602481855afa908115610778578391610743575b50806106f7575050f35b813b1561031a5782916024839260405194859384927f2e1a7d4d00000000000000000000000000000000000000000000000000000000845260048401525af180156101d8576103095750f35b9250506020823d602011610770575b8161075f60209383610b18565b8101031261034b578291515f6106ed565b3d9150610752565b6040513d85823e3d90fd5b5060407ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc360112610219578073ffffffffffffffffffffffffffffffffffffffff6107cc610a98565b16803b1561048b5781600491604051928380927fd0e30db0000000000000000000000000000000000000000000000000000000008252602435905af180156101d8576103095750f35b50346102195760207ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc360112610219578073ffffffffffffffffffffffffffffffffffffffff610863610a98565b16604051907f70a08231000000000000000000000000000000000000000000000000000000008252306004830152602082602481845afa9182156107785783926108f7575b50816108b2575050f35b602460209260405194859384927fde0e9a3e00000000000000000000000000000000000000000000000000000000845260048401525af180156101d8576101ac575080f35b925090506020823d602011610926575b8161091460209383610b18565b8101031261034b57829151905f6108a8565b3d9150610907565b50346102195760407ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc3601126102195780602073ffffffffffffffffffffffffffffffffffffffff6024610980610a98565b60405194859384927fde0e9a3e00000000000000000000000000000000000000000000000000000000845284356004850152165af180156101d8576101ac575080f35b503461034b5760407ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc36011261034b576109fb610a98565b6024359047828110610a0b578380f35b73ffffffffffffffffffffffffffffffffffffffff610a2b921692610ade565b813b1561034b575f916024839260405194859384927f2e1a7d4d00000000000000000000000000000000000000000000000000000000845260048401525af18015610a8d57610a7a5780808380f35b610a8691505f90610b18565b5f5f6105ec565b6040513d5f823e3d90fd5b6004359073ffffffffffffffffffffffffffffffffffffffff8216820361034b57565b6024359073ffffffffffffffffffffffffffffffffffffffff8216820361034b57565b91908203918211610aeb57565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b90601f7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0910116810190811067ffffffffffffffff821117610b5957604052565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b9081602091031261034b575190565b9081602091031261034b5751801515810361034b579056"
    public static let runtimeCode: Hex = "0x60806040526004361015610011575f80fd5b5f5f3560e01c80628342b6146109c357806315a05a4e1461092e5780631e64918f1461081557806329793f7d1461078357806334ce5dc41461066057806348ab02c41461048e5780635869dba8146103f0578063a91a3f1014610357578063b781a58a1461021c5763e3d45a8314610087575f80fd5b346102195760607ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc360112610219576100be610a98565b6100c6610abb565b60443591602060405180937f095ea7b3000000000000000000000000000000000000000000000000000000008252818773ffffffffffffffffffffffffffffffffffffffff8261013d8a89600484016020909392919373ffffffffffffffffffffffffffffffffffffffff60408201951681520152565b0393165af1801561020e5773ffffffffffffffffffffffffffffffffffffffff936020936024926101e3575b508560405195869485937fea598cb00000000000000000000000000000000000000000000000000000000085526004850152165af180156101d8576101ac575080f35b6101cd9060203d6020116101d1575b6101c58183610b18565b810190610b86565b5080f35b503d6101bb565b6040513d84823e3d90fd5b61020290853d8711610207575b6101fa8183610b18565b810190610b95565b610169565b503d6101f0565b6040513d86823e3d90fd5b80fd5b5060407ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc3601126102195780610250610a98565b73ffffffffffffffffffffffffffffffffffffffff6024359116906040517f70a08231000000000000000000000000000000000000000000000000000000008152306004820152602081602481865afa90811561020e57849161031e575b508181106102bb57505050f35b6102c491610ade565b90803b1561031a5782906004604051809481937fd0e30db00000000000000000000000000000000000000000000000000000000083525af180156101d8576103095750f35b8161031391610b18565b6102195780f35b5050fd5b9350506020833d60201161034f575b8161033a60209383610b18565b8101031261034b578392515f6102ae565b5f80fd5b3d915061032d565b5060207ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc360112610219578061038b610a98565b479081610396575050f35b73ffffffffffffffffffffffffffffffffffffffff16803b1561031a5782906004604051809481937fd0e30db00000000000000000000000000000000000000000000000000000000083525af180156101d8576103095750f35b50346102195760407ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc360112610219578073ffffffffffffffffffffffffffffffffffffffff61043e610a98565b16803b1561048b578180916024604051809481937f2e1a7d4d000000000000000000000000000000000000000000000000000000008352833560048401525af180156101d8576103095750f35b50fd5b5060407ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc360112610219576104c1610a98565b73ffffffffffffffffffffffffffffffffffffffff6104de610abb565b16604051917f70a08231000000000000000000000000000000000000000000000000000000008352306004840152602083602481855afa92831561020e57849361062c575b508261052d578380f35b6040517f095ea7b300000000000000000000000000000000000000000000000000000000815273ffffffffffffffffffffffffffffffffffffffff8216600482015260248101849052916020908390604490829088905af1801561020e5773ffffffffffffffffffffffffffffffffffffffff93602093602492610611575b508560405195869485937fea598cb00000000000000000000000000000000000000000000000000000000085526004850152165af180156101d8576105f2575b80808380f35b61060a9060203d6020116101d1576101c58183610b18565b505f6105ec565b61062790853d8711610207576101fa8183610b18565b6105ac565b9092506020813d602011610658575b8161064860209383610b18565b8101031261034b5751915f610523565b3d915061063b565b5060207ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc360112610219578073ffffffffffffffffffffffffffffffffffffffff6106a9610a98565b166040517f70a08231000000000000000000000000000000000000000000000000000000008152306004820152602081602481855afa908115610778578391610743575b50806106f7575050f35b813b1561031a5782916024839260405194859384927f2e1a7d4d00000000000000000000000000000000000000000000000000000000845260048401525af180156101d8576103095750f35b9250506020823d602011610770575b8161075f60209383610b18565b8101031261034b578291515f6106ed565b3d9150610752565b6040513d85823e3d90fd5b5060407ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc360112610219578073ffffffffffffffffffffffffffffffffffffffff6107cc610a98565b16803b1561048b5781600491604051928380927fd0e30db0000000000000000000000000000000000000000000000000000000008252602435905af180156101d8576103095750f35b50346102195760207ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc360112610219578073ffffffffffffffffffffffffffffffffffffffff610863610a98565b16604051907f70a08231000000000000000000000000000000000000000000000000000000008252306004830152602082602481845afa9182156107785783926108f7575b50816108b2575050f35b602460209260405194859384927fde0e9a3e00000000000000000000000000000000000000000000000000000000845260048401525af180156101d8576101ac575080f35b925090506020823d602011610926575b8161091460209383610b18565b8101031261034b57829151905f6108a8565b3d9150610907565b50346102195760407ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc3601126102195780602073ffffffffffffffffffffffffffffffffffffffff6024610980610a98565b60405194859384927fde0e9a3e00000000000000000000000000000000000000000000000000000000845284356004850152165af180156101d8576101ac575080f35b503461034b5760407ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc36011261034b576109fb610a98565b6024359047828110610a0b578380f35b73ffffffffffffffffffffffffffffffffffffffff610a2b921692610ade565b813b1561034b575f916024839260405194859384927f2e1a7d4d00000000000000000000000000000000000000000000000000000000845260048401525af18015610a8d57610a7a5780808380f35b610a8691505f90610b18565b5f5f6105ec565b6040513d5f823e3d90fd5b6004359073ffffffffffffffffffffffffffffffffffffffff8216820361034b57565b6024359073ffffffffffffffffffffffffffffffffffffffff8216820361034b57565b91908203918211610aeb57565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b90601f7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0910116810190811067ffffffffffffffff821117610b5957604052565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b9081602091031261034b575190565b9081602091031261034b5751801515810361034b579056"

    public enum RevertReason: Equatable, Error {
        case unknownRevert(String, String)
    }

    public static func rewrapError(_ error: ABI.Function, value: ABI.Value) -> RevertReason {
        switch (error, value) {
        case let (e, v):
            return .unknownRevert(e.name, String(describing: v))
        }
    }

    public static let errors: [ABI.Function] = []
    public static let functions: [ABI.Function] = [unwrapAllLidoWstETHFn, unwrapAllWETHFn, unwrapLidoWstETHFn, unwrapWETHFn, unwrapWETHUpToFn, wrapAllETHFn, wrapAllLidoStETHFn, wrapETHFn, wrapETHUpToFn, wrapLidoStETHFn]
    public static let unwrapAllLidoWstETHFn = ABI.Function(
        name: "unwrapAllLidoWstETH",
        inputs: [.address],
        outputs: []
    )

    public static func unwrapAllLidoWstETH(wstETH: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try unwrapAllLidoWstETHFn.encoded(with: [.address(wstETH)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try unwrapAllLidoWstETHFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, unwrapAllLidoWstETHFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func unwrapAllLidoWstETHDecode(input: Hex) throws -> (EthAddress) {
        let decodedInput = try unwrapAllLidoWstETHFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple1(.address(wstETH)):
            return wstETH
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, unwrapAllLidoWstETHFn.inputTuple)
        }
    }

    public static let unwrapAllWETHFn = ABI.Function(
        name: "unwrapAllWETH",
        inputs: [.address],
        outputs: []
    )

    public static func unwrapAllWETH(weth: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try unwrapAllWETHFn.encoded(with: [.address(weth)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try unwrapAllWETHFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, unwrapAllWETHFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func unwrapAllWETHDecode(input: Hex) throws -> (EthAddress) {
        let decodedInput = try unwrapAllWETHFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple1(.address(weth)):
            return weth
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, unwrapAllWETHFn.inputTuple)
        }
    }

    public static let unwrapLidoWstETHFn = ABI.Function(
        name: "unwrapLidoWstETH",
        inputs: [.address, .uint256],
        outputs: []
    )

    public static func unwrapLidoWstETH(wstETH: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try unwrapLidoWstETHFn.encoded(with: [.address(wstETH), .uint256(amount)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try unwrapLidoWstETHFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, unwrapLidoWstETHFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func unwrapLidoWstETHDecode(input: Hex) throws -> (EthAddress, BigUInt) {
        let decodedInput = try unwrapLidoWstETHFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.address(wstETH), .uint256(amount)):
            return (wstETH, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, unwrapLidoWstETHFn.inputTuple)
        }
    }

    public static let unwrapWETHFn = ABI.Function(
        name: "unwrapWETH",
        inputs: [.address, .uint256],
        outputs: []
    )

    public static func unwrapWETH(weth: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try unwrapWETHFn.encoded(with: [.address(weth), .uint256(amount)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try unwrapWETHFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, unwrapWETHFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func unwrapWETHDecode(input: Hex) throws -> (EthAddress, BigUInt) {
        let decodedInput = try unwrapWETHFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.address(weth), .uint256(amount)):
            return (weth, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, unwrapWETHFn.inputTuple)
        }
    }

    public static let unwrapWETHUpToFn = ABI.Function(
        name: "unwrapWETHUpTo",
        inputs: [.address, .uint256],
        outputs: []
    )

    public static func unwrapWETHUpTo(weth: EthAddress, targetAmount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try unwrapWETHUpToFn.encoded(with: [.address(weth), .uint256(targetAmount)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try unwrapWETHUpToFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, unwrapWETHUpToFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func unwrapWETHUpToDecode(input: Hex) throws -> (EthAddress, BigUInt) {
        let decodedInput = try unwrapWETHUpToFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.address(weth), .uint256(targetAmount)):
            return (weth, targetAmount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, unwrapWETHUpToFn.inputTuple)
        }
    }

    public static let wrapAllETHFn = ABI.Function(
        name: "wrapAllETH",
        inputs: [.address],
        outputs: []
    )

    public static func wrapAllETH(weth: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try wrapAllETHFn.encoded(with: [.address(weth)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try wrapAllETHFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, wrapAllETHFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func wrapAllETHDecode(input: Hex) throws -> (EthAddress) {
        let decodedInput = try wrapAllETHFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple1(.address(weth)):
            return weth
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, wrapAllETHFn.inputTuple)
        }
    }

    public static let wrapAllLidoStETHFn = ABI.Function(
        name: "wrapAllLidoStETH",
        inputs: [.address, .address],
        outputs: []
    )

    public static func wrapAllLidoStETH(wstETH: EthAddress, stETH: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try wrapAllLidoStETHFn.encoded(with: [.address(wstETH), .address(stETH)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try wrapAllLidoStETHFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, wrapAllLidoStETHFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func wrapAllLidoStETHDecode(input: Hex) throws -> (EthAddress, EthAddress) {
        let decodedInput = try wrapAllLidoStETHFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.address(wstETH), .address(stETH)):
            return (wstETH, stETH)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, wrapAllLidoStETHFn.inputTuple)
        }
    }

    public static let wrapETHFn = ABI.Function(
        name: "wrapETH",
        inputs: [.address, .uint256],
        outputs: []
    )

    public static func wrapETH(weth: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try wrapETHFn.encoded(with: [.address(weth), .uint256(amount)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try wrapETHFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, wrapETHFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func wrapETHDecode(input: Hex) throws -> (EthAddress, BigUInt) {
        let decodedInput = try wrapETHFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.address(weth), .uint256(amount)):
            return (weth, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, wrapETHFn.inputTuple)
        }
    }

    public static let wrapETHUpToFn = ABI.Function(
        name: "wrapETHUpTo",
        inputs: [.address, .uint256],
        outputs: []
    )

    public static func wrapETHUpTo(weth: EthAddress, targetAmount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try wrapETHUpToFn.encoded(with: [.address(weth), .uint256(targetAmount)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try wrapETHUpToFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, wrapETHUpToFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func wrapETHUpToDecode(input: Hex) throws -> (EthAddress, BigUInt) {
        let decodedInput = try wrapETHUpToFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.address(weth), .uint256(targetAmount)):
            return (weth, targetAmount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, wrapETHUpToFn.inputTuple)
        }
    }

    public static let wrapLidoStETHFn = ABI.Function(
        name: "wrapLidoStETH",
        inputs: [.address, .address, .uint256],
        outputs: []
    )

    public static func wrapLidoStETH(wstETH: EthAddress, stETH: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try wrapLidoStETHFn.encoded(with: [.address(wstETH), .address(stETH), .uint256(amount)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try wrapLidoStETHFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, wrapLidoStETHFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func wrapLidoStETHDecode(input: Hex) throws -> (EthAddress, EthAddress, BigUInt) {
        let decodedInput = try wrapLidoStETHFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple3(.address(wstETH), .address(stETH), .uint256(amount)):
            return (wstETH, stETH, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, wrapLidoStETHFn.inputTuple)
        }
    }
}
