@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum WrapperActions {
    public static let creationCode: Hex = "0x608060405234601c57600e6020565b610fe161002b8239610fe190f35b6026565b60405190565b5f80fdfe60806040526004361015610013575b6103c7565b61001d5f356100bb565b80628342b6146100b657806315a05a4e146100b15780631e64918f146100ac57806329793f7d146100a757806334ce5dc4146100a257806348ab02c41461009d5780635869dba814610098578063a91a3f1014610093578063b781a58a1461008e5763e3d45a830361000e57610393565b61032f565b610306565b6102d2565b6102a8565b610252565b610228565b6101f5565b6101a3565b61016f565b60e01c90565b60405190565b5f80fd5b5f80fd5b73ffffffffffffffffffffffffffffffffffffffff1690565b6100f1906100cf565b90565b6100fd816100e8565b0361010457565b5f80fd5b90503590610115826100f4565b565b90565b61012381610117565b0361012a57565b5f80fd5b9050359061013b8261011a565b565b91906040838203126101655780610159610162925f8601610108565b9360200161012e565b90565b6100cb565b5f0190565b3461019e5761018861018236600461013d565b90610523565b6101906100c1565b8061019a8161016a565b0390f35b6100c7565b346101d2576101bc6101b636600461013d565b9061063a565b6101c46100c1565b806101ce8161016a565b0390f35b6100c7565b906020828203126101f0576101ed915f01610108565b90565b6100cb565b346102235761020d6102083660046101d7565b610721565b6102156100c1565b8061021f8161016a565b0390f35b6100c7565b61023c61023636600461013d565b90610852565b6102446100c1565b8061024e8161016a565b0390f35b6102656102603660046101d7565b6108e2565b61026d6100c1565b806102778161016a565b0390f35b91906040838203126102a357806102976102a0925f8601610108565b93602001610108565b90565b6100cb565b6102bc6102b636600461027b565b90610a8a565b6102c46100c1565b806102ce8161016a565b0390f35b34610301576102eb6102e536600461013d565b90610c43565b6102f36100c1565b806102fd8161016a565b0390f35b6100c7565b6103196103143660046101d7565b610cd3565b6103216100c1565b8061032b8161016a565b0390f35b61034361033d36600461013d565b90610d8e565b61034b6100c1565b806103558161016a565b0390f35b909160608284031261038e5761038b610374845f8501610108565b936103828160208601610108565b9360400161012e565b90565b6100cb565b346103c2576103ac6103a6366004610359565b91610ed8565b6103b46100c1565b806103be8161016a565b0390f35b6100c7565b5f80fd5b90565b6103e26103dd6103e7926100cf565b6103cb565b6100cf565b90565b6103f3906103ce565b90565b6103ff906103ea565b90565b61040b906103ce565b90565b61041790610402565b90565b610423906103ea565b90565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b61046261046891939293610117565b92610117565b820391821161047357565b610426565b5f80fd5b601f801991011690565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b906104bd9061047c565b810190811067ffffffffffffffff8211176104d757604052565b610486565b60e01b90565b5f9103126104ec57565b6100cb565b6104fa90610117565b9052565b9190610511905f602085019401906104f1565b565b61051b6100c1565b3d5f823e3d90fd5b9061052d306103f6565b31918261054261053c84610117565b91610117565b1061054d575b505050565b61056161055c61056d9261040e565b61041a565b92632e1a7d4d92610453565b823b156105e45761059d926105925f80946105866100c1565b968795869485936104dc565b8352600483016104fe565b03925af180156105df576105b3575b8080610548565b6105d2905f3d81116105d8575b6105ca81836104b3565b8101906104e2565b5f6105ac565b503d6105c0565b610513565b610478565b6105f2906103ce565b90565b6105fe906105e9565b90565b61060a906103ea565b90565b9050519061061a8261011a565b565b9060208282031261063557610632915f0161060d565b90565b6100cb565b6106799161065161064c6020936105f5565b610601565b61066e5f63de0e9a3e6106626100c1565b968795869485936104dc565b8352600483016104fe565b03925af180156106b75761068b575b50565b6106ab9060203d81116106b0575b6106a381836104b3565b81019061061c565b610688565b503d610699565b610513565b6106c5906103ce565b90565b6106d1906106bc565b90565b6106dd906103ea565b90565b6106e9906100e8565b9052565b9190610700905f602085019401906106e0565b565b90565b61071961071461071e92610702565b6103cb565b610117565b90565b6107696020610737610732846106c8565b6106d4565b6370a082319061075e610749306103f6565b926107526100c1565b958694859384936104dc565b8352600483016106ed565b03915afa90811561084d575f9161081f575b50908161079061078a5f610705565b91610117565b1161079a575b5050565b6107d9916107b16107ac6020936105f5565b610601565b6107ce5f63de0e9a3e6107c26100c1565b968795869485936104dc565b8352600483016104fe565b03925af1801561081a576107ee575b80610796565b61080e9060203d8111610813575b61080681836104b3565b81019061061c565b6107e8565b503d6107fc565b610513565b610840915060203d8111610846575b61083881836104b3565b81019061061c565b5f61077b565b503d61082e565b610513565b61085e6108639161040e565b61041a565b9063d0e30db0909190813b156108dd575f9161088b916108816100c1565b94859384926104dc565b82528161089a6004820161016a565b03925af180156108d8576108ac575b50565b6108cb905f3d81116108d1575b6108c381836104b3565b8101906104e2565b5f6108a9565b503d6108b9565b610513565b610478565b61092a60206108f86108f3846106c8565b6106d4565b6370a082319061091f61090a306103f6565b926109136100c1565b958694859384936104dc565b8352600483016106ed565b03915afa908115610a1c575f916109ee575b50908161095161094b5f610705565b91610117565b1161095b575b5050565b61096761096c9161040e565b61041a565b90632e1a7d4d90823b156109e9576109a3926109985f809461098c6100c1565b968795869485936104dc565b8352600483016104fe565b03925af180156109e4576109b8575b80610957565b6109d7905f3d81116109dd575b6109cf81836104b3565b8101906104e2565b5f6109b2565b503d6109c5565b610513565b610478565b610a0f915060203d8111610a15575b610a0781836104b3565b81019061061c565b5f61093c565b503d6109fd565b610513565b151590565b610a2f81610a21565b03610a3657565b5f80fd5b90505190610a4782610a26565b565b90602082820312610a6257610a5f915f01610a3a565b90565b6100cb565b916020610a88929493610a8160408201965f8301906106e0565b01906104f1565b565b610ad26020610aa0610a9b856106c8565b6106d4565b6370a0823190610ac7610ab2306103f6565b92610abb6100c1565b958694859384936104dc565b8352600483016106ed565b03915afa908115610c3e575f91610c10575b509182610af9610af35f610705565b91610117565b11610b04575b505050565b610b10610b15916106c8565b6106d4565b91602063095ea7b3938390610b3d5f8597610b48610b316100c1565b998a96879586946104dc565b845260048401610a67565b03925af1928315610c0b57610b6c602093610b7192610b9996610be0575b506105f5565b610601565b610b8e5f63ea598cb0610b826100c1565b968795869485936104dc565b8352600483016104fe565b03925af18015610bdb57610baf575b8080610aff565b610bcf9060203d8111610bd4575b610bc781836104b3565b81019061061c565b610ba8565b503d610bbd565b610513565b610bff90863d8111610c04575b610bf781836104b3565b810190610a49565b610b66565b503d610bed565b610513565b610c31915060203d8111610c37575b610c2981836104b3565b81019061061c565b5f610ae4565b503d610c1f565b610513565b610c4f610c549161040e565b61041a565b90632e1a7d4d90823b15610cce57610c8b92610c805f8094610c746100c1565b968795869485936104dc565b8352600483016104fe565b03925af18015610cc957610c9d575b50565b610cbc905f3d8111610cc2575b610cb481836104b3565b8101906104e2565b5f610c9a565b503d610caa565b610513565b610478565b610cdc306103f6565b319081610cf1610ceb5f610705565b91610117565b11610cfb575b5050565b610d07610d0c9161040e565b61041a565b9063d0e30db0909190813b15610d89575f91610d3491610d2a6100c1565b94859384926104dc565b825281610d436004820161016a565b03925af18015610d8457610d58575b80610cf7565b610d77905f3d8111610d7d575b610d6f81836104b3565b8101906104e2565b5f610d52565b503d610d65565b610513565b610478565b90610dd76020610da5610da0856106c8565b6106d4565b6370a0823190610dcc610db7306103f6565b92610dc06100c1565b958694859384936104dc565b8352600483016106ed565b03915afa908115610ed3575f91610ea5575b509182610dfe610df884610117565b91610117565b10610e09575b505050565b610e1d610e18610e299261040e565b61041a565b9263d0e30db092610453565b9190813b15610ea0575f91610e4a91610e406100c1565b94859384926104dc565b825281610e596004820161016a565b03925af18015610e9b57610e6f575b8080610e04565b610e8e905f3d8111610e94575b610e8681836104b3565b8101906104e2565b5f610e68565b503d610e7c565b610513565b610478565b610ec6915060203d8111610ecc575b610ebe81836104b3565b81019061061c565b5f610de9565b503d610eb4565b610513565b90610ee5610eea916106c8565b6106d4565b91602063095ea7b3938390610f125f8597610f1d610f066100c1565b998a96879586946104dc565b845260048401610a67565b03925af1928315610fdc57610f41602093610f4692610f6e96610fb1575b506105f5565b610601565b610f635f63ea598cb0610f576100c1565b968795869485936104dc565b8352600483016104fe565b03925af18015610fac57610f80575b50565b610fa09060203d8111610fa5575b610f9881836104b3565b81019061061c565b610f7d565b503d610f8e565b610513565b610fd090863d8111610fd5575b610fc881836104b3565b810190610a49565b610f3b565b503d610fbe565b61051356"
    public static let runtimeCode: Hex = "0x60806040526004361015610013575b6103c7565b61001d5f356100bb565b80628342b6146100b657806315a05a4e146100b15780631e64918f146100ac57806329793f7d146100a757806334ce5dc4146100a257806348ab02c41461009d5780635869dba814610098578063a91a3f1014610093578063b781a58a1461008e5763e3d45a830361000e57610393565b61032f565b610306565b6102d2565b6102a8565b610252565b610228565b6101f5565b6101a3565b61016f565b60e01c90565b60405190565b5f80fd5b5f80fd5b73ffffffffffffffffffffffffffffffffffffffff1690565b6100f1906100cf565b90565b6100fd816100e8565b0361010457565b5f80fd5b90503590610115826100f4565b565b90565b61012381610117565b0361012a57565b5f80fd5b9050359061013b8261011a565b565b91906040838203126101655780610159610162925f8601610108565b9360200161012e565b90565b6100cb565b5f0190565b3461019e5761018861018236600461013d565b90610523565b6101906100c1565b8061019a8161016a565b0390f35b6100c7565b346101d2576101bc6101b636600461013d565b9061063a565b6101c46100c1565b806101ce8161016a565b0390f35b6100c7565b906020828203126101f0576101ed915f01610108565b90565b6100cb565b346102235761020d6102083660046101d7565b610721565b6102156100c1565b8061021f8161016a565b0390f35b6100c7565b61023c61023636600461013d565b90610852565b6102446100c1565b8061024e8161016a565b0390f35b6102656102603660046101d7565b6108e2565b61026d6100c1565b806102778161016a565b0390f35b91906040838203126102a357806102976102a0925f8601610108565b93602001610108565b90565b6100cb565b6102bc6102b636600461027b565b90610a8a565b6102c46100c1565b806102ce8161016a565b0390f35b34610301576102eb6102e536600461013d565b90610c43565b6102f36100c1565b806102fd8161016a565b0390f35b6100c7565b6103196103143660046101d7565b610cd3565b6103216100c1565b8061032b8161016a565b0390f35b61034361033d36600461013d565b90610d8e565b61034b6100c1565b806103558161016a565b0390f35b909160608284031261038e5761038b610374845f8501610108565b936103828160208601610108565b9360400161012e565b90565b6100cb565b346103c2576103ac6103a6366004610359565b91610ed8565b6103b46100c1565b806103be8161016a565b0390f35b6100c7565b5f80fd5b90565b6103e26103dd6103e7926100cf565b6103cb565b6100cf565b90565b6103f3906103ce565b90565b6103ff906103ea565b90565b61040b906103ce565b90565b61041790610402565b90565b610423906103ea565b90565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b61046261046891939293610117565b92610117565b820391821161047357565b610426565b5f80fd5b601f801991011690565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b906104bd9061047c565b810190811067ffffffffffffffff8211176104d757604052565b610486565b60e01b90565b5f9103126104ec57565b6100cb565b6104fa90610117565b9052565b9190610511905f602085019401906104f1565b565b61051b6100c1565b3d5f823e3d90fd5b9061052d306103f6565b31918261054261053c84610117565b91610117565b1061054d575b505050565b61056161055c61056d9261040e565b61041a565b92632e1a7d4d92610453565b823b156105e45761059d926105925f80946105866100c1565b968795869485936104dc565b8352600483016104fe565b03925af180156105df576105b3575b8080610548565b6105d2905f3d81116105d8575b6105ca81836104b3565b8101906104e2565b5f6105ac565b503d6105c0565b610513565b610478565b6105f2906103ce565b90565b6105fe906105e9565b90565b61060a906103ea565b90565b9050519061061a8261011a565b565b9060208282031261063557610632915f0161060d565b90565b6100cb565b6106799161065161064c6020936105f5565b610601565b61066e5f63de0e9a3e6106626100c1565b968795869485936104dc565b8352600483016104fe565b03925af180156106b75761068b575b50565b6106ab9060203d81116106b0575b6106a381836104b3565b81019061061c565b610688565b503d610699565b610513565b6106c5906103ce565b90565b6106d1906106bc565b90565b6106dd906103ea565b90565b6106e9906100e8565b9052565b9190610700905f602085019401906106e0565b565b90565b61071961071461071e92610702565b6103cb565b610117565b90565b6107696020610737610732846106c8565b6106d4565b6370a082319061075e610749306103f6565b926107526100c1565b958694859384936104dc565b8352600483016106ed565b03915afa90811561084d575f9161081f575b50908161079061078a5f610705565b91610117565b1161079a575b5050565b6107d9916107b16107ac6020936105f5565b610601565b6107ce5f63de0e9a3e6107c26100c1565b968795869485936104dc565b8352600483016104fe565b03925af1801561081a576107ee575b80610796565b61080e9060203d8111610813575b61080681836104b3565b81019061061c565b6107e8565b503d6107fc565b610513565b610840915060203d8111610846575b61083881836104b3565b81019061061c565b5f61077b565b503d61082e565b610513565b61085e6108639161040e565b61041a565b9063d0e30db0909190813b156108dd575f9161088b916108816100c1565b94859384926104dc565b82528161089a6004820161016a565b03925af180156108d8576108ac575b50565b6108cb905f3d81116108d1575b6108c381836104b3565b8101906104e2565b5f6108a9565b503d6108b9565b610513565b610478565b61092a60206108f86108f3846106c8565b6106d4565b6370a082319061091f61090a306103f6565b926109136100c1565b958694859384936104dc565b8352600483016106ed565b03915afa908115610a1c575f916109ee575b50908161095161094b5f610705565b91610117565b1161095b575b5050565b61096761096c9161040e565b61041a565b90632e1a7d4d90823b156109e9576109a3926109985f809461098c6100c1565b968795869485936104dc565b8352600483016104fe565b03925af180156109e4576109b8575b80610957565b6109d7905f3d81116109dd575b6109cf81836104b3565b8101906104e2565b5f6109b2565b503d6109c5565b610513565b610478565b610a0f915060203d8111610a15575b610a0781836104b3565b81019061061c565b5f61093c565b503d6109fd565b610513565b151590565b610a2f81610a21565b03610a3657565b5f80fd5b90505190610a4782610a26565b565b90602082820312610a6257610a5f915f01610a3a565b90565b6100cb565b916020610a88929493610a8160408201965f8301906106e0565b01906104f1565b565b610ad26020610aa0610a9b856106c8565b6106d4565b6370a0823190610ac7610ab2306103f6565b92610abb6100c1565b958694859384936104dc565b8352600483016106ed565b03915afa908115610c3e575f91610c10575b509182610af9610af35f610705565b91610117565b11610b04575b505050565b610b10610b15916106c8565b6106d4565b91602063095ea7b3938390610b3d5f8597610b48610b316100c1565b998a96879586946104dc565b845260048401610a67565b03925af1928315610c0b57610b6c602093610b7192610b9996610be0575b506105f5565b610601565b610b8e5f63ea598cb0610b826100c1565b968795869485936104dc565b8352600483016104fe565b03925af18015610bdb57610baf575b8080610aff565b610bcf9060203d8111610bd4575b610bc781836104b3565b81019061061c565b610ba8565b503d610bbd565b610513565b610bff90863d8111610c04575b610bf781836104b3565b810190610a49565b610b66565b503d610bed565b610513565b610c31915060203d8111610c37575b610c2981836104b3565b81019061061c565b5f610ae4565b503d610c1f565b610513565b610c4f610c549161040e565b61041a565b90632e1a7d4d90823b15610cce57610c8b92610c805f8094610c746100c1565b968795869485936104dc565b8352600483016104fe565b03925af18015610cc957610c9d575b50565b610cbc905f3d8111610cc2575b610cb481836104b3565b8101906104e2565b5f610c9a565b503d610caa565b610513565b610478565b610cdc306103f6565b319081610cf1610ceb5f610705565b91610117565b11610cfb575b5050565b610d07610d0c9161040e565b61041a565b9063d0e30db0909190813b15610d89575f91610d3491610d2a6100c1565b94859384926104dc565b825281610d436004820161016a565b03925af18015610d8457610d58575b80610cf7565b610d77905f3d8111610d7d575b610d6f81836104b3565b8101906104e2565b5f610d52565b503d610d65565b610513565b610478565b90610dd76020610da5610da0856106c8565b6106d4565b6370a0823190610dcc610db7306103f6565b92610dc06100c1565b958694859384936104dc565b8352600483016106ed565b03915afa908115610ed3575f91610ea5575b509182610dfe610df884610117565b91610117565b10610e09575b505050565b610e1d610e18610e299261040e565b61041a565b9263d0e30db092610453565b9190813b15610ea0575f91610e4a91610e406100c1565b94859384926104dc565b825281610e596004820161016a565b03925af18015610e9b57610e6f575b8080610e04565b610e8e905f3d8111610e94575b610e8681836104b3565b8101906104e2565b5f610e68565b503d610e7c565b610513565b610478565b610ec6915060203d8111610ecc575b610ebe81836104b3565b81019061061c565b5f610de9565b503d610eb4565b610513565b90610ee5610eea916106c8565b6106d4565b91602063095ea7b3938390610f125f8597610f1d610f066100c1565b998a96879586946104dc565b845260048401610a67565b03925af1928315610fdc57610f41602093610f4692610f6e96610fb1575b506105f5565b610601565b610f635f63ea598cb0610f576100c1565b968795869485936104dc565b8352600483016104fe565b03925af18015610fac57610f80575b50565b610fa09060203d8111610fa5575b610f9881836104b3565b81019061061c565b610f7d565b503d610f8e565b610513565b610fd090863d8111610fd5575b610fc881836104b3565b810190610a49565b610f3b565b503d610fbe565b61051356"

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
