@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum CCTPBridgeActions {
    public static let creationCode: Hex = "0x6080806040523460155761023f908161001a8239f35b5f80fdfe6080806040526004361015610012575f80fd5b5f3560e01c6331be912514610025575f80fd5b3461017d5760a07ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc36011261017d5760043573ffffffffffffffffffffffffffffffffffffffff811680910361017d57602435906044359063ffffffff821680920361017d576084359373ffffffffffffffffffffffffffffffffffffffff851680950361017d577f095ea7b30000000000000000000000000000000000000000000000000000000081528160048201528360248201526020816044815f895af1801561018957610194575b506020925f60849260405196879586947f6fd3504e00000000000000000000000000000000000000000000000000000000865260048601526024850152606435604485015260648401525af180156101895761014957005b6020813d602011610181575b81610162602093836101d1565b8101031261017d575167ffffffffffffffff81160361017d57005b5f80fd5b3d9150610155565b6040513d5f823e3d90fd5b6020813d6020116101c9575b816101ad602093836101d1565b8101031261017d575192831515840361017d57925060206100f1565b3d91506101a0565b90601f7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0910116810190811067ffffffffffffffff82111761021257604052565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd"
    public static let runtimeCode: Hex = "0x6080806040526004361015610012575f80fd5b5f3560e01c6331be912514610025575f80fd5b3461017d5760a07ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc36011261017d5760043573ffffffffffffffffffffffffffffffffffffffff811680910361017d57602435906044359063ffffffff821680920361017d576084359373ffffffffffffffffffffffffffffffffffffffff851680950361017d577f095ea7b30000000000000000000000000000000000000000000000000000000081528160048201528360248201526020816044815f895af1801561018957610194575b506020925f60849260405196879586947f6fd3504e00000000000000000000000000000000000000000000000000000000865260048601526024850152606435604485015260648401525af180156101895761014957005b6020813d602011610181575b81610162602093836101d1565b8101031261017d575167ffffffffffffffff81160361017d57005b5f80fd5b3d9150610155565b6040513d5f823e3d90fd5b6020813d6020116101c9575b816101ad602093836101d1565b8101031261017d575192831515840361017d57925060206100f1565b3d91506101a0565b90601f7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0910116810190811067ffffffffffffffff82111761021257604052565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd"

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
    public static let functions: [ABI.Function] = [bridgeUSDCFn]
    public static let bridgeUSDCFn = ABI.Function(
        name: "bridgeUSDC",
        inputs: [.address, .uint256, .uint32, .bytes32, .address],
        outputs: []
    )

    public static func bridgeUSDC(tokenMessenger: EthAddress, amount: BigUInt, destinationDomain: UInt, mintRecipient: Hex, burnToken: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try bridgeUSDCFn.encoded(with: [.address(tokenMessenger), .uint256(amount), .uint32(destinationDomain), .bytes32(mintRecipient), .address(burnToken)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try bridgeUSDCFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, bridgeUSDCFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }
}
