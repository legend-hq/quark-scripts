@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum TransferActions {
    public static let creationCode: Hex = "0x6080806040523460155761039e908161001a8239f35b5f80fdfe60806040526004361015610011575f80fd5b5f3560e01c806392940bf9146100da5763ae77a7081461002f575f80fd5b346100d65760403660031901126100d657610048610256565b7f951ae9fc8e231369dc30d9a40f12c78bb800223594870e32a7cda666d14d45d4906001825c146100c7575f808080936001865d602435906001600160a01b03165af16100936102a2565b901561009e575f825d005b604051639a367e1760e01b8152602060048201529081906100c39060248301906102e1565b0390fd5b6306fda65d60e31b5f5260045ffd5b5f80fd5b346100d65760603660031901126100d6576100f3610256565b6024356001600160a01b03811691908290036100d6577f951ae9fc8e231369dc30d9a40f12c78bb800223594870e32a7cda666d14d45d4916001835c146100c7576101c2916001845d60018060a01b03165f8060405193602085019063a9059cbb60e01b8252602486015260443560448601526044855261017560648661026c565b6040519461018460408761026c565b602086527f5361666545524332303a206c6f772d6c6576656c2063616c6c206661696c65646020870152519082855af16101bc6102a2565b91610305565b8051908115918215610233575b5050156101db575f905d005b60405162461bcd60e51b815260206004820152602a60248201527f5361666545524332303a204552433230206f7065726174696f6e20646964206e6044820152691bdd081cdd58d8d9595960b21b6064820152608490fd5b81925090602091810103126100d6576020015180151581036100d65782806101cf565b600435906001600160a01b03821682036100d657565b90601f8019910116810190811067ffffffffffffffff82111761028e57604052565b634e487b7160e01b5f52604160045260245ffd5b3d156102dc573d9067ffffffffffffffff821161028e57604051916102d1601f8201601f19166020018461026c565b82523d5f602084013e565b606090565b805180835260209291819084018484015e5f828201840152601f01601f1916010190565b919290156103675750815115610319575090565b3b156103225790565b60405162461bcd60e51b815260206004820152601d60248201527f416464726573733a2063616c6c20746f206e6f6e2d636f6e74726163740000006044820152606490fd5b82519091501561037a5750805190602001fd5b60405162461bcd60e51b8152602060048201529081906100c39060248301906102e156"
    public static let runtimeCode: Hex = "0x60806040526004361015610011575f80fd5b5f3560e01c806392940bf9146100da5763ae77a7081461002f575f80fd5b346100d65760403660031901126100d657610048610256565b7f951ae9fc8e231369dc30d9a40f12c78bb800223594870e32a7cda666d14d45d4906001825c146100c7575f808080936001865d602435906001600160a01b03165af16100936102a2565b901561009e575f825d005b604051639a367e1760e01b8152602060048201529081906100c39060248301906102e1565b0390fd5b6306fda65d60e31b5f5260045ffd5b5f80fd5b346100d65760603660031901126100d6576100f3610256565b6024356001600160a01b03811691908290036100d6577f951ae9fc8e231369dc30d9a40f12c78bb800223594870e32a7cda666d14d45d4916001835c146100c7576101c2916001845d60018060a01b03165f8060405193602085019063a9059cbb60e01b8252602486015260443560448601526044855261017560648661026c565b6040519461018460408761026c565b602086527f5361666545524332303a206c6f772d6c6576656c2063616c6c206661696c65646020870152519082855af16101bc6102a2565b91610305565b8051908115918215610233575b5050156101db575f905d005b60405162461bcd60e51b815260206004820152602a60248201527f5361666545524332303a204552433230206f7065726174696f6e20646964206e6044820152691bdd081cdd58d8d9595960b21b6064820152608490fd5b81925090602091810103126100d6576020015180151581036100d65782806101cf565b600435906001600160a01b03821682036100d657565b90601f8019910116810190811067ffffffffffffffff82111761028e57604052565b634e487b7160e01b5f52604160045260245ffd5b3d156102dc573d9067ffffffffffffffff821161028e57604051916102d1601f8201601f19166020018461026c565b82523d5f602084013e565b606090565b805180835260209291819084018484015e5f828201840152601f01601f1916010190565b919290156103675750815115610319575090565b3b156103225790565b60405162461bcd60e51b815260206004820152601d60248201527f416464726573733a2063616c6c20746f206e6f6e2d636f6e74726163740000006044820152606490fd5b82519091501561037a5750805190602001fd5b60405162461bcd60e51b8152602060048201529081906100c39060248301906102e156"

    public static let ReentrantCallError = ABI.Function(
            name: "ReentrantCall",
            inputs: []
    )

    public static let TransferFailedError = ABI.Function(
            name: "TransferFailed",
            inputs: [.bytes]
    )


    public enum RevertReason : Equatable, Error {
        case reentrantCall
        case transferFailed(Hex)
        case unknownRevert(String, String)
    }
    public static func rewrapError(_ error: ABI.Function, value: ABI.Value) -> RevertReason {
        switch (error, value) {
        case (ReentrantCallError, _):
            return .reentrantCall
            case (TransferFailedError, let .tuple1(.bytes(data))):
            return .transferFailed(data)
            case let (e, v):
            return .unknownRevert(e.name, String(describing: v))
            }
    }
    public static let errors: [ABI.Function] = [ReentrantCallError, TransferFailedError]
    public static let functions: [ABI.Function] = [transferERC20TokenFn, transferNativeTokenFn]
    public static let transferERC20TokenFn = ABI.Function(
            name: "transferERC20Token",
            inputs: [.address, .address, .uint256],
            outputs: []
    )

    public static func transferERC20Token(token: EthAddress, recipient: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<(), RevertReason> {
            do {
                let query = try transferERC20TokenFn.encoded(with: [.address(token), .address(recipient), .uint256(amount)])
                let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                let decoded = try transferERC20TokenFn.decode(output: result)

                switch decoded {
                case  .tuple0:
                    return .success(())
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, transferERC20TokenFn.outputTuple)
                }
            } catch let EVM.QueryError.error(e, v) {
                return .failure(rewrapError(e, value: v))
            }
    }


    public static func transferERC20TokenDecode(input: Hex) throws -> (EthAddress, EthAddress, BigUInt) {
        let decodedInput = try transferERC20TokenFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple3(.address(token), .address(recipient), .uint256(amount)):
            return  (token, recipient, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, transferERC20TokenFn.inputTuple)
        }
    }

    public static let transferNativeTokenFn = ABI.Function(
            name: "transferNativeToken",
            inputs: [.address, .uint256],
            outputs: []
    )

    public static func transferNativeToken(recipient: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<(), RevertReason> {
            do {
                let query = try transferNativeTokenFn.encoded(with: [.address(recipient), .uint256(amount)])
                let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                let decoded = try transferNativeTokenFn.decode(output: result)

                switch decoded {
                case  .tuple0:
                    return .success(())
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, transferNativeTokenFn.outputTuple)
                }
            } catch let EVM.QueryError.error(e, v) {
                return .failure(rewrapError(e, value: v))
            }
    }


    public static func transferNativeTokenDecode(input: Hex) throws -> (EthAddress, BigUInt) {
        let decodedInput = try transferNativeTokenFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.address(recipient), .uint256(amount)):
            return  (recipient, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, transferNativeTokenFn.inputTuple)
        }
    }

    }