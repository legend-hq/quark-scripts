@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum CometSupplyMultipleAssetsAndBorrow {
    public static let creationCode: Hex = "0x6080806040523460155761076f908161001a8239f35b5f80fdfe60806040526004361015610011575f80fd5b5f3560e01c63ff20388514610024575f80fd5b346101765760a07ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc3601126101765760043573ffffffffffffffffffffffffffffffffffffffff8116908181036101765760243567ffffffffffffffff8111610176576100959036906004016103d6565b9160443567ffffffffffffffff8111610176576100b69036906004016103d6565b6064359473ffffffffffffffffffffffffffffffffffffffff8616860361017657608435948282036103ae575f5b82811061017a57888888806100f557005b823b15610176576040517ff3fef3a300000000000000000000000000000000000000000000000000000000815273ffffffffffffffffffffffffffffffffffffffff9290921660048301526024820152905f908290604490829084905af1801561016b5761015f57005b5f61016991610465565b005b6040513d5f823e3d90fd5b5f80fd5b610185818587610407565b35610193575b6001016100e4565b73ffffffffffffffffffffffffffffffffffffffff6101bb6101b6838686610407565b610444565b166102295f80896102556101d0878b8d610407565b6040517f095ea7b3000000000000000000000000000000000000000000000000000000006020820190815273ffffffffffffffffffffffffffffffffffffffff9094166024820152903560448201529485906064820190565b037fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe08101865285610465565b83519082865af16102646104d3565b8161037f575b5080610375575b15610318575b50506102876101b6828585610407565b90610293818688610407565b35918a3b15610176576040517ff2b9fdb800000000000000000000000000000000000000000000000000000000815273ffffffffffffffffffffffffffffffffffffffff91909116600482015260248101929092525f82604481838e5af191821561016b57600192610308575b50905061018b565b5f61031291610465565b5f610300565b61036e916103696040517f095ea7b30000000000000000000000000000000000000000000000000000000060208201528d60248201525f604482015260448152610363606482610465565b82610548565b610548565b5f80610277565b50813b1515610271565b8051801592508215610394575b50505f61026a565b6103a79250602080918301019101610530565b5f8061038c565b7fb4fa3fb3000000000000000000000000000000000000000000000000000000005f5260045ffd5b9181601f840112156101765782359167ffffffffffffffff8311610176576020808501948460051b01011161017657565b91908110156104175760051b0190565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52603260045260245ffd5b3573ffffffffffffffffffffffffffffffffffffffff811681036101765790565b90601f7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0910116810190811067ffffffffffffffff8211176104a657604052565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b3d1561052b573d9067ffffffffffffffff82116104a65760405191610520601f82017fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe01660200184610465565b82523d5f602084013e565b606090565b90816020910312610176575180151581036101765790565b9073ffffffffffffffffffffffffffffffffffffffff6105b692165f8060405193610574604086610465565b602085527f5361666545524332303a206c6f772d6c6576656c2063616c6c206661696c6564602086015260208151910182855af16105b06104d3565b9161066a565b8051908115918215610650575b5050156105cc57565b60846040517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152602a60248201527f5361666545524332303a204552433230206f7065726174696f6e20646964206e60448201527f6f742073756363656564000000000000000000000000000000000000000000006064820152fd5b6106639250602080918301019101610530565b5f806105c3565b919290156106e5575081511561067e575090565b3b156106875790565b60646040517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152601d60248201527f416464726573733a2063616c6c20746f206e6f6e2d636f6e74726163740000006044820152fd5b8251909150156106f85750805190602001fd5b60446020917fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0601f6040519485937f08c379a00000000000000000000000000000000000000000000000000000000085528160048601528051918291826024880152018686015e5f85828601015201168101030190fd"
    public static let runtimeCode: Hex = "0x60806040526004361015610011575f80fd5b5f3560e01c63ff20388514610024575f80fd5b346101765760a07ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc3601126101765760043573ffffffffffffffffffffffffffffffffffffffff8116908181036101765760243567ffffffffffffffff8111610176576100959036906004016103d6565b9160443567ffffffffffffffff8111610176576100b69036906004016103d6565b6064359473ffffffffffffffffffffffffffffffffffffffff8616860361017657608435948282036103ae575f5b82811061017a57888888806100f557005b823b15610176576040517ff3fef3a300000000000000000000000000000000000000000000000000000000815273ffffffffffffffffffffffffffffffffffffffff9290921660048301526024820152905f908290604490829084905af1801561016b5761015f57005b5f61016991610465565b005b6040513d5f823e3d90fd5b5f80fd5b610185818587610407565b35610193575b6001016100e4565b73ffffffffffffffffffffffffffffffffffffffff6101bb6101b6838686610407565b610444565b166102295f80896102556101d0878b8d610407565b6040517f095ea7b3000000000000000000000000000000000000000000000000000000006020820190815273ffffffffffffffffffffffffffffffffffffffff9094166024820152903560448201529485906064820190565b037fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe08101865285610465565b83519082865af16102646104d3565b8161037f575b5080610375575b15610318575b50506102876101b6828585610407565b90610293818688610407565b35918a3b15610176576040517ff2b9fdb800000000000000000000000000000000000000000000000000000000815273ffffffffffffffffffffffffffffffffffffffff91909116600482015260248101929092525f82604481838e5af191821561016b57600192610308575b50905061018b565b5f61031291610465565b5f610300565b61036e916103696040517f095ea7b30000000000000000000000000000000000000000000000000000000060208201528d60248201525f604482015260448152610363606482610465565b82610548565b610548565b5f80610277565b50813b1515610271565b8051801592508215610394575b50505f61026a565b6103a79250602080918301019101610530565b5f8061038c565b7fb4fa3fb3000000000000000000000000000000000000000000000000000000005f5260045ffd5b9181601f840112156101765782359167ffffffffffffffff8311610176576020808501948460051b01011161017657565b91908110156104175760051b0190565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52603260045260245ffd5b3573ffffffffffffffffffffffffffffffffffffffff811681036101765790565b90601f7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0910116810190811067ffffffffffffffff8211176104a657604052565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b3d1561052b573d9067ffffffffffffffff82116104a65760405191610520601f82017fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe01660200184610465565b82523d5f602084013e565b606090565b90816020910312610176575180151581036101765790565b9073ffffffffffffffffffffffffffffffffffffffff6105b692165f8060405193610574604086610465565b602085527f5361666545524332303a206c6f772d6c6576656c2063616c6c206661696c6564602086015260208151910182855af16105b06104d3565b9161066a565b8051908115918215610650575b5050156105cc57565b60846040517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152602a60248201527f5361666545524332303a204552433230206f7065726174696f6e20646964206e60448201527f6f742073756363656564000000000000000000000000000000000000000000006064820152fd5b6106639250602080918301019101610530565b5f806105c3565b919290156106e5575081511561067e575090565b3b156106875790565b60646040517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152601d60248201527f416464726573733a2063616c6c20746f206e6f6e2d636f6e74726163740000006044820152fd5b8251909150156106f85750805190602001fd5b60446020917fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0601f6040519485937f08c379a00000000000000000000000000000000000000000000000000000000085528160048601528051918291826024880152018686015e5f85828601015201168101030190fd"

    public static let InvalidInputError = ABI.Function(
        name: "InvalidInput",
        inputs: []
    )

    public enum RevertReason: Equatable, Error {
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
    public static let functions: [ABI.Function] = [runFn]
    public static let runFn = ABI.Function(
        name: "run",
        inputs: [.address, .array(.address), .array(.uint256), .address, .uint256],
        outputs: []
    )

    public static func run(comet: EthAddress, assets: [EthAddress], amounts: [BigUInt], baseAsset: EthAddress, borrow: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try runFn.encoded(with: [.address(comet), .array(.address, assets.map {
                .address($0)
            }), .array(.uint256, amounts.map {
                .uint256($0)
            }), .address(baseAsset), .uint256(borrow)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try runFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, runFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func runDecode(input: Hex) throws -> (EthAddress, [EthAddress], [BigUInt], EthAddress, BigUInt) {
        let decodedInput = try runFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple5(.address(comet), .array(.address, assets), .array(.uint256, amounts), .address(baseAsset), .uint256(borrow)):
            return (comet, assets.map { $0.asEthAddress! }, amounts.map { $0.asBigUInt! }, baseAsset, borrow)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, runFn.inputTuple)
        }
    }
}