@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum UniswapSwapActions {
    public struct SwapParamsExactIn: Equatable {
        public static let schema: ABI.Schema = ABI.Schema.tuple([.address, .address, .address, .uint256, .uint256, .bytes])

        public let uniswapRouter: EthAddress
        public let recipient: EthAddress
        public let tokenFrom: EthAddress
        public let amount: BigUInt
        public let amountOutMinimum: BigUInt
        public let path: Hex

        public init(uniswapRouter: EthAddress, recipient: EthAddress, tokenFrom: EthAddress, amount: BigUInt, amountOutMinimum: BigUInt, path: Hex) {
          self.uniswapRouter = uniswapRouter
         self.recipient = recipient
         self.tokenFrom = tokenFrom
         self.amount = amount
         self.amountOutMinimum = amountOutMinimum
         self.path = path
        }

        public var encoded: Hex {
            asValue.encoded
        }

        public var asValue: ABI.Value {
            .tuple6(.address(uniswapRouter),
             .address(recipient),
             .address(tokenFrom),
             .uint256(amount),
             .uint256(amountOutMinimum),
             .bytes(path))
        }

        public static func decode(hex: Hex) throws -> SwapParamsExactIn {
            if let value = try? schema.decode(hex) {
                return try decodeValue(value)
            }
  // both versions are valid encodings of tuples with dynamic fields ( bytes or string ), so try both decodings
  if case let .tuple1(wrappedValue) = try? ABI.Schema.tuple([schema]).decode(hex) {
      return try decodeValue(wrappedValue)
  }
  // retry original to throw the error
  return try decodeValue(schema.decode(hex))


        }

        public static func decodeValue(_ value: ABI.Value) throws -> SwapParamsExactIn {
            switch value {
            case let .tuple6(.address(uniswapRouter),
             .address(recipient),
             .address(tokenFrom),
             .uint256(amount),
             .uint256(amountOutMinimum),
             .bytes(path)):
                return SwapParamsExactIn(uniswapRouter: uniswapRouter, recipient: recipient, tokenFrom: tokenFrom, amount: amount, amountOutMinimum: amountOutMinimum, path: path)
            default:
                throw ABI.DecodeError.mismatchedType(value.schema, schema)
            }
        }
        }
    public struct SwapParamsExactOut: Equatable {
        public static let schema: ABI.Schema = ABI.Schema.tuple([.address, .address, .address, .uint256, .uint256, .bytes])

        public let uniswapRouter: EthAddress
        public let recipient: EthAddress
        public let tokenFrom: EthAddress
        public let amount: BigUInt
        public let amountInMaximum: BigUInt
        public let path: Hex

        public init(uniswapRouter: EthAddress, recipient: EthAddress, tokenFrom: EthAddress, amount: BigUInt, amountInMaximum: BigUInt, path: Hex) {
          self.uniswapRouter = uniswapRouter
         self.recipient = recipient
         self.tokenFrom = tokenFrom
         self.amount = amount
         self.amountInMaximum = amountInMaximum
         self.path = path
        }

        public var encoded: Hex {
            asValue.encoded
        }

        public var asValue: ABI.Value {
            .tuple6(.address(uniswapRouter),
             .address(recipient),
             .address(tokenFrom),
             .uint256(amount),
             .uint256(amountInMaximum),
             .bytes(path))
        }

        public static func decode(hex: Hex) throws -> SwapParamsExactOut {
            if let value = try? schema.decode(hex) {
                return try decodeValue(value)
            }
  // both versions are valid encodings of tuples with dynamic fields ( bytes or string ), so try both decodings
  if case let .tuple1(wrappedValue) = try? ABI.Schema.tuple([schema]).decode(hex) {
      return try decodeValue(wrappedValue)
  }
  // retry original to throw the error
  return try decodeValue(schema.decode(hex))


        }

        public static func decodeValue(_ value: ABI.Value) throws -> SwapParamsExactOut {
            switch value {
            case let .tuple6(.address(uniswapRouter),
             .address(recipient),
             .address(tokenFrom),
             .uint256(amount),
             .uint256(amountInMaximum),
             .bytes(path)):
                return SwapParamsExactOut(uniswapRouter: uniswapRouter, recipient: recipient, tokenFrom: tokenFrom, amount: amount, amountInMaximum: amountInMaximum, path: path)
            default:
                throw ABI.DecodeError.mismatchedType(value.schema, schema)
            }
        }
        }
    public static let creationCode: Hex = "0x60808060405234601557610773908161001a8239f35b5f80fdfe60806040526004361015610011575f80fd5b5f3560e01c8063bc4610bc146102435763dfd42a661461002f575f80fd5b3461022c5761003d3661033b565b604081016001600160a01b036100528261036f565b1661006d61005f8461036f565b9160808501359283916104ca565b5f60206100f76001600160a01b036100848761036f565b1661009260a0880188610383565b906100b66100a1868b0161036f565b91604051936100af856103b6565b3691610424565b825260018060a01b031684820152606088013560408201528560608201526040519485809481936304dc09a360e11b8352876004840152602483019061048d565b03925af1908115610238575f91610202575b501061011157005b61012e906001600160a01b03906101279061036f565b169161036f565b90604051905f80602084019463095ea7b360e01b865260018060a01b031694856024860152816044860152604485526101686064866103e6565b84519082855af16101776105a7565b816101d3575b50806101c9575b1561018c575b005b6101c461018a936040519063095ea7b360e01b602083015260248201525f6044820152604481526101be6064826103e6565b826105ee565b6105ee565b50803b1515610184565b80518015925082156101e8575b50505f61017d565b6101fb92506020809183010191016105d6565b5f806101e0565b90506020813d602011610230575b8161021d602093836103e6565b8101031261022c57515f610109565b5f80fd5b3d9150610210565b6040513d5f823e3d90fd5b3461022c575f60206103036102573661033b565b6001600160a01b0361026b6040830161036f565b166102866102788361036f565b9160608401359283916104ca565b60806001600160a01b036102998461036f565b16926102a860a0820182610383565b93906102c66102b889850161036f565b91604051966100af886103b6565b855260018060a01b03168785015260408401520135606082015260405194858094819363b858183f60e01b8352876004840152602483019061048d565b03925af180156102385761031357005b61018a9060203d602011610334575b61032c81836103e6565b81019061045a565b503d610322565b602060031982011261022c576004359067ffffffffffffffff821161022c5760c090829003600319011261022c5760040190565b356001600160a01b038116810361022c5790565b903590601e198136030182121561022c570180359067ffffffffffffffff821161022c5760200191813603831361022c57565b6080810190811067ffffffffffffffff8211176103d257604052565b634e487b7160e01b5f52604160045260245ffd5b90601f8019910116810190811067ffffffffffffffff8211176103d257604052565b67ffffffffffffffff81116103d257601f01601f191660200190565b92919261043082610408565b9161043e60405193846103e6565b82948184528183011161022c578281602093845f960137010152565b9081602091031261022c575190565b805180835260209291819084018484015e5f828201840152601f01601f1916010190565b906060806104a48451608085526080850190610469565b6020808601516001600160a01b0316908501526040808601519085015293015191015290565b60405191602083019063095ea7b360e01b825260018060a01b0316938460248501526044840152604483526105006064846103e6565b82516001600160a01b038316915f91829182855af19061051e6105a7565b82610575575b508161056a575b501561053657505050565b6101c4610568936040519063095ea7b360e01b602083015260248201525f6044820152604481526101be6064826103e6565b565b90503b15155f61052b565b8051919250811591821561058d575b5050905f610524565b6105a092506020809183010191016105d6565b5f80610584565b3d156105d1573d906105b882610408565b916105c660405193846103e6565b82523d5f602084013e565b606090565b9081602091031261022c5751801515810361022c5790565b9061064e9160018060a01b03165f806040519361060c6040866103e6565b602085527f5361666545524332303a206c6f772d6c6576656c2063616c6c206661696c6564602086015260208151910182855af16106486105a7565b916106d6565b80519081159182156106bc575b50501561066457565b60405162461bcd60e51b815260206004820152602a60248201527f5361666545524332303a204552433230206f7065726174696f6e20646964206e6044820152691bdd081cdd58d8d9595960b21b6064820152608490fd5b6106cf92506020809183010191016105d6565b5f8061065b565b9192901561073857508151156106ea575090565b3b156106f35790565b60405162461bcd60e51b815260206004820152601d60248201527f416464726573733a2063616c6c20746f206e6f6e2d636f6e74726163740000006044820152606490fd5b82519091501561074b5750805190602001fd5b60405162461bcd60e51b81526020600482015290819061076f906024830190610469565b0390fd"
    public static let runtimeCode: Hex = "0x60806040526004361015610011575f80fd5b5f3560e01c8063bc4610bc146102435763dfd42a661461002f575f80fd5b3461022c5761003d3661033b565b604081016001600160a01b036100528261036f565b1661006d61005f8461036f565b9160808501359283916104ca565b5f60206100f76001600160a01b036100848761036f565b1661009260a0880188610383565b906100b66100a1868b0161036f565b91604051936100af856103b6565b3691610424565b825260018060a01b031684820152606088013560408201528560608201526040519485809481936304dc09a360e11b8352876004840152602483019061048d565b03925af1908115610238575f91610202575b501061011157005b61012e906001600160a01b03906101279061036f565b169161036f565b90604051905f80602084019463095ea7b360e01b865260018060a01b031694856024860152816044860152604485526101686064866103e6565b84519082855af16101776105a7565b816101d3575b50806101c9575b1561018c575b005b6101c461018a936040519063095ea7b360e01b602083015260248201525f6044820152604481526101be6064826103e6565b826105ee565b6105ee565b50803b1515610184565b80518015925082156101e8575b50505f61017d565b6101fb92506020809183010191016105d6565b5f806101e0565b90506020813d602011610230575b8161021d602093836103e6565b8101031261022c57515f610109565b5f80fd5b3d9150610210565b6040513d5f823e3d90fd5b3461022c575f60206103036102573661033b565b6001600160a01b0361026b6040830161036f565b166102866102788361036f565b9160608401359283916104ca565b60806001600160a01b036102998461036f565b16926102a860a0820182610383565b93906102c66102b889850161036f565b91604051966100af886103b6565b855260018060a01b03168785015260408401520135606082015260405194858094819363b858183f60e01b8352876004840152602483019061048d565b03925af180156102385761031357005b61018a9060203d602011610334575b61032c81836103e6565b81019061045a565b503d610322565b602060031982011261022c576004359067ffffffffffffffff821161022c5760c090829003600319011261022c5760040190565b356001600160a01b038116810361022c5790565b903590601e198136030182121561022c570180359067ffffffffffffffff821161022c5760200191813603831361022c57565b6080810190811067ffffffffffffffff8211176103d257604052565b634e487b7160e01b5f52604160045260245ffd5b90601f8019910116810190811067ffffffffffffffff8211176103d257604052565b67ffffffffffffffff81116103d257601f01601f191660200190565b92919261043082610408565b9161043e60405193846103e6565b82948184528183011161022c578281602093845f960137010152565b9081602091031261022c575190565b805180835260209291819084018484015e5f828201840152601f01601f1916010190565b906060806104a48451608085526080850190610469565b6020808601516001600160a01b0316908501526040808601519085015293015191015290565b60405191602083019063095ea7b360e01b825260018060a01b0316938460248501526044840152604483526105006064846103e6565b82516001600160a01b038316915f91829182855af19061051e6105a7565b82610575575b508161056a575b501561053657505050565b6101c4610568936040519063095ea7b360e01b602083015260248201525f6044820152604481526101be6064826103e6565b565b90503b15155f61052b565b8051919250811591821561058d575b5050905f610524565b6105a092506020809183010191016105d6565b5f80610584565b3d156105d1573d906105b882610408565b916105c660405193846103e6565b82523d5f602084013e565b606090565b9081602091031261022c5751801515810361022c5790565b9061064e9160018060a01b03165f806040519361060c6040866103e6565b602085527f5361666545524332303a206c6f772d6c6576656c2063616c6c206661696c6564602086015260208151910182855af16106486105a7565b916106d6565b80519081159182156106bc575b50501561066457565b60405162461bcd60e51b815260206004820152602a60248201527f5361666545524332303a204552433230206f7065726174696f6e20646964206e6044820152691bdd081cdd58d8d9595960b21b6064820152608490fd5b6106cf92506020809183010191016105d6565b5f8061065b565b9192901561073857508151156106ea575090565b3b156106f35790565b60405162461bcd60e51b815260206004820152601d60248201527f416464726573733a2063616c6c20746f206e6f6e2d636f6e74726163740000006044820152606490fd5b82519091501561074b5750805190602001fd5b60405162461bcd60e51b81526020600482015290819061076f906024830190610469565b0390fd"


    public enum RevertReason : Equatable, Error {
        case unknownRevert(String, String)
    }
    public static func rewrapError(_ error: ABI.Function, value: ABI.Value) -> RevertReason {
        switch (error, value) {
        case let (e, v):
            return .unknownRevert(e.name, String(describing: v))
            }
    }
    public static let errors: [ABI.Function] = []
    public static let functions: [ABI.Function] = [swapAssetExactInFn, swapAssetExactOutFn]
    public static let swapAssetExactInFn = ABI.Function(
            name: "swapAssetExactIn",
            inputs: [.tuple([.address, .address, .address, .uint256, .uint256, .bytes])],
            outputs: []
    )

    public static func swapAssetExactIn(params: SwapParamsExactIn, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<(), RevertReason> {
            do {
                let query = try swapAssetExactInFn.encoded(with: [params.asValue])
                let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                let decoded = try swapAssetExactInFn.decode(output: result)

                switch decoded {
                case  .tuple0:
                    return .success(())
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, swapAssetExactInFn.outputTuple)
                }
            } catch let EVM.QueryError.error(e, v) {
                return .failure(rewrapError(e, value: v))
            }
    }


    public static func swapAssetExactInDecode(input: Hex) throws -> (SwapParamsExactIn) {
        let decodedInput = try swapAssetExactInFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple1(.tuple6(.address(uniswapRouter),
 .address(recipient),
 .address(tokenFrom),
 .uint256(amount),
 .uint256(amountOutMinimum),
 .bytes(path))):
            return try (SwapParamsExactIn(uniswapRouter: uniswapRouter, recipient: recipient, tokenFrom: tokenFrom, amount: amount, amountOutMinimum: amountOutMinimum, path: path))
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, swapAssetExactInFn.inputTuple)
        }
    }

    public static let swapAssetExactOutFn = ABI.Function(
            name: "swapAssetExactOut",
            inputs: [.tuple([.address, .address, .address, .uint256, .uint256, .bytes])],
            outputs: []
    )

    public static func swapAssetExactOut(params: SwapParamsExactOut, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<(), RevertReason> {
            do {
                let query = try swapAssetExactOutFn.encoded(with: [params.asValue])
                let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                let decoded = try swapAssetExactOutFn.decode(output: result)

                switch decoded {
                case  .tuple0:
                    return .success(())
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, swapAssetExactOutFn.outputTuple)
                }
            } catch let EVM.QueryError.error(e, v) {
                return .failure(rewrapError(e, value: v))
            }
    }


    public static func swapAssetExactOutDecode(input: Hex) throws -> (SwapParamsExactOut) {
        let decodedInput = try swapAssetExactOutFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple1(.tuple6(.address(uniswapRouter),
 .address(recipient),
 .address(tokenFrom),
 .uint256(amount),
 .uint256(amountInMaximum),
 .bytes(path))):
            return try (SwapParamsExactOut(uniswapRouter: uniswapRouter, recipient: recipient, tokenFrom: tokenFrom, amount: amount, amountInMaximum: amountInMaximum, path: path))
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, swapAssetExactOutFn.inputTuple)
        }
    }

    }