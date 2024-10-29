// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.27;

import {QuarkBuilder} from "./QuarkBuilder.sol";
import {CCTPBridgeActions} from "../BridgeScripts.sol";
import {AcrossActions} from "../AcrossScripts.sol";

import "./Strings.sol";

library BridgeRoutes {
    function canBridge(uint256 srcChainId, uint256 dstChainId, string memory assetSymbol)
        internal
        pure
        returns (bool)
    {
        return
            CCTP.canBridge(srcChainId, dstChainId, assetSymbol) || Across.canBridge(srcChainId, dstChainId, assetSymbol);
    }

    // TODO: GENERIC FUNCTION TO BRIDGE OVER FUNDS, PICKING THE BEST ROUTE
}

library CCTP {
    error NoKnownBridge(string bridgeType, uint256 srcChainId);
    error NoKnownDomainId(string bridgeType, uint256 dstChainId);

    struct CCTPChain {
        uint256 chainId;
        uint32 domainId;
        address bridge;
    }

    function knownChains() internal pure returns (CCTPChain[] memory) {
        CCTPChain[] memory chains = new CCTPChain[](4);
        // Mainnet
        chains[0] = CCTPChain({chainId: 1, domainId: 0, bridge: 0xBd3fa81B58Ba92a82136038B25aDec7066af3155});
        // Base
        chains[1] = CCTPChain({chainId: 8453, domainId: 6, bridge: 0x1682Ae6375C4E4A97e4B583BC394c861A46D8962});
        // Sepolia
        chains[2] = CCTPChain({chainId: 11155111, domainId: 0, bridge: 0x9f3B8679c73C2Fef8b59B4f3444d4e156fb70AA5});
        // Base Sepolia
        chains[3] = CCTPChain({chainId: 84532, domainId: 6, bridge: 0x9f3B8679c73C2Fef8b59B4f3444d4e156fb70AA5});
        return chains;
    }

    function knownChain(uint256 chainId) internal pure returns (CCTPChain memory found) {
        CCTPChain[] memory cctpChains = knownChains();
        for (uint256 i = 0; i < cctpChains.length; ++i) {
            if (cctpChains[i].chainId == chainId) {
                return found = cctpChains[i];
            }
        }
    }

    function canBridge(uint256 srcChainId, uint256 dstChainId, string memory assetSymbol)
        internal
        pure
        returns (bool)
    {
        return Strings.stringEqIgnoreCase(assetSymbol, "USDC") && knownChain(srcChainId).bridge != address(0)
            && knownChain(dstChainId).chainId == dstChainId;
    }

    function knownDomainId(uint256 dstChainId) internal pure returns (uint32) {
        CCTPChain memory chain = knownChain(dstChainId);
        if (chain.chainId != 0) {
            return chain.domainId;
        } else {
            revert NoKnownDomainId("CCTP", dstChainId);
        }
    }

    function knownBridge(uint256 srcChainId) internal pure returns (address) {
        CCTPChain memory chain = knownChain(srcChainId);
        if (chain.bridge != address(0)) {
            return chain.bridge;
        } else {
            revert NoKnownBridge("CCTP", srcChainId);
        }
    }

    function bridgeScriptSource() internal pure returns (bytes memory) {
        return type(CCTPBridgeActions).creationCode;
    }

    function encodeBridgeUSDC(
        uint256 srcChainId,
        uint256 dstChainId,
        uint256 amount,
        address recipient,
        address usdcAddress
    ) internal pure returns (bytes memory) {
        return abi.encodeWithSelector(
            CCTPBridgeActions.bridgeUSDC.selector,
            knownBridge(srcChainId),
            amount,
            knownDomainId(dstChainId),
            bytes32(uint256(uint160(recipient))),
            usdcAddress
        );
    }
}

// TODO: split into bridge sub-directory
library Across {
    error NoKnownBridge(string bridgeType, uint256 srcChainId);

    struct AcrossChain {
        uint256 chainId;
        address bridge; // SpokePool contract
    }

    function knownChains() internal pure returns (AcrossChain[] memory) {
        AcrossChain[] memory chains = new AcrossChain[](4);
        // Mainnet
        chains[0] = AcrossChain({chainId: 1, bridge: 0x5c7BCd6E7De5423a257D81B442095A1a6ced35C5});
        // Base
        chains[1] = AcrossChain({chainId: 8453, bridge: 0x09aea4b2242abC8bb4BB78D537A67a245A7bEC64});
        // Sepolia
        chains[2] = AcrossChain({chainId: 11155111, bridge: 0x5ef6C01E11889d86803e0B23e3cB3F9E9d97B662});
        // Base Sepolia
        chains[3] = AcrossChain({chainId: 84532, bridge: 0x82B564983aE7274c86695917BBf8C99ECb6F0F8F});
        return chains;
    }

    function knownChain(uint256 chainId) internal pure returns (AcrossChain memory found) {
        AcrossChain[] memory acrossChains = knownChains();
        for (uint256 i = 0; i < acrossChains.length; ++i) {
            if (acrossChains[i].chainId == chainId) {
                return found = acrossChains[i];
            }
        }
    }

    // TODO
    function canBridge(uint256 srcChainId, uint256 dstChainId, string memory assetSymbol)
        internal
        pure
        returns (bool)
    {
        // TODO: FFI to across to figure out? probably not
        //       OR maintain a list of supported bridgeable assets?
        return knownChain(srcChainId).bridge != address(0) && knownChain(dstChainId).chainId == dstChainId;
    }

    function knownBridge(uint256 srcChainId) internal pure returns (address) {
        AcrossChain memory chain = knownChain(srcChainId);
        if (chain.bridge != address(0)) {
            return chain.bridge;
        } else {
            revert NoKnownBridge("Across", srcChainId);
        }
    }

    function bridgeScriptSource() internal pure returns (bytes memory) {
        return type(AcrossActions).creationCode;
    }

    function encodeBridgeAction(
        uint256 srcChainId,
        uint256 dstChainId,
        address inputToken,
        address outputToken,
        uint256 inputAmount,
        uint256 outputAmount,
        address recipient,
        uint256 blockTimestamp,
        bool useNativeToken
    ) internal pure returns (bytes memory) {
        return abi.encodeCall(
            AcrossActions.depositV3,
            (
                knownBridge(srcChainId), // spokePool
                // TODO: should be account? instead of recipient
                recipient, // depositor
                recipient, // recipient
                inputToken, // inputToken
                outputToken, // outputToken
                inputAmount, // inputAmount
                outputAmount, // outputAmount
                dstChainId, // destinationChainId
                address(0), // exclusiveRelayer
                // TODO: need to get an exact quote timestamp
                uint32(blockTimestamp), // quoteTimestamp
                // TODO: 10 min for now, set as constant
                uint32(blockTimestamp + 600), // fillDeadline
                0, // exclusivityDeadline
                new bytes(0), // message
                useNativeToken // useNativeToken
            )
        );
    }
}
