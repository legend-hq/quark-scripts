@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum QuotePay {
    public static let creationCode: Hex = "0x608060405234601c57600e6020565b61096361002b823961096390f35b6026565b60405190565b5f80fdfe60806040526004361015610013575b610156565b61001d5f3561002c565b633e8bca680361000e5761011f565b60e01c90565b60405190565b5f80fd5b5f80fd5b73ffffffffffffffffffffffffffffffffffffffff1690565b61006290610040565b90565b61006e81610059565b0361007557565b5f80fd5b9050359061008682610065565b565b90565b61009481610088565b0361009b57565b5f80fd5b905035906100ac8261008b565b565b90565b6100ba816100ae565b036100c157565b5f80fd5b905035906100d2826100b1565b565b608081830312610115576100ea825f8301610079565b926101126100fb8460208501610079565b93610109816040860161009f565b936060016100c5565b90565b61003c565b5f0190565b346101515761013b6101323660046100d4565b929190916101f2565b610143610032565b8061014d8161011a565b0390f35b610038565b5f80fd5b90565b61017161016c61017692610040565b61015a565b610040565b90565b6101829061015d565b90565b61018e90610179565b90565b61019a9061015d565b90565b6101a690610191565b90565b6101b290610191565b90565b6101be90610088565b9052565b6101cb906100ae565b9052565b9160206101f09294936101e960408201965f8301906101b5565b01906101c2565b565b6102066101fe83610185565b828591610355565b61020f3061019d565b9091929361024f6102496102437f707da3174303ef012eae997e76518ad0cc80830ffe62ad66a5db5df757187dbc946101a9565b946101a9565b946101a9565b9461026461025b610032565b928392836101cf565b0390a4565b61027290610191565b90565b63ffffffff1690565b7fffffffff000000000000000000000000000000000000000000000000000000001690565b60e01b90565b6102bd6102b86102c292610275565b6102a3565b61027e565b90565b6102ce90610059565b9052565b9160206102f39294936102ec60408201965f8301906102c5565b01906101b5565b565b601f801991011690565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b90610336906102f5565b810190811067ffffffffffffffff82111761035057604052565b6102ff565b9161039960049261038a61039e959361037163a9059cbb6102a9565b9261037a610032565b96879460208601908152016102d2565b6020820181038252038361032c565b61056e565b565b906103b36103ac610032565b928361032c565b565b67ffffffffffffffff81116103d3576103cf6020916102f5565b0190565b6102ff565b906103ea6103e5836103b5565b6103a0565b918252565b5f7f5361666545524332303a206c6f772d6c6576656c2063616c6c206661696c6564910152565b61042060206103d8565b9061042d602083016103ef565b565b610437610416565b90565b5190565b90565b61045561045061045a9261043e565b61015a565b610088565b90565b151590565b61046b8161045d565b0361047257565b5f80fd5b9050519061048382610462565b565b9060208282031261049e5761049b915f01610476565b90565b61003c565b60209181520190565b60207f6f74207375636365656400000000000000000000000000000000000000000000917f5361666545524332303a204552433230206f7065726174696f6e20646964206e5f8201520152565b610506602a6040926104a3565b61050f816104ac565b0190565b6105289060208101905f8183039101526104f9565b90565b1561053257565b61053a610032565b7f08c379a00000000000000000000000000000000000000000000000000000000081528061056a60048201610513565b0390fd5b6105b79161057e61058d92610269565b9061058761042f565b916105df565b6105968161043a565b6105a86105a25f610441565b91610088565b149081156105b9575b5061052b565b565b6105d4915060206105c98261043a565b818301019101610485565b5f6105b1565b606090565b906105fe92916105ed6105da565b50906105f85f610441565b91610732565b90565b61060a90610191565b90565b60207f722063616c6c0000000000000000000000000000000000000000000000000000917f416464726573733a20696e73756666696369656e742062616c616e636520666f5f8201520152565b61066760266040926104a3565b6106708161060d565b0190565b6106899060208101905f81830391015261065a565b90565b1561069357565b61069b610032565b7f08c379a0000000000000000000000000000000000000000000000000000000008152806106cb60048201610674565b0390fd5b67ffffffffffffffff81116106ed576106e96020916102f5565b0190565b6102ff565b906107046106ff836106cf565b6103a0565b918252565b3d5f14610724576107193d6106f2565b903d5f602084013e5b565b61072c6105da565b90610722565b915f809161078895936107436105da565b5061076a61075030610601565b3161076361075d85610088565b91610088565b101561068c565b8591602082019151925af19161077e610709565b9092909192610827565b90565b5f7f416464726573733a2063616c6c20746f206e6f6e2d636f6e7472616374000000910152565b6107bf601d6020926104a3565b6107c88161078b565b0190565b6107e19060208101905f8183039101526107b2565b90565b156107eb57565b6107f3610032565b7f08c379a000000000000000000000000000000000000000000000000000000000815280610823600482016107cc565b0390fd5b9192906108326105da565b505f1461087657506108438261043a565b61085561084f5f610441565b91610088565b1461085f575b5090565b61086b61087091610943565b6107e4565b5f61085b565b826108d4565b5190565b90825f9392825e0152565b6108aa6108b36020936108b8936108a18161087c565b938480936104a3565b95869101610880565b6102f5565b0190565b6108d19160208201915f81840391015261088b565b90565b906108de8261043a565b6108f06108ea5f610441565b91610088565b115f146109005750805190602001fd5b61093b9061090c610032565b9182917f08c379a0000000000000000000000000000000000000000000000000000000008352600483016108bc565b0390fd5b5f90565b61094b61093f565b503b61095f6109595f610441565b91610088565b119056"
    public static let runtimeCode: Hex = "0x60806040526004361015610013575b610156565b61001d5f3561002c565b633e8bca680361000e5761011f565b60e01c90565b60405190565b5f80fd5b5f80fd5b73ffffffffffffffffffffffffffffffffffffffff1690565b61006290610040565b90565b61006e81610059565b0361007557565b5f80fd5b9050359061008682610065565b565b90565b61009481610088565b0361009b57565b5f80fd5b905035906100ac8261008b565b565b90565b6100ba816100ae565b036100c157565b5f80fd5b905035906100d2826100b1565b565b608081830312610115576100ea825f8301610079565b926101126100fb8460208501610079565b93610109816040860161009f565b936060016100c5565b90565b61003c565b5f0190565b346101515761013b6101323660046100d4565b929190916101f2565b610143610032565b8061014d8161011a565b0390f35b610038565b5f80fd5b90565b61017161016c61017692610040565b61015a565b610040565b90565b6101829061015d565b90565b61018e90610179565b90565b61019a9061015d565b90565b6101a690610191565b90565b6101b290610191565b90565b6101be90610088565b9052565b6101cb906100ae565b9052565b9160206101f09294936101e960408201965f8301906101b5565b01906101c2565b565b6102066101fe83610185565b828591610355565b61020f3061019d565b9091929361024f6102496102437f707da3174303ef012eae997e76518ad0cc80830ffe62ad66a5db5df757187dbc946101a9565b946101a9565b946101a9565b9461026461025b610032565b928392836101cf565b0390a4565b61027290610191565b90565b63ffffffff1690565b7fffffffff000000000000000000000000000000000000000000000000000000001690565b60e01b90565b6102bd6102b86102c292610275565b6102a3565b61027e565b90565b6102ce90610059565b9052565b9160206102f39294936102ec60408201965f8301906102c5565b01906101b5565b565b601f801991011690565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b90610336906102f5565b810190811067ffffffffffffffff82111761035057604052565b6102ff565b9161039960049261038a61039e959361037163a9059cbb6102a9565b9261037a610032565b96879460208601908152016102d2565b6020820181038252038361032c565b61056e565b565b906103b36103ac610032565b928361032c565b565b67ffffffffffffffff81116103d3576103cf6020916102f5565b0190565b6102ff565b906103ea6103e5836103b5565b6103a0565b918252565b5f7f5361666545524332303a206c6f772d6c6576656c2063616c6c206661696c6564910152565b61042060206103d8565b9061042d602083016103ef565b565b610437610416565b90565b5190565b90565b61045561045061045a9261043e565b61015a565b610088565b90565b151590565b61046b8161045d565b0361047257565b5f80fd5b9050519061048382610462565b565b9060208282031261049e5761049b915f01610476565b90565b61003c565b60209181520190565b60207f6f74207375636365656400000000000000000000000000000000000000000000917f5361666545524332303a204552433230206f7065726174696f6e20646964206e5f8201520152565b610506602a6040926104a3565b61050f816104ac565b0190565b6105289060208101905f8183039101526104f9565b90565b1561053257565b61053a610032565b7f08c379a00000000000000000000000000000000000000000000000000000000081528061056a60048201610513565b0390fd5b6105b79161057e61058d92610269565b9061058761042f565b916105df565b6105968161043a565b6105a86105a25f610441565b91610088565b149081156105b9575b5061052b565b565b6105d4915060206105c98261043a565b818301019101610485565b5f6105b1565b606090565b906105fe92916105ed6105da565b50906105f85f610441565b91610732565b90565b61060a90610191565b90565b60207f722063616c6c0000000000000000000000000000000000000000000000000000917f416464726573733a20696e73756666696369656e742062616c616e636520666f5f8201520152565b61066760266040926104a3565b6106708161060d565b0190565b6106899060208101905f81830391015261065a565b90565b1561069357565b61069b610032565b7f08c379a0000000000000000000000000000000000000000000000000000000008152806106cb60048201610674565b0390fd5b67ffffffffffffffff81116106ed576106e96020916102f5565b0190565b6102ff565b906107046106ff836106cf565b6103a0565b918252565b3d5f14610724576107193d6106f2565b903d5f602084013e5b565b61072c6105da565b90610722565b915f809161078895936107436105da565b5061076a61075030610601565b3161076361075d85610088565b91610088565b101561068c565b8591602082019151925af19161077e610709565b9092909192610827565b90565b5f7f416464726573733a2063616c6c20746f206e6f6e2d636f6e7472616374000000910152565b6107bf601d6020926104a3565b6107c88161078b565b0190565b6107e19060208101905f8183039101526107b2565b90565b156107eb57565b6107f3610032565b7f08c379a000000000000000000000000000000000000000000000000000000000815280610823600482016107cc565b0390fd5b9192906108326105da565b505f1461087657506108438261043a565b61085561084f5f610441565b91610088565b1461085f575b5090565b61086b61087091610943565b6107e4565b5f61085b565b826108d4565b5190565b90825f9392825e0152565b6108aa6108b36020936108b8936108a18161087c565b938480936104a3565b95869101610880565b6102f5565b0190565b6108d19160208201915f81840391015261088b565b90565b906108de8261043a565b6108f06108ea5f610441565b91610088565b115f146109005750805190602001fd5b61093b9061090c610032565b9182917f08c379a0000000000000000000000000000000000000000000000000000000008352600483016108bc565b0390fd5b5f90565b61094b61093f565b503b61095f6109595f610441565b91610088565b119056"

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
