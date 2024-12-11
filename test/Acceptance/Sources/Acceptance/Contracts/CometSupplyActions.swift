@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum CometSupplyActions {
    public static let creationCode: Hex = "0x6080806040523460155761076a908161001a8239f35b5f80fdfe60806040526004361015610011575f80fd5b5f5f3560e01c80630c0a769b146102f657806350a4548914610256578063c3da3590146100fc5763f1afb11f14610046575f80fd5b346100ea5760803660031901126100ea578061006061039d565b6100686103b3565b6100706103c9565b606435926001600160a01b039091169061008b84828461047e565b6001600160a01b0316803b156100f8578492836064926040519687958694634232cd6360e01b865260018060a01b03166004860152602485015260448401525af180156100ed576100d95750f35b816100e391610410565b6100ea5780f35b80fd5b6040513d84823e3d90fd5b8480fd5b50346100ea5760603660031901126100ea5761011661039d565b60243567ffffffffffffffff8111610252576101369036906004016103df565b60449291923567ffffffffffffffff81116100f8576101599036906004016103df565b93909284830361024357919385926001600160a01b0381169291845b878110610180578580f35b6101b26001600160a01b0361019e610199848c89610446565b61046a565b16846101ab84868c610446565b359161047e565b6101c0610199828a87610446565b6101cb82848a610446565b3590863b1561023f57604051631e573fb760e31b81526001600160a01b0391909116600482015260248101919091528681604481838a5af190811561023457879161021b575b5050600101610175565b8161022591610410565b61023057855f610211565b8580fd5b6040513d89823e3d90fd5b8780fd5b63b4fa3fb360e01b8652600486fd5b8280fd5b50346100ea5760a03660031901126100ea578061027161039d565b6102796103b3565b6102816103c9565b6064356001600160a01b03811693908490036100f8576001600160a01b0316803b156100f857604051639032317760e01b81526001600160a01b03938416600482015291909216602482015260448101929092526084803560648401528391839190829084905af180156100ed576100d95750f35b50346103995760603660031901126103995761031061039d565b6103186103b3565b6044359161033083826001600160a01b03851661047e565b6001600160a01b031691823b1561039957604051631e573fb760e31b81526001600160a01b039290921660048301526024820152905f908290604490829084905af1801561038e57610380575080f35b61038c91505f90610410565b005b6040513d5f823e3d90fd5b5f80fd5b600435906001600160a01b038216820361039957565b602435906001600160a01b038216820361039957565b604435906001600160a01b038216820361039957565b9181601f840112156103995782359167ffffffffffffffff8311610399576020808501948460051b01011161039957565b90601f8019910116810190811067ffffffffffffffff82111761043257604052565b634e487b7160e01b5f52604160045260245ffd5b91908110156104565760051b0190565b634e487b7160e01b5f52603260045260245ffd5b356001600160a01b03811681036103995790565b60405163095ea7b360e01b602082019081526001600160a01b038416602483015260448083019590955293815291926104b8606484610410565b82516001600160a01b038316915f91829182855af1906104d6610577565b82610545575b508161053a575b50156104ee57505050565b60405163095ea7b360e01b60208201526001600160a01b0390931660248401525f6044808501919091528352610538926105339061052d606482610410565b826105ce565b6105ce565b565b90503b15155f6104e3565b8051919250811591821561055d575b5050905f6104dc565b61057092506020809183010191016105b6565b5f80610554565b3d156105b1573d9067ffffffffffffffff821161043257604051916105a6601f8201601f191660200184610410565b82523d5f602084013e565b606090565b90816020910312610399575180151581036103995790565b9061062e9160018060a01b03165f80604051936105ec604086610410565b602085527f5361666545524332303a206c6f772d6c6576656c2063616c6c206661696c6564602086015260208151910182855af1610628610577565b916106b6565b805190811591821561069c575b50501561064457565b60405162461bcd60e51b815260206004820152602a60248201527f5361666545524332303a204552433230206f7065726174696f6e20646964206e6044820152691bdd081cdd58d8d9595960b21b6064820152608490fd5b6106af92506020809183010191016105b6565b5f8061063b565b9192901561071857508151156106ca575090565b3b156106d35790565b60405162461bcd60e51b815260206004820152601d60248201527f416464726573733a2063616c6c20746f206e6f6e2d636f6e74726163740000006044820152606490fd5b82519091501561072b5750805190602001fd5b604460209160405192839162461bcd60e51b83528160048401528051918291826024860152018484015e5f828201840152601f01601f19168101030190fd"
    public static let runtimeCode: Hex = "0x60806040526004361015610011575f80fd5b5f5f3560e01c80630c0a769b146102f657806350a4548914610256578063c3da3590146100fc5763f1afb11f14610046575f80fd5b346100ea5760803660031901126100ea578061006061039d565b6100686103b3565b6100706103c9565b606435926001600160a01b039091169061008b84828461047e565b6001600160a01b0316803b156100f8578492836064926040519687958694634232cd6360e01b865260018060a01b03166004860152602485015260448401525af180156100ed576100d95750f35b816100e391610410565b6100ea5780f35b80fd5b6040513d84823e3d90fd5b8480fd5b50346100ea5760603660031901126100ea5761011661039d565b60243567ffffffffffffffff8111610252576101369036906004016103df565b60449291923567ffffffffffffffff81116100f8576101599036906004016103df565b93909284830361024357919385926001600160a01b0381169291845b878110610180578580f35b6101b26001600160a01b0361019e610199848c89610446565b61046a565b16846101ab84868c610446565b359161047e565b6101c0610199828a87610446565b6101cb82848a610446565b3590863b1561023f57604051631e573fb760e31b81526001600160a01b0391909116600482015260248101919091528681604481838a5af190811561023457879161021b575b5050600101610175565b8161022591610410565b61023057855f610211565b8580fd5b6040513d89823e3d90fd5b8780fd5b63b4fa3fb360e01b8652600486fd5b8280fd5b50346100ea5760a03660031901126100ea578061027161039d565b6102796103b3565b6102816103c9565b6064356001600160a01b03811693908490036100f8576001600160a01b0316803b156100f857604051639032317760e01b81526001600160a01b03938416600482015291909216602482015260448101929092526084803560648401528391839190829084905af180156100ed576100d95750f35b50346103995760603660031901126103995761031061039d565b6103186103b3565b6044359161033083826001600160a01b03851661047e565b6001600160a01b031691823b1561039957604051631e573fb760e31b81526001600160a01b039290921660048301526024820152905f908290604490829084905af1801561038e57610380575080f35b61038c91505f90610410565b005b6040513d5f823e3d90fd5b5f80fd5b600435906001600160a01b038216820361039957565b602435906001600160a01b038216820361039957565b604435906001600160a01b038216820361039957565b9181601f840112156103995782359167ffffffffffffffff8311610399576020808501948460051b01011161039957565b90601f8019910116810190811067ffffffffffffffff82111761043257604052565b634e487b7160e01b5f52604160045260245ffd5b91908110156104565760051b0190565b634e487b7160e01b5f52603260045260245ffd5b356001600160a01b03811681036103995790565b60405163095ea7b360e01b602082019081526001600160a01b038416602483015260448083019590955293815291926104b8606484610410565b82516001600160a01b038316915f91829182855af1906104d6610577565b82610545575b508161053a575b50156104ee57505050565b60405163095ea7b360e01b60208201526001600160a01b0390931660248401525f6044808501919091528352610538926105339061052d606482610410565b826105ce565b6105ce565b565b90503b15155f6104e3565b8051919250811591821561055d575b5050905f6104dc565b61057092506020809183010191016105b6565b5f80610554565b3d156105b1573d9067ffffffffffffffff821161043257604051916105a6601f8201601f191660200184610410565b82523d5f602084013e565b606090565b90816020910312610399575180151581036103995790565b9061062e9160018060a01b03165f80604051936105ec604086610410565b602085527f5361666545524332303a206c6f772d6c6576656c2063616c6c206661696c6564602086015260208151910182855af1610628610577565b916106b6565b805190811591821561069c575b50501561064457565b60405162461bcd60e51b815260206004820152602a60248201527f5361666545524332303a204552433230206f7065726174696f6e20646964206e6044820152691bdd081cdd58d8d9595960b21b6064820152608490fd5b6106af92506020809183010191016105b6565b5f8061063b565b9192901561071857508151156106ca575090565b3b156106d35790565b60405162461bcd60e51b815260206004820152601d60248201527f416464726573733a2063616c6c20746f206e6f6e2d636f6e74726163740000006044820152606490fd5b82519091501561072b5750805190602001fd5b604460209160405192839162461bcd60e51b83528160048401528051918291826024860152018484015e5f828201840152601f01601f19168101030190fd"

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
    public static let functions: [ABI.Function] = [supplyFn, supplyFromFn, supplyMultipleAssetsFn, supplyToFn]
    public static let supplyFn = ABI.Function(
            name: "supply",
            inputs: [.address, .address, .uint256],
            outputs: []
    )

    public static func supply(comet: EthAddress, asset: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<(), RevertReason> {
            do {
                let query = try supplyFn.encoded(with: [.address(comet), .address(asset), .uint256(amount)])
                let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                let decoded = try supplyFn.decode(output: result)

                switch decoded {
                case  .tuple0:
                    return .success(())
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, supplyFn.outputTuple)
                }
            } catch let EVM.QueryError.error(e, v) {
                return .failure(rewrapError(e, value: v))
            }
    }


    public static func supplyDecode(input: Hex) throws -> (EthAddress, EthAddress, BigUInt) {
        let decodedInput = try supplyFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple3(.address(comet), .address(asset), .uint256(amount)):
            return  (comet, asset, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, supplyFn.inputTuple)
        }
    }

    public static let supplyFromFn = ABI.Function(
            name: "supplyFrom",
            inputs: [.address, .address, .address, .address, .uint256],
            outputs: []
    )

    public static func supplyFrom(comet: EthAddress, from: EthAddress, to: EthAddress, asset: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<(), RevertReason> {
            do {
                let query = try supplyFromFn.encoded(with: [.address(comet), .address(from), .address(to), .address(asset), .uint256(amount)])
                let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                let decoded = try supplyFromFn.decode(output: result)

                switch decoded {
                case  .tuple0:
                    return .success(())
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, supplyFromFn.outputTuple)
                }
            } catch let EVM.QueryError.error(e, v) {
                return .failure(rewrapError(e, value: v))
            }
    }


    public static func supplyFromDecode(input: Hex) throws -> (EthAddress, EthAddress, EthAddress, EthAddress, BigUInt) {
        let decodedInput = try supplyFromFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple5(.address(comet), .address(from), .address(to), .address(asset), .uint256(amount)):
            return  (comet, from, to, asset, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, supplyFromFn.inputTuple)
        }
    }

    public static let supplyMultipleAssetsFn = ABI.Function(
            name: "supplyMultipleAssets",
            inputs: [.address, .array(.address), .array(.uint256)],
            outputs: []
    )

    public static func supplyMultipleAssets(comet: EthAddress, assets: [EthAddress], amounts: [BigUInt], withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<(), RevertReason> {
            do {
                let query = try supplyMultipleAssetsFn.encoded(with: [.address(comet), .array(.address, assets.map {
                                    .address($0)
                                }), .array(.uint256, amounts.map {
                                    .uint256($0)
                                })])
                let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                let decoded = try supplyMultipleAssetsFn.decode(output: result)

                switch decoded {
                case  .tuple0:
                    return .success(())
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, supplyMultipleAssetsFn.outputTuple)
                }
            } catch let EVM.QueryError.error(e, v) {
                return .failure(rewrapError(e, value: v))
            }
    }


    public static func supplyMultipleAssetsDecode(input: Hex) throws -> (EthAddress, [EthAddress], [BigUInt]) {
        let decodedInput = try supplyMultipleAssetsFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple3(.address(comet), .array(.address, assets), .array(.uint256, amounts)):
            return  (comet, assets.map { $0.asEthAddress! }, amounts.map { $0.asBigUInt! })
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, supplyMultipleAssetsFn.inputTuple)
        }
    }

    public static let supplyToFn = ABI.Function(
            name: "supplyTo",
            inputs: [.address, .address, .address, .uint256],
            outputs: []
    )

    public static func supplyTo(comet: EthAddress, to: EthAddress, asset: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<(), RevertReason> {
            do {
                let query = try supplyToFn.encoded(with: [.address(comet), .address(to), .address(asset), .uint256(amount)])
                let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                let decoded = try supplyToFn.decode(output: result)

                switch decoded {
                case  .tuple0:
                    return .success(())
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, supplyToFn.outputTuple)
                }
            } catch let EVM.QueryError.error(e, v) {
                return .failure(rewrapError(e, value: v))
            }
    }


    public static func supplyToDecode(input: Hex) throws -> (EthAddress, EthAddress, EthAddress, BigUInt) {
        let decodedInput = try supplyToFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple4(.address(comet), .address(to), .address(asset), .uint256(amount)):
            return  (comet, to, asset, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, supplyToFn.inputTuple)
        }
    }

    }