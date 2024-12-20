@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum CometWithdrawActions {
    public static let creationCode: Hex = "0x608060405234601c57600e6020565b6108da61002b82396108da90f35b6026565b60405190565b5f80fdfe60806040526004361015610013575b61038b565b61001d5f3561005c565b806306c0b3cc14610057578063347a377f1461005257806346f711ad1461004d5763d9caed120361000e57610357565b6102e6565b610259565b61012d565b60e01c90565b60405190565b5f80fd5b5f80fd5b5f80fd5b73ffffffffffffffffffffffffffffffffffffffff1690565b61009690610074565b90565b6100a28161008d565b036100a957565b5f80fd5b905035906100ba82610099565b565b90565b6100c8816100bc565b036100cf57565b5f80fd5b905035906100e0826100bf565b565b608081830312610123576100f8825f83016100ad565b9261012061010984602085016100ad565b9361011781604086016100ad565b936060016100d3565b90565b61006c565b5f0190565b3461015f576101496101403660046100e2565b929190916104b3565b610151610062565b8061015b81610128565b0390f35b610068565b5f80fd5b5f80fd5b5f80fd5b909182601f830112156101aa5781359167ffffffffffffffff83116101a55760200192602083028401116101a057565b61016c565b610168565b610164565b909182601f830112156101e95781359167ffffffffffffffff83116101e45760200192602083028401116101df57565b61016c565b610168565b610164565b60608183031261025457610204825f83016100ad565b92602082013567ffffffffffffffff811161024f5783610225918401610170565b929093604082013567ffffffffffffffff811161024a5761024692016101af565b9091565b610070565b610070565b61006c565b3461028b5761027561026c3660046101ee565b93929092610612565b61027d610062565b8061028781610128565b0390f35b610068565b919060a0838203126102e1576102a8815f85016100ad565b926102b682602083016100ad565b926102de6102c784604085016100ad565b936102d581606086016100ad565b936080016100d3565b90565b61006c565b34610318576103026102f9366004610290565b939290926107b1565b61030a610062565b8061031481610128565b0390f35b610068565b90916060828403126103525761034f610338845f85016100ad565b9361034681602086016100ad565b936040016100d3565b90565b61006c565b346103865761037061036a36600461031d565b91610849565b610378610062565b8061038281610128565b0390f35b610068565b5f80fd5b90565b6103a66103a16103ab92610074565b61038f565b610074565b90565b6103b790610392565b90565b6103c3906103ae565b90565b6103cf90610392565b90565b6103db906103c6565b90565b5f80fd5b601f801991011690565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b90610423906103e2565b810190811067ffffffffffffffff82111761043d57604052565b6103ec565b60e01b90565b5f91031261045257565b61006c565b6104609061008d565b9052565b61046d906100bc565b9052565b60409061049a6104a1949695939661049060608401985f850190610457565b6020830190610457565b0190610464565b565b6104ab610062565b3d5f823e3d90fd5b6104c26104c7919392936103ba565b6103d2565b63c3b35a7e92919392813b15610543575f6104f59161050082966104e9610062565b98899788968795610442565b855260048501610471565b03925af1801561053e57610512575b50565b610531905f3d8111610537575b6105298183610419565b810190610448565b5f61050f565b503d61051f565b6104a3565b6103de565b5090565b5090565b90565b61056761056261056c92610550565b61038f565b6100bc565b90565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52603260045260245ffd5b91908110156105ac576020020190565b61056f565b356105bb81610099565b90565b91908110156105ce576020020190565b61056f565b356105dd816100bf565b90565b9160206106019294936105fa60408201965f830190610457565b0190610464565b565b600161060f91016100bc565b90565b949390929194610623848790610548565b61063f61063961063486869061054c565b6100bc565b916100bc565b0361073e5761064d5f610553565b5b8061066b610665610660888b90610548565b6100bc565b916100bc565b10156107355761068261067d836103ba565b6103d2565b9063f3fef3a361069c610697888b859161059c565b6105b1565b6106b06106ab888886916105be565b6105d3565b93803b15610730576106d55f80946106e06106c9610062565b98899687958694610442565b8452600484016105e0565b03925af191821561072b576106fa926106ff575b50610603565b61064e565b61071e905f3d8111610724575b6107168183610419565b810190610448565b5f6106f4565b503d61070c565b6104a3565b6103de565b50505050509050565b5f7fb4fa3fb30000000000000000000000000000000000000000000000000000000081528061076f60048201610128565b0390fd5b6107a86107af9461079e606094989795610794608086019a5f870190610457565b6020850190610457565b6040830190610457565b0190610464565b565b6107c16107c691959294956103ba565b6103d2565b90632644131893929490823b15610844575f9461080186926107f6946107ea610062565b998a9889978896610442565b865260048601610773565b03925af1801561083f57610813575b50565b610832905f3d8111610838575b61082a8183610419565b810190610448565b5f610810565b503d610820565b6104a3565b6103de565b61085561085a916103ba565b6103d2565b9163f3fef3a3919092803b156108d5576108875f809461089261087b610062565b97889687958694610442565b8452600484016105e0565b03925af180156108d0576108a4575b50565b6108c3905f3d81116108c9575b6108bb8183610419565b810190610448565b5f6108a1565b503d6108b1565b6104a3565b6103de56"
    public static let runtimeCode: Hex = "0x60806040526004361015610013575b61038b565b61001d5f3561005c565b806306c0b3cc14610057578063347a377f1461005257806346f711ad1461004d5763d9caed120361000e57610357565b6102e6565b610259565b61012d565b60e01c90565b60405190565b5f80fd5b5f80fd5b5f80fd5b73ffffffffffffffffffffffffffffffffffffffff1690565b61009690610074565b90565b6100a28161008d565b036100a957565b5f80fd5b905035906100ba82610099565b565b90565b6100c8816100bc565b036100cf57565b5f80fd5b905035906100e0826100bf565b565b608081830312610123576100f8825f83016100ad565b9261012061010984602085016100ad565b9361011781604086016100ad565b936060016100d3565b90565b61006c565b5f0190565b3461015f576101496101403660046100e2565b929190916104b3565b610151610062565b8061015b81610128565b0390f35b610068565b5f80fd5b5f80fd5b5f80fd5b909182601f830112156101aa5781359167ffffffffffffffff83116101a55760200192602083028401116101a057565b61016c565b610168565b610164565b909182601f830112156101e95781359167ffffffffffffffff83116101e45760200192602083028401116101df57565b61016c565b610168565b610164565b60608183031261025457610204825f83016100ad565b92602082013567ffffffffffffffff811161024f5783610225918401610170565b929093604082013567ffffffffffffffff811161024a5761024692016101af565b9091565b610070565b610070565b61006c565b3461028b5761027561026c3660046101ee565b93929092610612565b61027d610062565b8061028781610128565b0390f35b610068565b919060a0838203126102e1576102a8815f85016100ad565b926102b682602083016100ad565b926102de6102c784604085016100ad565b936102d581606086016100ad565b936080016100d3565b90565b61006c565b34610318576103026102f9366004610290565b939290926107b1565b61030a610062565b8061031481610128565b0390f35b610068565b90916060828403126103525761034f610338845f85016100ad565b9361034681602086016100ad565b936040016100d3565b90565b61006c565b346103865761037061036a36600461031d565b91610849565b610378610062565b8061038281610128565b0390f35b610068565b5f80fd5b90565b6103a66103a16103ab92610074565b61038f565b610074565b90565b6103b790610392565b90565b6103c3906103ae565b90565b6103cf90610392565b90565b6103db906103c6565b90565b5f80fd5b601f801991011690565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b90610423906103e2565b810190811067ffffffffffffffff82111761043d57604052565b6103ec565b60e01b90565b5f91031261045257565b61006c565b6104609061008d565b9052565b61046d906100bc565b9052565b60409061049a6104a1949695939661049060608401985f850190610457565b6020830190610457565b0190610464565b565b6104ab610062565b3d5f823e3d90fd5b6104c26104c7919392936103ba565b6103d2565b63c3b35a7e92919392813b15610543575f6104f59161050082966104e9610062565b98899788968795610442565b855260048501610471565b03925af1801561053e57610512575b50565b610531905f3d8111610537575b6105298183610419565b810190610448565b5f61050f565b503d61051f565b6104a3565b6103de565b5090565b5090565b90565b61056761056261056c92610550565b61038f565b6100bc565b90565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52603260045260245ffd5b91908110156105ac576020020190565b61056f565b356105bb81610099565b90565b91908110156105ce576020020190565b61056f565b356105dd816100bf565b90565b9160206106019294936105fa60408201965f830190610457565b0190610464565b565b600161060f91016100bc565b90565b949390929194610623848790610548565b61063f61063961063486869061054c565b6100bc565b916100bc565b0361073e5761064d5f610553565b5b8061066b610665610660888b90610548565b6100bc565b916100bc565b10156107355761068261067d836103ba565b6103d2565b9063f3fef3a361069c610697888b859161059c565b6105b1565b6106b06106ab888886916105be565b6105d3565b93803b15610730576106d55f80946106e06106c9610062565b98899687958694610442565b8452600484016105e0565b03925af191821561072b576106fa926106ff575b50610603565b61064e565b61071e905f3d8111610724575b6107168183610419565b810190610448565b5f6106f4565b503d61070c565b6104a3565b6103de565b50505050509050565b5f7fb4fa3fb30000000000000000000000000000000000000000000000000000000081528061076f60048201610128565b0390fd5b6107a86107af9461079e606094989795610794608086019a5f870190610457565b6020850190610457565b6040830190610457565b0190610464565b565b6107c16107c691959294956103ba565b6103d2565b90632644131893929490823b15610844575f9461080186926107f6946107ea610062565b998a9889978896610442565b865260048601610773565b03925af1801561083f57610813575b50565b610832905f3d8111610838575b61082a8183610419565b810190610448565b5f610810565b503d610820565b6104a3565b6103de565b61085561085a916103ba565b6103d2565b9163f3fef3a3919092803b156108d5576108875f809461089261087b610062565b97889687958694610442565b8452600484016105e0565b03925af180156108d0576108a4575b50565b6108c3905f3d81116108c9575b6108bb8183610419565b810190610448565b5f6108a1565b503d6108b1565b6104a3565b6103de56"

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
    public static let functions: [ABI.Function] = [withdrawFn, withdrawFromFn, withdrawMultipleAssetsFn, withdrawToFn]
    public static let withdrawFn = ABI.Function(
        name: "withdraw",
        inputs: [.address, .address, .uint256],
        outputs: []
    )

    public static func withdraw(comet: EthAddress, asset: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try withdrawFn.encoded(with: [.address(comet), .address(asset), .uint256(amount)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try withdrawFn.decode(output: result)

            switch decoded {
            case .tuple0:
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
            return (comet, asset, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, withdrawFn.inputTuple)
        }
    }

    public static let withdrawFromFn = ABI.Function(
        name: "withdrawFrom",
        inputs: [.address, .address, .address, .address, .uint256],
        outputs: []
    )

    public static func withdrawFrom(comet: EthAddress, from: EthAddress, to: EthAddress, asset: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try withdrawFromFn.encoded(with: [.address(comet), .address(from), .address(to), .address(asset), .uint256(amount)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try withdrawFromFn.decode(output: result)

            switch decoded {
            case .tuple0:
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
            return (comet, from, to, asset, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, withdrawFromFn.inputTuple)
        }
    }

    public static let withdrawMultipleAssetsFn = ABI.Function(
        name: "withdrawMultipleAssets",
        inputs: [.address, .array(.address), .array(.uint256)],
        outputs: []
    )

    public static func withdrawMultipleAssets(comet: EthAddress, assets: [EthAddress], amounts: [BigUInt], withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try withdrawMultipleAssetsFn.encoded(with: [.address(comet), .array(.address, assets.map {
                .address($0)
            }), .array(.uint256, amounts.map {
                .uint256($0)
            })])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try withdrawMultipleAssetsFn.decode(output: result)

            switch decoded {
            case .tuple0:
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
            return (comet, assets.map { $0.asEthAddress! }, amounts.map { $0.asBigUInt! })
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, withdrawMultipleAssetsFn.inputTuple)
        }
    }

    public static let withdrawToFn = ABI.Function(
        name: "withdrawTo",
        inputs: [.address, .address, .address, .uint256],
        outputs: []
    )

    public static func withdrawTo(comet: EthAddress, to: EthAddress, asset: EthAddress, amount: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try withdrawToFn.encoded(with: [.address(comet), .address(to), .address(asset), .uint256(amount)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try withdrawToFn.decode(output: result)

            switch decoded {
            case .tuple0:
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
            return (comet, to, asset, amount)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, withdrawToFn.inputTuple)
        }
    }
}
