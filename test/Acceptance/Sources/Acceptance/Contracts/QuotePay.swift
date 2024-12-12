@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum QuotePay {
    public static let creationCode: Hex = "0x608080604052346015576103f2908161001a8239f35b5f80fdfe6080806040526004361015610012575f80fd5b5f3560e01c633e8bca6814610025575f80fd5b3461026f5760807ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc36011261026f5760043573ffffffffffffffffffffffffffffffffffffffff811680910361026f576024359173ffffffffffffffffffffffffffffffffffffffff831680930361026f576044359060208101907fa9059cbb000000000000000000000000000000000000000000000000000000008252836024820152826044820152604481526100de6064826102ac565b5f806040938451936100f086866102ac565b602085527f5361666545524332303a206c6f772d6c6576656c2063616c6c206661696c65646020860152519082895af1903d156102a0573d67ffffffffffffffff8111610273576101819260207fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0601f8401160191610171865193846102ac565b82523d5f602084013e5b876102ed565b805190811591821561024c575b5050156101c957807f707da3174303ef012eae997e76518ad0cc80830ffe62ad66a5db5df757187dbc915192835260643560208401523092a4005b608490517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152602a60248201527f5361666545524332303a204552433230206f7065726174696f6e20646964206e60448201527f6f742073756363656564000000000000000000000000000000000000000000006064820152fd5b819250906020918101031261026f5760200151801515810361026f575f8061018e565b5f80fd5b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b6101819160609061017b565b90601f7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0910116810190811067ffffffffffffffff82111761027357604052565b919290156103685750815115610301575090565b3b1561030a5790565b60646040517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152601d60248201527f416464726573733a2063616c6c20746f206e6f6e2d636f6e74726163740000006044820152fd5b82519091501561037b5750805190602001fd5b60446020917fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0601f6040519485937f08c379a00000000000000000000000000000000000000000000000000000000085528160048601528051918291826024880152018686015e5f85828601015201168101030190fd"
    public static let runtimeCode: Hex = "0x6080806040526004361015610012575f80fd5b5f3560e01c633e8bca6814610025575f80fd5b3461026f5760807ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc36011261026f5760043573ffffffffffffffffffffffffffffffffffffffff811680910361026f576024359173ffffffffffffffffffffffffffffffffffffffff831680930361026f576044359060208101907fa9059cbb000000000000000000000000000000000000000000000000000000008252836024820152826044820152604481526100de6064826102ac565b5f806040938451936100f086866102ac565b602085527f5361666545524332303a206c6f772d6c6576656c2063616c6c206661696c65646020860152519082895af1903d156102a0573d67ffffffffffffffff8111610273576101819260207fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0601f8401160191610171865193846102ac565b82523d5f602084013e5b876102ed565b805190811591821561024c575b5050156101c957807f707da3174303ef012eae997e76518ad0cc80830ffe62ad66a5db5df757187dbc915192835260643560208401523092a4005b608490517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152602a60248201527f5361666545524332303a204552433230206f7065726174696f6e20646964206e60448201527f6f742073756363656564000000000000000000000000000000000000000000006064820152fd5b819250906020918101031261026f5760200151801515810361026f575f8061018e565b5f80fd5b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b6101819160609061017b565b90601f7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0910116810190811067ffffffffffffffff82111761027357604052565b919290156103685750815115610301575090565b3b1561030a5790565b60646040517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152601d60248201527f416464726573733a2063616c6c20746f206e6f6e2d636f6e74726163740000006044820152fd5b82519091501561037b5750805190602001fd5b60446020917fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0601f6040519485937f08c379a00000000000000000000000000000000000000000000000000000000085528160048601528051918291826024880152018686015e5f85828601015201168101030190fd"

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
    public static let functions: [ABI.Function] = [payFn]
    public static let payFn = ABI.Function(
        name: "pay",
        inputs: [.address, .address, .uint256, .bytes32],
        outputs: []
    )

    public static func pay(payee: EthAddress, paymentToken: EthAddress, quotedAmount: BigUInt, quoteId: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try payFn.encoded(with: [.address(payee), .address(paymentToken), .uint256(quotedAmount), .bytes32(quoteId)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try payFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, payFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func payDecode(input: Hex) throws -> (EthAddress, EthAddress, BigUInt, Hex) {
        let decodedInput = try payFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple4(.address(payee), .address(paymentToken), .uint256(quotedAmount), .bytes32(quoteId)):
            return (payee, paymentToken, quotedAmount, quoteId)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, payFn.inputTuple)
        }
    }
}
