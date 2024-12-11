@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum CometWithdrawActions {
    public static let creationCode: Hex = "0x60808060405234601557610420908161001a8239f35b5f80fdfe6080806040526004361015610012575f80fd5b5f905f3560e01c90816306c0b3cc146102b757508063347a377f1461018357806346f711ad146100df5763d9caed121461004a575f80fd5b346100cd5760603660031901126100cd5780610064610353565b61006c610369565b906001600160a01b0316803b156100db5760405163f3fef3a360e01b81526001600160a01b039290921660048301526044803560248401528391839190829084905af180156100d0576100bc5750f35b816100c6916103c6565b6100cd5780f35b80fd5b6040513d84823e3d90fd5b5050fd5b50346100cd5760a03660031901126100cd57806100fa610353565b610102610369565b61010a61037f565b6064356001600160a01b038116939084900361017f576001600160a01b0316803b1561017f576040516304c8826360e31b81526001600160a01b03938416600482015291909216602482015260448101929092526084803560648401528391839190829084905af180156100d0576100bc5750f35b8480fd5b50346100cd5760603660031901126100cd5761019d610353565b60243567ffffffffffffffff81116102b3576101bd903690600401610395565b9060443567ffffffffffffffff811161017f576101de903690600401610395565b90928181036102a457919385926001600160a01b039091169190835b818110610205578480f35b6102108183896103fc565b356001600160a01b03811681036102a05761022c8285896103fc565b3590853b1561029c5760405163f3fef3a360e01b81526001600160a01b039190911660048201526024810191909152858160448183895af190811561029157869161027c575b50506001016101fa565b81610286916103c6565b61017f57845f610272565b6040513d88823e3d90fd5b8680fd5b8580fd5b63b4fa3fb360e01b8652600486fd5b8280fd5b90503461034f57608036600319011261034f576102d2610353565b6102da610369565b6102e261037f565b916001600160a01b0316803b1561034f576361d9ad3f60e11b84526001600160a01b039182166004850152911660248301526064803560448401525f91839190829084905af1801561034457610336575080f35b61034291505f906103c6565b005b6040513d5f823e3d90fd5b5f80fd5b600435906001600160a01b038216820361034f57565b602435906001600160a01b038216820361034f57565b604435906001600160a01b038216820361034f57565b9181601f8401121561034f5782359167ffffffffffffffff831161034f576020808501948460051b01011161034f57565b90601f8019910116810190811067ffffffffffffffff8211176103e857604052565b634e487b7160e01b5f52604160045260245ffd5b919081101561040c5760051b0190565b634e487b7160e01b5f52603260045260245ffd"
    public static let runtimeCode: Hex = "0x6080806040526004361015610012575f80fd5b5f905f3560e01c90816306c0b3cc146102b757508063347a377f1461018357806346f711ad146100df5763d9caed121461004a575f80fd5b346100cd5760603660031901126100cd5780610064610353565b61006c610369565b906001600160a01b0316803b156100db5760405163f3fef3a360e01b81526001600160a01b039290921660048301526044803560248401528391839190829084905af180156100d0576100bc5750f35b816100c6916103c6565b6100cd5780f35b80fd5b6040513d84823e3d90fd5b5050fd5b50346100cd5760a03660031901126100cd57806100fa610353565b610102610369565b61010a61037f565b6064356001600160a01b038116939084900361017f576001600160a01b0316803b1561017f576040516304c8826360e31b81526001600160a01b03938416600482015291909216602482015260448101929092526084803560648401528391839190829084905af180156100d0576100bc5750f35b8480fd5b50346100cd5760603660031901126100cd5761019d610353565b60243567ffffffffffffffff81116102b3576101bd903690600401610395565b9060443567ffffffffffffffff811161017f576101de903690600401610395565b90928181036102a457919385926001600160a01b039091169190835b818110610205578480f35b6102108183896103fc565b356001600160a01b03811681036102a05761022c8285896103fc565b3590853b1561029c5760405163f3fef3a360e01b81526001600160a01b039190911660048201526024810191909152858160448183895af190811561029157869161027c575b50506001016101fa565b81610286916103c6565b61017f57845f610272565b6040513d88823e3d90fd5b8680fd5b8580fd5b63b4fa3fb360e01b8652600486fd5b8280fd5b90503461034f57608036600319011261034f576102d2610353565b6102da610369565b6102e261037f565b916001600160a01b0316803b1561034f576361d9ad3f60e11b84526001600160a01b039182166004850152911660248301526064803560448401525f91839190829084905af1801561034457610336575080f35b61034291505f906103c6565b005b6040513d5f823e3d90fd5b5f80fd5b600435906001600160a01b038216820361034f57565b602435906001600160a01b038216820361034f57565b604435906001600160a01b038216820361034f57565b9181601f8401121561034f5782359167ffffffffffffffff831161034f576020808501948460051b01011161034f57565b90601f8019910116810190811067ffffffffffffffff8211176103e857604052565b634e487b7160e01b5f52604160045260245ffd5b919081101561040c5760051b0190565b634e487b7160e01b5f52603260045260245ffd"

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
    public static let functions: [ABI.Function] = [withdrawFn, withdrawFromFn, withdrawMultipleAssetsFn, withdrawToFn]
    public static let withdrawFn = ABI.Function(
            name: "withdraw",
            inputs: [.address, .address, .uint256],
            outputs: []
    )

    public static func withdraw(comet: EthAddress, asset: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<(), RevertReason> {
            do {
                let query = try withdrawFn.encoded(with: [.address(comet), .address(asset), .uint256(amount)])
                let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                let decoded = try withdrawFn.decode(output: result)

                switch decoded {
                case  .tuple0:
                    return .success(())
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, withdrawFn.outputTuple)
                }
            } catch let EVM.QueryError.error(e, v) {
                return .failure(rewrapError(e, value: v))
            }
    }


    public static func withdrawDecode(input: Hex) throws -> (EthAddress, EthAddress, BigUInt) {
        let decodedInput = try withdrawFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple3(.address(comet), .address(asset), .uint256(amount)):
            return  (comet, asset, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, withdrawFn.inputTuple)
        }
    }

    public static let withdrawFromFn = ABI.Function(
            name: "withdrawFrom",
            inputs: [.address, .address, .address, .address, .uint256],
            outputs: []
    )

    public static func withdrawFrom(comet: EthAddress, from: EthAddress, to: EthAddress, asset: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<(), RevertReason> {
            do {
                let query = try withdrawFromFn.encoded(with: [.address(comet), .address(from), .address(to), .address(asset), .uint256(amount)])
                let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                let decoded = try withdrawFromFn.decode(output: result)

                switch decoded {
                case  .tuple0:
                    return .success(())
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, withdrawFromFn.outputTuple)
                }
            } catch let EVM.QueryError.error(e, v) {
                return .failure(rewrapError(e, value: v))
            }
    }


    public static func withdrawFromDecode(input: Hex) throws -> (EthAddress, EthAddress, EthAddress, EthAddress, BigUInt) {
        let decodedInput = try withdrawFromFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple5(.address(comet), .address(from), .address(to), .address(asset), .uint256(amount)):
            return  (comet, from, to, asset, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, withdrawFromFn.inputTuple)
        }
    }

    public static let withdrawMultipleAssetsFn = ABI.Function(
            name: "withdrawMultipleAssets",
            inputs: [.address, .array(.address), .array(.uint256)],
            outputs: []
    )

    public static func withdrawMultipleAssets(comet: EthAddress, assets: [EthAddress], amounts: [BigUInt], withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<(), RevertReason> {
            do {
                let query = try withdrawMultipleAssetsFn.encoded(with: [.address(comet), .array(.address, assets.map {
                                    .address($0)
                                }), .array(.uint256, amounts.map {
                                    .uint256($0)
                                })])
                let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                let decoded = try withdrawMultipleAssetsFn.decode(output: result)

                switch decoded {
                case  .tuple0:
                    return .success(())
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, withdrawMultipleAssetsFn.outputTuple)
                }
            } catch let EVM.QueryError.error(e, v) {
                return .failure(rewrapError(e, value: v))
            }
    }


    public static func withdrawMultipleAssetsDecode(input: Hex) throws -> (EthAddress, [EthAddress], [BigUInt]) {
        let decodedInput = try withdrawMultipleAssetsFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple3(.address(comet), .array(.address, assets), .array(.uint256, amounts)):
            return  (comet, assets.map { $0.asEthAddress! }, amounts.map { $0.asBigUInt! })
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, withdrawMultipleAssetsFn.inputTuple)
        }
    }

    public static let withdrawToFn = ABI.Function(
            name: "withdrawTo",
            inputs: [.address, .address, .address, .uint256],
            outputs: []
    )

    public static func withdrawTo(comet: EthAddress, to: EthAddress, asset: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<(), RevertReason> {
            do {
                let query = try withdrawToFn.encoded(with: [.address(comet), .address(to), .address(asset), .uint256(amount)])
                let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                let decoded = try withdrawToFn.decode(output: result)

                switch decoded {
                case  .tuple0:
                    return .success(())
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, withdrawToFn.outputTuple)
                }
            } catch let EVM.QueryError.error(e, v) {
                return .failure(rewrapError(e, value: v))
            }
    }


    public static func withdrawToDecode(input: Hex) throws -> (EthAddress, EthAddress, EthAddress, BigUInt) {
        let decodedInput = try withdrawToFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple4(.address(comet), .address(to), .address(asset), .uint256(amount)):
            return  (comet, to, asset, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, withdrawToFn.inputTuple)
        }
    }

    }