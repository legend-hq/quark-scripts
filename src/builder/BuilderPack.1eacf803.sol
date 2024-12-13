// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

/// @dev Welcome to BuilderPack.
/// @dev BUILDERPACK-GENERATED-BY: CodeGen.sol v1
/// @dev BUILDERPACK-GENERATED-DATE: December 2nd, 2024
/// @dev DO NOT MODIFY THIS FILE BY HAND.

/// @dev BuilderPack libraries, meant to be consumed in other code.

struct KnownAsset {
    string name;
    string symbol;
    uint256 decimals;
    address assetAddress;
}

struct KnownPriceFeed {
    string symbolIn;
    string symbolOut;
    uint256 decimals;
    address priceFeed;
}

struct KnownComet {
    string name;
    string symbol;
    address cometAddress;
    address rewardsAddress;
    uint64 factorScale;
    address baseAsset;
    KnownCometCollateral[] collateralAssets;
}

struct KnownCometCollateral {
    address asset;
    uint128 supplyCap;
    address priceFeed;
    uint64 borrowCollateralFactor;
    uint64 liquidateCollateralFactor;
    uint64 liquidationFactor;
}

struct KnownNetwork {
    uint256 chainId;
    bool isTestnet;
    KnownAsset[] assets;
    KnownComet[] comets;
    KnownPriceFeed[] priceFeeds;
}

library BuilderPack {
    string constant VERSION = "1";
    string constant GENDATE = "December 2nd, 2024";

    function CHAINS() internal pure returns (uint256[] memory) {
        uint256[] memory chains = new uint256[](6);
        chains[0] = 1;
        chains[1] = 8453;
        chains[2] = 42161;
        chains[3] = 11155111;
        chains[4] = 84532;
        chains[5] = 421614;
        return chains;
    }

    function BLOCKS() internal pure returns (uint256[] memory) {
        uint256[] memory blocks = new uint256[](6);
        blocks[0] = 21317040;
        blocks[1] = 23189778;
        blocks[2] = 280669072;
        blocks[3] = 7195000;
        blocks[4] = 18700000;
        blocks[5] = 102700000;
        return blocks;
    }

    function LIBRARIES() internal pure returns (string[] memory) {
        string[] memory libraries = new string[](6);
        libraries[0] = "EthereumMainnet";
        libraries[1] = "BaseMainnet";
        libraries[2] = "ArbitrumMainnet";
        libraries[3] = "EthereumSepolia";
        libraries[4] = "BaseSepolia";
        libraries[5] = "ArbitrumSepolia";
        return libraries;
    }
}

error NotFound(string message, uint256 chainId);

library Chain {
    /// @dev Ether
    function ETH(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.ETH();
        } else if (chainId == 8453) {
            return BaseMainnet.ETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.ETH();
        } else if (chainId == 11155111) {
            return EthereumSepolia.ETH();
        } else if (chainId == 84532) {
            return BaseSepolia.ETH();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.ETH();
        } else {
            revert NotFound("Asset for Ether not found on chain", chainId);
        }
    }

    /// @dev USD Coin
    function USDC(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.USDC();
        } else if (chainId == 8453) {
            return BaseMainnet.USDC();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.USDC();
        } else if (chainId == 11155111) {
            return EthereumSepolia.USDC();
        } else if (chainId == 84532) {
            return BaseSepolia.USDC();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.USDC();
        } else {
            revert NotFound("Asset for USD Coin not found on chain", chainId);
        }
    }

    /// @dev Dai Stablecoin
    function DAI(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.DAI();
        } else {
            revert NotFound("Asset for Dai Stablecoin not found on chain", chainId);
        }
    }

    /// @dev Tether USD
    function USDT(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.USDT();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.USDT();
        } else {
            revert NotFound("Asset for Tether USD not found on chain", chainId);
        }
    }

    /// @dev Frax
    function FRAX(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.FRAX();
        } else {
            revert NotFound("Asset for Frax not found on chain", chainId);
        }
    }

    /// @dev USDe
    function USDe(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.USDe();
        } else {
            revert NotFound("Asset for USDe not found on chain", chainId);
        }
    }

    /// @dev Arbitrum
    function ARB(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.ARB();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.ARB();
        } else {
            revert NotFound("Asset for Arbitrum not found on chain", chainId);
        }
    }

    /// @dev Blur
    function BLUR(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.BLUR();
        } else {
            revert NotFound("Asset for Blur not found on chain", chainId);
        }
    }

    /// @dev Curve DAO Token
    function CRV(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.CRV();
        } else {
            revert NotFound("Asset for Curve DAO Token not found on chain", chainId);
        }
    }

    /// @dev ENA
    function ENA(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.ENA();
        } else {
            revert NotFound("Asset for ENA not found on chain", chainId);
        }
    }

    /// @dev Lido DAO Token
    function LDO(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.LDO();
        } else {
            revert NotFound("Asset for Lido DAO Token not found on chain", chainId);
        }
    }

    /// @dev Pendle
    function PENDLE(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.PENDLE();
        } else {
            revert NotFound("Asset for Pendle not found on chain", chainId);
        }
    }

    /// @dev Pepe
    function PEPE(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.PEPE();
        } else {
            revert NotFound("Asset for Pepe not found on chain", chainId);
        }
    }

    /// @dev Rocket Pool Protocol
    function RPL(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.RPL();
        } else {
            revert NotFound("Asset for Rocket Pool Protocol not found on chain", chainId);
        }
    }

    /// @dev SHIBA INU
    function SHIB(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.SHIB();
        } else {
            revert NotFound("Asset for SHIBA INU not found on chain", chainId);
        }
    }

    /// @dev Compound
    function COMP(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.COMP();
        } else if (chainId == 8453) {
            return BaseMainnet.COMP();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.COMP();
        } else if (chainId == 11155111) {
            return EthereumSepolia.COMP();
        } else if (chainId == 84532) {
            return BaseSepolia.COMP();
        } else {
            revert NotFound("Asset for Compound not found on chain", chainId);
        }
    }

    /// @dev Wrapped BTC
    function WBTC(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.WBTC();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.WBTC();
        } else if (chainId == 11155111) {
            return EthereumSepolia.WBTC();
        } else {
            revert NotFound("Asset for Wrapped BTC not found on chain", chainId);
        }
    }

    /// @dev Wrapped Ether
    function WETH(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.WETH();
        } else if (chainId == 8453) {
            return BaseMainnet.WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.WETH();
        } else if (chainId == 11155111) {
            return EthereumSepolia.WETH();
        } else if (chainId == 84532) {
            return BaseSepolia.WETH();
        } else {
            revert NotFound("Asset for Wrapped Ether not found on chain", chainId);
        }
    }

    /// @dev Uniswap
    function UNI(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.UNI();
        } else {
            revert NotFound("Asset for Uniswap not found on chain", chainId);
        }
    }

    /// @dev ChainLink Token
    function LINK(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.LINK();
        } else {
            revert NotFound("Asset for ChainLink Token not found on chain", chainId);
        }
    }

    /// @dev Wrapped liquid staked Ether 2.0
    function wstETH(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.wstETH();
        } else if (chainId == 8453) {
            return BaseMainnet.wstETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.wstETH();
        } else if (chainId == 11155111) {
            return EthereumSepolia.wstETH();
        } else {
            revert NotFound("Asset for Wrapped liquid staked Ether 2.0 not found on chain", chainId);
        }
    }

    /// @dev Coinbase Wrapped BTC
    function cbBTC(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.cbBTC();
        } else if (chainId == 8453) {
            return BaseMainnet.cbBTC();
        } else {
            revert NotFound("Asset for Coinbase Wrapped BTC not found on chain", chainId);
        }
    }

    /// @dev tBTC v2
    function tBTC(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.tBTC();
        } else {
            revert NotFound("Asset for tBTC v2 not found on chain", chainId);
        }
    }

    /// @dev Coinbase Wrapped Staked ETH
    function cbETH(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.cbETH();
        } else if (chainId == 8453) {
            return BaseMainnet.cbETH();
        } else if (chainId == 11155111) {
            return EthereumSepolia.cbETH();
        } else if (chainId == 84532) {
            return BaseSepolia.cbETH();
        } else {
            revert NotFound("Asset for Coinbase Wrapped Staked ETH not found on chain", chainId);
        }
    }

    /// @dev Rocket Pool ETH
    function rETH(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.rETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.rETH();
        } else {
            revert NotFound("Asset for Rocket Pool ETH not found on chain", chainId);
        }
    }

    /// @dev rsETH
    function rsETH(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.rsETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.rsETH();
        } else {
            revert NotFound("Asset for rsETH not found on chain", chainId);
        }
    }

    /// @dev Wrapped eETH
    function weETH(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.weETH();
        } else if (chainId == 8453) {
            return BaseMainnet.weETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.weETH();
        } else {
            revert NotFound("Asset for Wrapped eETH not found on chain", chainId);
        }
    }

    /// @dev Staked ETH
    function osETH(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.osETH();
        } else {
            revert NotFound("Asset for Staked ETH not found on chain", chainId);
        }
    }

    /// @dev Renzo Restaked ETH
    function ezETH(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.ezETH();
        } else if (chainId == 8453) {
            return BaseMainnet.ezETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.ezETH();
        } else {
            revert NotFound("Asset for Renzo Restaked ETH not found on chain", chainId);
        }
    }

    /// @dev rswETH
    function rswETH(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.rswETH();
        } else {
            revert NotFound("Asset for rswETH not found on chain", chainId);
        }
    }

    /// @dev ETHx
    function ETHx(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.ETHx();
        } else {
            revert NotFound("Asset for ETHx not found on chain", chainId);
        }
    }

    /// @dev Wrapped Mountain Protocol USD
    function wUSDM(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.wUSDM();
        } else {
            revert NotFound("Asset for Wrapped Mountain Protocol USD not found on chain", chainId);
        }
    }

    /// @dev Staked FRAX
    function sFRAX(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.sFRAX();
        } else {
            revert NotFound("Asset for Staked FRAX not found on chain", chainId);
        }
    }

    /// @dev Aerodrome
    function AERO(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.AERO();
        } else {
            revert NotFound("Asset for Aerodrome not found on chain", chainId);
        }
    }

    /// @dev Degen
    function DEGEN(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.DEGEN();
        } else {
            revert NotFound("Asset for Degen not found on chain", chainId);
        }
    }

    /// @dev Brett
    function BRETT(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.BRETT();
        } else {
            revert NotFound("Asset for Brett not found on chain", chainId);
        }
    }

    /// @dev higher
    function HIGHER(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.HIGHER();
        } else {
            revert NotFound("Asset for higher not found on chain", chainId);
        }
    }

    /// @dev luminous
    function LUM(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.LUM();
        } else {
            revert NotFound("Asset for luminous not found on chain", chainId);
        }
    }

    /// @dev WELL
    function WELL(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.WELL();
        } else {
            revert NotFound("Asset for WELL not found on chain", chainId);
        }
    }

    /// @dev Morpho Token
    function MORPHO(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.MORPHO();
        } else {
            revert NotFound("Asset for Morpho Token not found on chain", chainId);
        }
    }

    /// @dev rsETHWrapper
    function wrsETH(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.wrsETH();
        } else {
            revert NotFound("Asset for rsETHWrapper not found on chain", chainId);
        }
    }

    /// @dev GMX
    function GMX(uint256 chainId) internal pure returns (KnownAsset memory) {
        if (chainId == 42161) {
            return ArbitrumMainnet.GMX();
        } else {
            revert NotFound("Asset for GMX not found on chain", chainId);
        }
    }

    /// @dev ETH_USD price feed
    function ETH_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.ETH_USD();
        } else if (chainId == 8453) {
            return BaseMainnet.ETH_USD();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.ETH_USD();
        } else if (chainId == 11155111) {
            return EthereumSepolia.ETH_USD();
        } else if (chainId == 84532) {
            return BaseSepolia.ETH_USD();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.ETH_USD();
        } else {
            revert NotFound("PriceFeed for ETH_USD not found on chain", chainId);
        }
    }

    /// @dev USDC_USD price feed
    function USDC_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.USDC_USD();
        } else if (chainId == 8453) {
            return BaseMainnet.USDC_USD();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.USDC_USD();
        } else if (chainId == 11155111) {
            return EthereumSepolia.USDC_USD();
        } else if (chainId == 84532) {
            return BaseSepolia.USDC_USD();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.USDC_USD();
        } else {
            revert NotFound("PriceFeed for USDC_USD not found on chain", chainId);
        }
    }

    /// @dev sUSDe_USD price feed
    function sUSDe_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.sUSDe_USD();
        } else {
            revert NotFound("PriceFeed for sUSDe_USD not found on chain", chainId);
        }
    }

    /// @dev COMP_USD price feed
    function COMP_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.COMP_USD();
        } else if (chainId == 8453) {
            return BaseMainnet.COMP_USD();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.COMP_USD();
        } else if (chainId == 11155111) {
            return EthereumSepolia.COMP_USD();
        } else if (chainId == 84532) {
            return BaseSepolia.COMP_USD();
        } else {
            revert NotFound("PriceFeed for COMP_USD not found on chain", chainId);
        }
    }

    /// @dev WBTC_USD price feed
    function WBTC_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.WBTC_USD();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.WBTC_USD();
        } else if (chainId == 11155111) {
            return EthereumSepolia.WBTC_USD();
        } else {
            revert NotFound("PriceFeed for WBTC_USD not found on chain", chainId);
        }
    }

    /// @dev WETH_USD price feed
    function WETH_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.WETH_USD();
        } else if (chainId == 8453) {
            return BaseMainnet.WETH_USD();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.WETH_USD();
        } else if (chainId == 11155111) {
            return EthereumSepolia.WETH_USD();
        } else if (chainId == 84532) {
            return BaseSepolia.WETH_USD();
        } else {
            revert NotFound("PriceFeed for WETH_USD not found on chain", chainId);
        }
    }

    /// @dev UNI_USD price feed
    function UNI_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.UNI_USD();
        } else {
            revert NotFound("PriceFeed for UNI_USD not found on chain", chainId);
        }
    }

    /// @dev LINK_USD price feed
    function LINK_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.LINK_USD();
        } else {
            revert NotFound("PriceFeed for LINK_USD not found on chain", chainId);
        }
    }

    /// @dev wstETH_USD price feed
    function wstETH_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.wstETH_USD();
        } else if (chainId == 8453) {
            return BaseMainnet.wstETH_USD();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.wstETH_USD();
        } else {
            revert NotFound("PriceFeed for wstETH_USD not found on chain", chainId);
        }
    }

    /// @dev cbBTC_USD price feed
    function cbBTC_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.cbBTC_USD();
        } else if (chainId == 8453) {
            return BaseMainnet.cbBTC_USD();
        } else {
            revert NotFound("PriceFeed for cbBTC_USD not found on chain", chainId);
        }
    }

    /// @dev tBTC_USD price feed
    function tBTC_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.tBTC_USD();
        } else {
            revert NotFound("PriceFeed for tBTC_USD not found on chain", chainId);
        }
    }

    /// @dev cbETH_WETH price feed
    function cbETH_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.cbETH_WETH();
        } else if (chainId == 8453) {
            return BaseMainnet.cbETH_WETH();
        } else if (chainId == 11155111) {
            return EthereumSepolia.cbETH_WETH();
        } else if (chainId == 84532) {
            return BaseSepolia.cbETH_WETH();
        } else {
            revert NotFound("PriceFeed for cbETH_WETH not found on chain", chainId);
        }
    }

    /// @dev wstETH_WETH price feed
    function wstETH_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.wstETH_WETH();
        } else if (chainId == 8453) {
            return BaseMainnet.wstETH_WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.wstETH_WETH();
        } else if (chainId == 11155111) {
            return EthereumSepolia.wstETH_WETH();
        } else {
            revert NotFound("PriceFeed for wstETH_WETH not found on chain", chainId);
        }
    }

    /// @dev rETH_WETH price feed
    function rETH_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.rETH_WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.rETH_WETH();
        } else {
            revert NotFound("PriceFeed for rETH_WETH not found on chain", chainId);
        }
    }

    /// @dev rsETH_WETH price feed
    function rsETH_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.rsETH_WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.rsETH_WETH();
        } else {
            revert NotFound("PriceFeed for rsETH_WETH not found on chain", chainId);
        }
    }

    /// @dev weETH_WETH price feed
    function weETH_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.weETH_WETH();
        } else if (chainId == 8453) {
            return BaseMainnet.weETH_WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.weETH_WETH();
        } else {
            revert NotFound("PriceFeed for weETH_WETH not found on chain", chainId);
        }
    }

    /// @dev osETH_WETH price feed
    function osETH_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.osETH_WETH();
        } else {
            revert NotFound("PriceFeed for osETH_WETH not found on chain", chainId);
        }
    }

    /// @dev WBTC_WETH price feed
    function WBTC_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.WBTC_WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.WBTC_WETH();
        } else {
            revert NotFound("PriceFeed for WBTC_WETH not found on chain", chainId);
        }
    }

    /// @dev ezETH_WETH price feed
    function ezETH_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.ezETH_WETH();
        } else if (chainId == 8453) {
            return BaseMainnet.ezETH_WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.ezETH_WETH();
        } else {
            revert NotFound("PriceFeed for ezETH_WETH not found on chain", chainId);
        }
    }

    /// @dev cbBTC_WETH price feed
    function cbBTC_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.cbBTC_WETH();
        } else if (chainId == 8453) {
            return BaseMainnet.cbBTC_WETH();
        } else {
            revert NotFound("PriceFeed for cbBTC_WETH not found on chain", chainId);
        }
    }

    /// @dev rswETH_WETH price feed
    function rswETH_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.rswETH_WETH();
        } else {
            revert NotFound("PriceFeed for rswETH_WETH not found on chain", chainId);
        }
    }

    /// @dev tBTC_WETH price feed
    function tBTC_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.tBTC_WETH();
        } else {
            revert NotFound("PriceFeed for tBTC_WETH not found on chain", chainId);
        }
    }

    /// @dev ETHx_WETH price feed
    function ETHx_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.ETHx_WETH();
        } else {
            revert NotFound("PriceFeed for ETHx_WETH not found on chain", chainId);
        }
    }

    /// @dev USDT_USD price feed
    function USDT_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.USDT_USD();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.USDT_USD();
        } else {
            revert NotFound("PriceFeed for USDT_USD not found on chain", chainId);
        }
    }

    /// @dev COMP_USDT price feed
    function COMP_USDT(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.COMP_USDT();
        } else {
            revert NotFound("PriceFeed for COMP_USDT not found on chain", chainId);
        }
    }

    /// @dev WETH_USDT price feed
    function WETH_USDT(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.WETH_USDT();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.WETH_USDT();
        } else {
            revert NotFound("PriceFeed for WETH_USDT not found on chain", chainId);
        }
    }

    /// @dev WBTC_USDT price feed
    function WBTC_USDT(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.WBTC_USDT();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.WBTC_USDT();
        } else {
            revert NotFound("PriceFeed for WBTC_USDT not found on chain", chainId);
        }
    }

    /// @dev UNI_USDT price feed
    function UNI_USDT(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.UNI_USDT();
        } else {
            revert NotFound("PriceFeed for UNI_USDT not found on chain", chainId);
        }
    }

    /// @dev LINK_USDT price feed
    function LINK_USDT(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.LINK_USDT();
        } else {
            revert NotFound("PriceFeed for LINK_USDT not found on chain", chainId);
        }
    }

    /// @dev wstETH_USDT price feed
    function wstETH_USDT(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.wstETH_USDT();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.wstETH_USDT();
        } else {
            revert NotFound("PriceFeed for wstETH_USDT not found on chain", chainId);
        }
    }

    /// @dev cbBTC_USDT price feed
    function cbBTC_USDT(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.cbBTC_USDT();
        } else {
            revert NotFound("PriceFeed for cbBTC_USDT not found on chain", chainId);
        }
    }

    /// @dev tBTC_USDT price feed
    function tBTC_USDT(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.tBTC_USDT();
        } else {
            revert NotFound("PriceFeed for tBTC_USDT not found on chain", chainId);
        }
    }

    /// @dev wUSDM_USDT price feed
    function wUSDM_USDT(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.wUSDM_USDT();
        } else {
            revert NotFound("PriceFeed for wUSDM_USDT not found on chain", chainId);
        }
    }

    /// @dev sFRAX_USDT price feed
    function sFRAX_USDT(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.sFRAX_USDT();
        } else {
            revert NotFound("PriceFeed for sFRAX_USDT not found on chain", chainId);
        }
    }

    /// @dev wstETH_ETH price feed
    function wstETH_ETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 8453) {
            return BaseMainnet.wstETH_ETH();
        } else {
            revert NotFound("PriceFeed for wstETH_ETH not found on chain", chainId);
        }
    }

    /// @dev cbETH_USD price feed
    function cbETH_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 8453) {
            return BaseMainnet.cbETH_USD();
        } else if (chainId == 84532) {
            return BaseSepolia.cbETH_USD();
        } else {
            revert NotFound("PriceFeed for cbETH_USD not found on chain", chainId);
        }
    }

    /// @dev USDC_WETH price feed
    function USDC_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 8453) {
            return BaseMainnet.USDC_WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.USDC_WETH();
        } else {
            revert NotFound("PriceFeed for USDC_WETH not found on chain", chainId);
        }
    }

    /// @dev wrsETH_WETH price feed
    function wrsETH_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 8453) {
            return BaseMainnet.wrsETH_WETH();
        } else {
            revert NotFound("PriceFeed for wrsETH_WETH not found on chain", chainId);
        }
    }

    /// @dev ARB_USD price feed
    function ARB_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 42161) {
            return ArbitrumMainnet.ARB_USD();
        } else {
            revert NotFound("PriceFeed for ARB_USD not found on chain", chainId);
        }
    }

    /// @dev GMX_USD price feed
    function GMX_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 42161) {
            return ArbitrumMainnet.GMX_USD();
        } else {
            revert NotFound("PriceFeed for GMX_USD not found on chain", chainId);
        }
    }

    /// @dev ezETH_USD price feed
    function ezETH_USD(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 42161) {
            return ArbitrumMainnet.ezETH_USD();
        } else {
            revert NotFound("PriceFeed for ezETH_USD not found on chain", chainId);
        }
    }

    /// @dev ARB_USDT price feed
    function ARB_USDT(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 42161) {
            return ArbitrumMainnet.ARB_USDT();
        } else {
            revert NotFound("PriceFeed for ARB_USDT not found on chain", chainId);
        }
    }

    /// @dev GMX_USDT price feed
    function GMX_USDT(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 42161) {
            return ArbitrumMainnet.GMX_USDT();
        } else {
            revert NotFound("PriceFeed for GMX_USDT not found on chain", chainId);
        }
    }

    /// @dev USDT_WETH price feed
    function USDT_WETH(uint256 chainId) internal pure returns (KnownPriceFeed memory) {
        if (chainId == 42161) {
            return ArbitrumMainnet.USDT_WETH();
        } else {
            revert NotFound("PriceFeed for USDT_WETH not found on chain", chainId);
        }
    }

    /// @dev Compound USDC
    function Comet_cUSDCv3(uint256 chainId) internal pure returns (KnownComet memory) {
        if (chainId == 1) {
            return EthereumMainnet.Comet_cUSDCv3();
        } else if (chainId == 8453) {
            return BaseMainnet.Comet_cUSDCv3();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.Comet_cUSDCv3();
        } else if (chainId == 11155111) {
            return EthereumSepolia.Comet_cUSDCv3();
        } else if (chainId == 84532) {
            return BaseSepolia.Comet_cUSDCv3();
        } else {
            revert NotFound("Comet for cUSDCv3 not found on chain", chainId);
        }
    }

    /// @dev Compound WETH
    function Comet_cWETHv3(uint256 chainId) internal pure returns (KnownComet memory) {
        if (chainId == 1) {
            return EthereumMainnet.Comet_cWETHv3();
        } else if (chainId == 8453) {
            return BaseMainnet.Comet_cWETHv3();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.Comet_cWETHv3();
        } else if (chainId == 11155111) {
            return EthereumSepolia.Comet_cWETHv3();
        } else if (chainId == 84532) {
            return BaseSepolia.Comet_cWETHv3();
        } else {
            revert NotFound("Comet for cWETHv3 not found on chain", chainId);
        }
    }

    /// @dev Compound USDT
    function Comet_cUSDTv3(uint256 chainId) internal pure returns (KnownComet memory) {
        if (chainId == 1) {
            return EthereumMainnet.Comet_cUSDTv3();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.Comet_cUSDTv3();
        } else {
            revert NotFound("Comet for cUSDTv3 not found on chain", chainId);
        }
    }

    /// @dev All known assets, by chain id
    function knownAssets(uint256 chainId) internal pure returns (KnownAsset[] memory) {
        if (chainId == 1) {
            return EthereumMainnet.knownAssets();
        } else if (chainId == 8453) {
            return BaseMainnet.knownAssets();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.knownAssets();
        } else if (chainId == 11155111) {
            return EthereumSepolia.knownAssets();
        } else if (chainId == 84532) {
            return BaseSepolia.knownAssets();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.knownAssets();
        } else {
            revert NotFound("Network not found for chain id", chainId);
        }
    }

    /// @dev All known price feeds, by chain id
    function knownPriceFeeds(uint256 chainId) internal pure returns (KnownPriceFeed[] memory) {
        if (chainId == 1) {
            return EthereumMainnet.knownPriceFeeds();
        } else if (chainId == 8453) {
            return BaseMainnet.knownPriceFeeds();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.knownPriceFeeds();
        } else if (chainId == 11155111) {
            return EthereumSepolia.knownPriceFeeds();
        } else if (chainId == 84532) {
            return BaseSepolia.knownPriceFeeds();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.knownPriceFeeds();
        } else {
            revert NotFound("Network not found for chain id", chainId);
        }
    }

    /// @dev All known comets, by chain id
    function knownComets(uint256 chainId) internal pure returns (KnownComet[] memory) {
        if (chainId == 1) {
            return EthereumMainnet.knownComets();
        } else if (chainId == 8453) {
            return BaseMainnet.knownComets();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.knownComets();
        } else if (chainId == 11155111) {
            return EthereumSepolia.knownComets();
        } else if (chainId == 84532) {
            return BaseSepolia.knownComets();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.knownComets();
        } else {
            revert NotFound("Network not found for chain id", chainId);
        }
    }

    /// @dev Big burrito, by chain id
    function knownNetwork(uint256 chainId) internal pure returns (KnownNetwork memory) {
        if (chainId == 1) {
            return EthereumMainnet.knownNetwork();
        } else if (chainId == 8453) {
            return BaseMainnet.knownNetwork();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.knownNetwork();
        } else if (chainId == 11155111) {
            return EthereumSepolia.knownNetwork();
        } else if (chainId == 84532) {
            return BaseSepolia.knownNetwork();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.knownNetwork();
        } else {
            revert NotFound("Network not found for chain id", chainId);
        }
    }
}

library EthereumMainnet {
    /// @dev KnownAsset constructors

    /// @dev EthereumMainnet Ether
    function ETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Ether",
            symbol: "ETH",
            decimals: 18,
            assetAddress: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        });
    }

    /// @dev EthereumMainnet USD Coin
    function USDC() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "USD Coin",
            symbol: "USDC",
            decimals: 6,
            assetAddress: 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
        });
    }

    /// @dev EthereumMainnet Dai Stablecoin
    function DAI() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Dai Stablecoin",
            symbol: "DAI",
            decimals: 18,
            assetAddress: 0x6B175474E89094C44Da98b954EedeAC495271d0F
        });
    }

    /// @dev EthereumMainnet Tether USD
    function USDT() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Tether USD",
            symbol: "USDT",
            decimals: 6,
            assetAddress: 0xdAC17F958D2ee523a2206206994597C13D831ec7
        });
    }

    /// @dev EthereumMainnet Frax
    function FRAX() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Frax",
            symbol: "FRAX",
            decimals: 18,
            assetAddress: 0x853d955aCEf822Db058eb8505911ED77F175b99e
        });
    }

    /// @dev EthereumMainnet USDe
    function USDe() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "USDe",
            symbol: "USDe",
            decimals: 18,
            assetAddress: 0x4c9EDD5852cd905f086C759E8383e09bff1E68B3
        });
    }

    /// @dev EthereumMainnet Arbitrum
    function ARB() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Arbitrum",
            symbol: "ARB",
            decimals: 18,
            assetAddress: 0xB50721BCf8d664c30412Cfbc6cf7a15145234ad1
        });
    }

    /// @dev EthereumMainnet Blur
    function BLUR() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Blur",
            symbol: "BLUR",
            decimals: 18,
            assetAddress: 0x5283D291DBCF85356A21bA090E6db59121208b44
        });
    }

    /// @dev EthereumMainnet Curve DAO Token
    function CRV() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Curve DAO Token",
            symbol: "CRV",
            decimals: 18,
            assetAddress: 0xD533a949740bb3306d119CC777fa900bA034cd52
        });
    }

    /// @dev EthereumMainnet ENA
    function ENA() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "ENA",
            symbol: "ENA",
            decimals: 18,
            assetAddress: 0x57e114B691Db790C35207b2e685D4A43181e6061
        });
    }

    /// @dev EthereumMainnet Lido DAO Token
    function LDO() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Lido DAO Token",
            symbol: "LDO",
            decimals: 18,
            assetAddress: 0x5A98FcBEA516Cf06857215779Fd812CA3beF1B32
        });
    }

    /// @dev EthereumMainnet Pendle
    function PENDLE() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Pendle",
            symbol: "PENDLE",
            decimals: 18,
            assetAddress: 0x808507121B80c02388fAd14726482e061B8da827
        });
    }

    /// @dev EthereumMainnet Pepe
    function PEPE() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Pepe",
            symbol: "PEPE",
            decimals: 18,
            assetAddress: 0x6982508145454Ce325dDbE47a25d4ec3d2311933
        });
    }

    /// @dev EthereumMainnet Rocket Pool Protocol
    function RPL() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Rocket Pool Protocol",
            symbol: "RPL",
            decimals: 18,
            assetAddress: 0xD33526068D116cE69F19A9ee46F0bd304F21A51f
        });
    }

    /// @dev EthereumMainnet SHIBA INU
    function SHIB() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "SHIBA INU",
            symbol: "SHIB",
            decimals: 18,
            assetAddress: 0x95aD61b0a150d79219dCF64E1E6Cc01f0B64C4cE
        });
    }

    /// @dev EthereumMainnet Compound
    function COMP() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Compound",
            symbol: "COMP",
            decimals: 18,
            assetAddress: 0xc00e94Cb662C3520282E6f5717214004A7f26888
        });
    }

    /// @dev EthereumMainnet Wrapped BTC
    function WBTC() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped BTC",
            symbol: "WBTC",
            decimals: 8,
            assetAddress: 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599
        });
    }

    /// @dev EthereumMainnet Wrapped Ether
    function WETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped Ether",
            symbol: "WETH",
            decimals: 18,
            assetAddress: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2
        });
    }

    /// @dev EthereumMainnet Uniswap
    function UNI() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Uniswap",
            symbol: "UNI",
            decimals: 18,
            assetAddress: 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
        });
    }

    /// @dev EthereumMainnet ChainLink Token
    function LINK() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "ChainLink Token",
            symbol: "LINK",
            decimals: 18,
            assetAddress: 0x514910771AF9Ca656af840dff83E8264EcF986CA
        });
    }

    /// @dev EthereumMainnet Wrapped liquid staked Ether 2.0
    function wstETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped liquid staked Ether 2.0",
            symbol: "wstETH",
            decimals: 18,
            assetAddress: 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0
        });
    }

    /// @dev EthereumMainnet Coinbase Wrapped BTC
    function cbBTC() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Coinbase Wrapped BTC",
            symbol: "cbBTC",
            decimals: 8,
            assetAddress: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf
        });
    }

    /// @dev EthereumMainnet tBTC v2
    function tBTC() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "tBTC v2",
            symbol: "tBTC",
            decimals: 18,
            assetAddress: 0x18084fbA666a33d37592fA2633fD49a74DD93a88
        });
    }

    /// @dev EthereumMainnet Coinbase Wrapped Staked ETH
    function cbETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Coinbase Wrapped Staked ETH",
            symbol: "cbETH",
            decimals: 18,
            assetAddress: 0xBe9895146f7AF43049ca1c1AE358B0541Ea49704
        });
    }

    /// @dev EthereumMainnet Rocket Pool ETH
    function rETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Rocket Pool ETH",
            symbol: "rETH",
            decimals: 18,
            assetAddress: 0xae78736Cd615f374D3085123A210448E74Fc6393
        });
    }

    /// @dev EthereumMainnet rsETH
    function rsETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "rsETH",
            symbol: "rsETH",
            decimals: 18,
            assetAddress: 0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7
        });
    }

    /// @dev EthereumMainnet Wrapped eETH
    function weETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped eETH",
            symbol: "weETH",
            decimals: 18,
            assetAddress: 0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee
        });
    }

    /// @dev EthereumMainnet Staked ETH
    function osETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Staked ETH",
            symbol: "osETH",
            decimals: 18,
            assetAddress: 0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38
        });
    }

    /// @dev EthereumMainnet Renzo Restaked ETH
    function ezETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Renzo Restaked ETH",
            symbol: "ezETH",
            decimals: 18,
            assetAddress: 0xbf5495Efe5DB9ce00f80364C8B423567e58d2110
        });
    }

    /// @dev EthereumMainnet rswETH
    function rswETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "rswETH",
            symbol: "rswETH",
            decimals: 18,
            assetAddress: 0xFAe103DC9cf190eD75350761e95403b7b8aFa6c0
        });
    }

    /// @dev EthereumMainnet ETHx
    function ETHx() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "ETHx",
            symbol: "ETHx",
            decimals: 18,
            assetAddress: 0xA35b1B31Ce002FBF2058D22F30f95D405200A15b
        });
    }

    /// @dev EthereumMainnet Wrapped Mountain Protocol USD
    function wUSDM() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped Mountain Protocol USD",
            symbol: "wUSDM",
            decimals: 18,
            assetAddress: 0x57F5E098CaD7A3D1Eed53991D4d66C45C9AF7812
        });
    }

    /// @dev EthereumMainnet Staked FRAX
    function sFRAX() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Staked FRAX",
            symbol: "sFRAX",
            decimals: 18,
            assetAddress: 0xA663B02CF0a4b149d2aD41910CB81e23e1c41c32
        });
    }

    /// @dev KnownPriceFeed constructors

    /// @dev EthereumMainnet ETH_USD price feed
    function ETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
    }

    /// @dev EthereumMainnet USDC_USD price feed
    function USDC_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6
        });
    }

    /// @dev EthereumMainnet sUSDe_USD price feed
    function sUSDe_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "sUSDe",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xFF3BC18cCBd5999CE63E788A1c250a88626aD099
        });
    }

    /// @dev EthereumMainnet COMP_USD price feed
    function COMP_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "COMP",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5
        });
    }

    /// @dev EthereumMainnet WBTC_USD price feed
    function WBTC_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WBTC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c
        });
    }

    /// @dev EthereumMainnet WETH_USD price feed
    function WETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
    }

    /// @dev EthereumMainnet UNI_USD price feed
    function UNI_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "UNI",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x553303d460EE0afB37EdFf9bE42922D8FF63220e
        });
    }

    /// @dev EthereumMainnet LINK_USD price feed
    function LINK_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "LINK",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c
        });
    }

    /// @dev EthereumMainnet wstETH_USD price feed
    function wstETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x023ee795361B28cDbB94e302983578486A0A5f1B
        });
    }

    /// @dev EthereumMainnet cbBTC_USD price feed
    function cbBTC_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbBTC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x0A4F4F9E84Fc4F674F0D209f94d41FaFE5aF887D
        });
    }

    /// @dev EthereumMainnet tBTC_USD price feed
    function tBTC_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "tBTC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xAA9527bf3183A96fe6e55831c96dE5cd988d3484
        });
    }

    /// @dev EthereumMainnet cbETH_WETH price feed
    function cbETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x23a982b74a3236A5F2297856d4391B2edBBB5549
        });
    }

    /// @dev EthereumMainnet wstETH_WETH price feed
    function wstETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x4F67e4d9BD67eFa28236013288737D39AeF48e79
        });
    }

    /// @dev EthereumMainnet rETH_WETH price feed
    function rETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "rETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xA3A7fB5963D1d69B95EEC4957f77678EF073Ba08
        });
    }

    /// @dev EthereumMainnet rsETH_WETH price feed
    function rsETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "rsETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xFa454dE61b317b6535A0C462267208E8FdB89f45
        });
    }

    /// @dev EthereumMainnet weETH_WETH price feed
    function weETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "weETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x1Ad4CEBa9f8135A557bBe317DB62Aa125C330F26
        });
    }

    /// @dev EthereumMainnet osETH_WETH price feed
    function osETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "osETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x66F5AfDaD14b30816b47b707240D1E8E3344D04d
        });
    }

    /// @dev EthereumMainnet WBTC_WETH price feed
    function WBTC_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WBTC",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xd98Be00b5D27fc98112BdE293e487f8D4cA57d07
        });
    }

    /// @dev EthereumMainnet ezETH_WETH price feed
    function ezETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ezETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xdE43600De5016B50752cc2615332d8cCBED6EC1b
        });
    }

    /// @dev EthereumMainnet cbBTC_WETH price feed
    function cbBTC_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbBTC",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x57A71A9C632b2e6D8b0eB9A157888A3Fc87400D1
        });
    }

    /// @dev EthereumMainnet rswETH_WETH price feed
    function rswETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "rswETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xDd18688Bb75Af704f3Fb1183e459C4d4D41132D9
        });
    }

    /// @dev EthereumMainnet tBTC_WETH price feed
    function tBTC_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "tBTC",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x1933F7e5f8B0423fbAb28cE9c8C39C2cC414027B
        });
    }

    /// @dev EthereumMainnet ETHx_WETH price feed
    function ETHx_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ETHx",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x9F2F60f38BBc275aF8F88a21c0e2BfE751E97C1f
        });
    }

    /// @dev EthereumMainnet USDT_USD price feed
    function USDT_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDT",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D
        });
    }

    /// @dev EthereumMainnet COMP_USDT price feed
    function COMP_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "COMP",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5
        });
    }

    /// @dev EthereumMainnet WETH_USDT price feed
    function WETH_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WETH",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
    }

    /// @dev EthereumMainnet WBTC_USDT price feed
    function WBTC_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WBTC",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x4E64E54c9f0313852a230782B3ba4B3B0952B499
        });
    }

    /// @dev EthereumMainnet UNI_USDT price feed
    function UNI_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "UNI",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x553303d460EE0afB37EdFf9bE42922D8FF63220e
        });
    }

    /// @dev EthereumMainnet LINK_USDT price feed
    function LINK_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "LINK",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c
        });
    }

    /// @dev EthereumMainnet wstETH_USDT price feed
    function wstETH_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x023ee795361B28cDbB94e302983578486A0A5f1B
        });
    }

    /// @dev EthereumMainnet cbBTC_USDT price feed
    function cbBTC_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbBTC",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x2D09142Eae60Fd8BD454a276E95AeBdFFD05722d
        });
    }

    /// @dev EthereumMainnet tBTC_USDT price feed
    function tBTC_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "tBTC",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x7b03a016dBC36dB8e05C480192faDcdB0a06bC37
        });
    }

    /// @dev EthereumMainnet wUSDM_USDT price feed
    function wUSDM_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wUSDM",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0xe3a409eD15CD53aFdEFdd191ad945cEC528A2496
        });
    }

    /// @dev EthereumMainnet sFRAX_USDT price feed
    function sFRAX_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "sFRAX",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x403F2083B6E220147f8a8832f0B284B4Ed5777d1
        });
    }

    /// @dev KnownComet constructors

    /// @dev EthereumMainnet Compound USDC
    function Comet_cUSDCv3() internal pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](8);

        collaterals[0] = KnownCometCollateral({
            asset: 0xc00e94Cb662C3520282E6f5717214004A7f26888,
            supplyCap: 100000000000000000000000,
            priceFeed: 0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5,
            liquidationFactor: 7.5e17,
            borrowCollateralFactor: 5e17,
            liquidateCollateralFactor: 7e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599,
            supplyCap: 1000000000000,
            priceFeed: 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,
            supplyCap: 500000000000000000000000,
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.25e17,
            liquidateCollateralFactor: 8.95e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984,
            supplyCap: 2600000000000000000000000,
            priceFeed: 0x553303d460EE0afB37EdFf9bE42922D8FF63220e,
            liquidationFactor: 8.3e17,
            borrowCollateralFactor: 6.8e17,
            liquidateCollateralFactor: 7.4e17
        });

        collaterals[4] = KnownCometCollateral({
            asset: 0x514910771AF9Ca656af840dff83E8264EcF986CA,
            supplyCap: 1000000000000000000000000,
            priceFeed: 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c,
            liquidationFactor: 8.3e17,
            borrowCollateralFactor: 7.3e17,
            liquidateCollateralFactor: 7.9e17
        });

        collaterals[5] = KnownCometCollateral({
            asset: 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0,
            supplyCap: 40000000000000000000000,
            priceFeed: 0x023ee795361B28cDbB94e302983578486A0A5f1B,
            liquidationFactor: 9.2e17,
            borrowCollateralFactor: 8.2e17,
            liquidateCollateralFactor: 8.7e17
        });

        collaterals[6] = KnownCometCollateral({
            asset: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf,
            supplyCap: 9300000000,
            priceFeed: 0x0A4F4F9E84Fc4F674F0D209f94d41FaFE5aF887D,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[7] = KnownCometCollateral({
            asset: 0x18084fbA666a33d37592fA2633fD49a74DD93a88,
            supplyCap: 285000000000000000000,
            priceFeed: 0xAA9527bf3183A96fe6e55831c96dE5cd988d3484,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 7.6e17,
            liquidateCollateralFactor: 8.1e17
        });

        return KnownComet({
            name: "Compound USDC",
            symbol: "cUSDCv3",
            cometAddress: 0xc3d688B66703497DAA19211EEdff47f25384cdc3,
            rewardsAddress: 0x1B0e765F6224C21223AeA2af16c1C46E38885a40,
            factorScale: 1e18,
            baseAsset: 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48,
            collateralAssets: collaterals
        });
    }

    /// @dev EthereumMainnet Compound WETH
    function Comet_cWETHv3() internal pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](12);

        collaterals[0] = KnownCometCollateral({
            asset: 0xBe9895146f7AF43049ca1c1AE358B0541Ea49704,
            supplyCap: 10000000000000000000000,
            priceFeed: 0x23a982b74a3236A5F2297856d4391B2edBBB5549,
            liquidationFactor: 9.75e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0,
            supplyCap: 64500000000000000000000,
            priceFeed: 0x4F67e4d9BD67eFa28236013288737D39AeF48e79,
            liquidationFactor: 9.75e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0xae78736Cd615f374D3085123A210448E74Fc6393,
            supplyCap: 30000000000000000000000,
            priceFeed: 0xA3A7fB5963D1d69B95EEC4957f77678EF073Ba08,
            liquidationFactor: 9.75e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7,
            supplyCap: 37000000000000000000000,
            priceFeed: 0xFa454dE61b317b6535A0C462267208E8FdB89f45,
            liquidationFactor: 9.6e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9.1e17
        });

        collaterals[4] = KnownCometCollateral({
            asset: 0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee,
            supplyCap: 22500000000000000000000,
            priceFeed: 0x1Ad4CEBa9f8135A557bBe317DB62Aa125C330F26,
            liquidationFactor: 9.6e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[5] = KnownCometCollateral({
            asset: 0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38,
            supplyCap: 10000000000000000000000,
            priceFeed: 0x66F5AfDaD14b30816b47b707240D1E8E3344D04d,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[6] = KnownCometCollateral({
            asset: 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599,
            supplyCap: 100000000000,
            priceFeed: 0xd98Be00b5D27fc98112BdE293e487f8D4cA57d07,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[7] = KnownCometCollateral({
            asset: 0xbf5495Efe5DB9ce00f80364C8B423567e58d2110,
            supplyCap: 80000000000000000000000,
            priceFeed: 0xdE43600De5016B50752cc2615332d8cCBED6EC1b,
            liquidationFactor: 9.4e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9.1e17
        });

        collaterals[8] = KnownCometCollateral({
            asset: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf,
            supplyCap: 9300000000,
            priceFeed: 0x57A71A9C632b2e6D8b0eB9A157888A3Fc87400D1,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[9] = KnownCometCollateral({
            asset: 0xFAe103DC9cf190eD75350761e95403b7b8aFa6c0,
            supplyCap: 1000000000000000000000,
            priceFeed: 0xDd18688Bb75Af704f3Fb1183e459C4d4D41132D9,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[10] = KnownCometCollateral({
            asset: 0x18084fbA666a33d37592fA2633fD49a74DD93a88,
            supplyCap: 315000000000000000000,
            priceFeed: 0x1933F7e5f8B0423fbAb28cE9c8C39C2cC414027B,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 7.6e17,
            liquidateCollateralFactor: 8.1e17
        });

        collaterals[11] = KnownCometCollateral({
            asset: 0xA35b1B31Ce002FBF2058D22F30f95D405200A15b,
            supplyCap: 2100000000000000000000,
            priceFeed: 0x9F2F60f38BBc275aF8F88a21c0e2BfE751E97C1f,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.5e17,
            liquidateCollateralFactor: 9e17
        });

        return KnownComet({
            name: "Compound WETH",
            symbol: "cWETHv3",
            cometAddress: 0xA17581A9E3356d9A858b789D68B4d866e593aE94,
            rewardsAddress: 0x1B0e765F6224C21223AeA2af16c1C46E38885a40,
            factorScale: 1e18,
            baseAsset: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,
            collateralAssets: collaterals
        });
    }

    /// @dev EthereumMainnet Compound USDT
    function Comet_cUSDTv3() internal pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](10);

        collaterals[0] = KnownCometCollateral({
            asset: 0xc00e94Cb662C3520282E6f5717214004A7f26888,
            supplyCap: 100000000000000000000000,
            priceFeed: 0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5,
            liquidationFactor: 7.5e17,
            borrowCollateralFactor: 5e17,
            liquidateCollateralFactor: 7e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,
            supplyCap: 500000000000000000000000,
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.3e17,
            liquidateCollateralFactor: 9e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599,
            supplyCap: 140000000000,
            priceFeed: 0x4E64E54c9f0313852a230782B3ba4B3B0952B499,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984,
            supplyCap: 1300000000000000000000000,
            priceFeed: 0x553303d460EE0afB37EdFf9bE42922D8FF63220e,
            liquidationFactor: 8.3e17,
            borrowCollateralFactor: 6.8e17,
            liquidateCollateralFactor: 7.4e17
        });

        collaterals[4] = KnownCometCollateral({
            asset: 0x514910771AF9Ca656af840dff83E8264EcF986CA,
            supplyCap: 500000000000000000000000,
            priceFeed: 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c,
            liquidationFactor: 8.3e17,
            borrowCollateralFactor: 7.3e17,
            liquidateCollateralFactor: 7.9e17
        });

        collaterals[5] = KnownCometCollateral({
            asset: 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0,
            supplyCap: 45000000000000000000000,
            priceFeed: 0x023ee795361B28cDbB94e302983578486A0A5f1B,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[6] = KnownCometCollateral({
            asset: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf,
            supplyCap: 9300000000,
            priceFeed: 0x2D09142Eae60Fd8BD454a276E95AeBdFFD05722d,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[7] = KnownCometCollateral({
            asset: 0x18084fbA666a33d37592fA2633fD49a74DD93a88,
            supplyCap: 285000000000000000000,
            priceFeed: 0x7b03a016dBC36dB8e05C480192faDcdB0a06bC37,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 7.6e17,
            liquidateCollateralFactor: 8.1e17
        });

        collaterals[8] = KnownCometCollateral({
            asset: 0x57F5E098CaD7A3D1Eed53991D4d66C45C9AF7812,
            supplyCap: 6500000000000000000000000,
            priceFeed: 0xe3a409eD15CD53aFdEFdd191ad945cEC528A2496,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9e17
        });

        collaterals[9] = KnownCometCollateral({
            asset: 0xA663B02CF0a4b149d2aD41910CB81e23e1c41c32,
            supplyCap: 10000000000000000000000000,
            priceFeed: 0x403F2083B6E220147f8a8832f0B284B4Ed5777d1,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9e17
        });

        return KnownComet({
            name: "Compound USDT",
            symbol: "cUSDTv3",
            cometAddress: 0x3Afdc9BCA9213A35503b077a6072F3D0d5AB0840,
            rewardsAddress: 0x1B0e765F6224C21223AeA2af16c1C46E38885a40,
            factorScale: 1e18,
            baseAsset: 0xdAC17F958D2ee523a2206206994597C13D831ec7,
            collateralAssets: collaterals
        });
    }

    /// @dev All EthereumMainnet known assets
    function knownAssets() internal pure returns (KnownAsset[] memory) {
        KnownAsset[] memory assets = new KnownAsset[](33);
        assets[0] = ETH();
        assets[1] = USDC();
        assets[2] = DAI();
        assets[3] = USDT();
        assets[4] = FRAX();
        assets[5] = USDe();
        assets[6] = ARB();
        assets[7] = BLUR();
        assets[8] = CRV();
        assets[9] = ENA();
        assets[10] = LDO();
        assets[11] = PENDLE();
        assets[12] = PEPE();
        assets[13] = RPL();
        assets[14] = SHIB();
        assets[15] = COMP();
        assets[16] = WBTC();
        assets[17] = WETH();
        assets[18] = UNI();
        assets[19] = LINK();
        assets[20] = wstETH();
        assets[21] = cbBTC();
        assets[22] = tBTC();
        assets[23] = cbETH();
        assets[24] = rETH();
        assets[25] = rsETH();
        assets[26] = weETH();
        assets[27] = osETH();
        assets[28] = ezETH();
        assets[29] = rswETH();
        assets[30] = ETHx();
        assets[31] = wUSDM();
        assets[32] = sFRAX();
        return assets;
    }

    /// @dev All EthereumMainnet known price feeds
    function knownPriceFeeds() internal pure returns (KnownPriceFeed[] memory) {
        KnownPriceFeed[] memory priceFeeds = new KnownPriceFeed[](34);
        priceFeeds[0] = ETH_USD();
        priceFeeds[1] = USDC_USD();
        priceFeeds[2] = sUSDe_USD();
        priceFeeds[3] = COMP_USD();
        priceFeeds[4] = WBTC_USD();
        priceFeeds[5] = WETH_USD();
        priceFeeds[6] = UNI_USD();
        priceFeeds[7] = LINK_USD();
        priceFeeds[8] = wstETH_USD();
        priceFeeds[9] = cbBTC_USD();
        priceFeeds[10] = tBTC_USD();
        priceFeeds[11] = cbETH_WETH();
        priceFeeds[12] = wstETH_WETH();
        priceFeeds[13] = rETH_WETH();
        priceFeeds[14] = rsETH_WETH();
        priceFeeds[15] = weETH_WETH();
        priceFeeds[16] = osETH_WETH();
        priceFeeds[17] = WBTC_WETH();
        priceFeeds[18] = ezETH_WETH();
        priceFeeds[19] = cbBTC_WETH();
        priceFeeds[20] = rswETH_WETH();
        priceFeeds[21] = tBTC_WETH();
        priceFeeds[22] = ETHx_WETH();
        priceFeeds[23] = USDT_USD();
        priceFeeds[24] = COMP_USDT();
        priceFeeds[25] = WETH_USDT();
        priceFeeds[26] = WBTC_USDT();
        priceFeeds[27] = UNI_USDT();
        priceFeeds[28] = LINK_USDT();
        priceFeeds[29] = wstETH_USDT();
        priceFeeds[30] = cbBTC_USDT();
        priceFeeds[31] = tBTC_USDT();
        priceFeeds[32] = wUSDM_USDT();
        priceFeeds[33] = sFRAX_USDT();
        return priceFeeds;
    }

    /// @dev All EthereumMainnet known comets
    function knownComets() internal pure returns (KnownComet[] memory) {
        KnownComet[] memory comets = new KnownComet[](3);
        comets[0] = Comet_cUSDCv3();
        comets[1] = Comet_cWETHv3();
        comets[2] = Comet_cUSDTv3();
        return comets;
    }

    /// @dev The big EthereumMainnet burrito
    function knownNetwork() internal pure returns (KnownNetwork memory) {
        return KnownNetwork({
            chainId: 1,
            isTestnet: false,
            assets: knownAssets(),
            comets: knownComets(),
            priceFeeds: knownPriceFeeds()
        });
    }
}

library BaseMainnet {
    /// @dev KnownAsset constructors

    /// @dev BaseMainnet Ether
    function ETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Ether",
            symbol: "ETH",
            decimals: 18,
            assetAddress: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        });
    }

    /// @dev BaseMainnet USD Coin
    function USDC() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "USD Coin",
            symbol: "USDC",
            decimals: 6,
            assetAddress: 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
        });
    }

    /// @dev BaseMainnet Aerodrome
    function AERO() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Aerodrome",
            symbol: "AERO",
            decimals: 18,
            assetAddress: 0x940181a94A35A4569E4529A3CDfB74e38FD98631
        });
    }

    /// @dev BaseMainnet Degen
    function DEGEN() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Degen",
            symbol: "DEGEN",
            decimals: 18,
            assetAddress: 0x4ed4E862860beD51a9570b96d89aF5E1B0Efefed
        });
    }

    /// @dev BaseMainnet Brett
    function BRETT() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Brett",
            symbol: "BRETT",
            decimals: 18,
            assetAddress: 0x532f27101965dd16442E59d40670FaF5eBB142E4
        });
    }

    /// @dev BaseMainnet higher
    function HIGHER() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "higher",
            symbol: "HIGHER",
            decimals: 18,
            assetAddress: 0x0578d8A44db98B23BF096A382e016e29a5Ce0ffe
        });
    }

    /// @dev BaseMainnet luminous
    function LUM() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "luminous",
            symbol: "LUM",
            decimals: 18,
            assetAddress: 0x0fD7a301B51d0A83FCAf6718628174D527B373b6
        });
    }

    /// @dev BaseMainnet WELL
    function WELL() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "WELL",
            symbol: "WELL",
            decimals: 18,
            assetAddress: 0xA88594D404727625A9437C3f886C7643872296AE
        });
    }

    /// @dev BaseMainnet Morpho Token
    function MORPHO() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Morpho Token",
            symbol: "MORPHO",
            decimals: 18,
            assetAddress: 0xBAa5CC21fd487B8Fcc2F632f3F4E8D37262a0842
        });
    }

    /// @dev BaseMainnet Compound
    function COMP() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Compound",
            symbol: "COMP",
            decimals: 18,
            assetAddress: 0x9e1028F5F1D5eDE59748FFceE5532509976840E0
        });
    }

    /// @dev BaseMainnet Coinbase Wrapped Staked ETH
    function cbETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Coinbase Wrapped Staked ETH",
            symbol: "cbETH",
            decimals: 18,
            assetAddress: 0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22
        });
    }

    /// @dev BaseMainnet Wrapped Ether
    function WETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped Ether",
            symbol: "WETH",
            decimals: 18,
            assetAddress: 0x4200000000000000000000000000000000000006
        });
    }

    /// @dev BaseMainnet Wrapped liquid staked Ether 2.0
    function wstETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped liquid staked Ether 2.0",
            symbol: "wstETH",
            decimals: 18,
            assetAddress: 0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452
        });
    }

    /// @dev BaseMainnet Coinbase Wrapped BTC
    function cbBTC() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Coinbase Wrapped BTC",
            symbol: "cbBTC",
            decimals: 8,
            assetAddress: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf
        });
    }

    /// @dev BaseMainnet Renzo Restaked ETH
    function ezETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Renzo Restaked ETH",
            symbol: "ezETH",
            decimals: 18,
            assetAddress: 0x2416092f143378750bb29b79eD961ab195CcEea5
        });
    }

    /// @dev BaseMainnet Wrapped eETH
    function weETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped eETH",
            symbol: "weETH",
            decimals: 18,
            assetAddress: 0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A
        });
    }

    /// @dev BaseMainnet rsETHWrapper
    function wrsETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "rsETHWrapper",
            symbol: "wrsETH",
            decimals: 18,
            assetAddress: 0xEDfa23602D0EC14714057867A78d01e94176BEA0
        });
    }

    /// @dev KnownPriceFeed constructors

    /// @dev BaseMainnet ETH_USD price feed
    function ETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x71041dddad3595F9CEd3DcCFBe3D1F4b0a16Bb70
        });
    }

    /// @dev BaseMainnet USDC_USD price feed
    function USDC_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x7e860098F58bBFC8648a4311b374B1D669a2bc6B
        });
    }

    /// @dev BaseMainnet wstETH_ETH price feed
    function wstETH_ETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "ETH",
            decimals: 18,
            priceFeed: 0x43a5C292A453A3bF3606fa856197f09D7B74251a
        });
    }

    /// @dev BaseMainnet COMP_USD price feed
    function COMP_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "COMP",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x9DDa783DE64A9d1A60c49ca761EbE528C35BA428
        });
    }

    /// @dev BaseMainnet cbETH_USD price feed
    function cbETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x4687670f5f01716fAA382E2356C103BaD776752C
        });
    }

    /// @dev BaseMainnet WETH_USD price feed
    function WETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x71041dddad3595F9CEd3DcCFBe3D1F4b0a16Bb70
        });
    }

    /// @dev BaseMainnet wstETH_USD price feed
    function wstETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x4b5DeE60531a72C1264319Ec6A22678a4D0C8118
        });
    }

    /// @dev BaseMainnet cbBTC_USD price feed
    function cbBTC_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbBTC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x8D38A3d6B3c3B7d96D6536DA7Eef94A9d7dbC991
        });
    }

    /// @dev BaseMainnet cbETH_WETH price feed
    function cbETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x59e242D352ae13166B4987aE5c990C232f7f7CD6
        });
    }

    /// @dev BaseMainnet ezETH_WETH price feed
    function ezETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ezETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x72874CfE957bb47795548e5a9fd740D135ba5E45
        });
    }

    /// @dev BaseMainnet wstETH_WETH price feed
    function wstETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x1F71901daf98d70B4BAF40DE080321e5C2676856
        });
    }

    /// @dev BaseMainnet USDC_WETH price feed
    function USDC_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x2F4eAF29dfeeF4654bD091F7112926E108eF4Ed0
        });
    }

    /// @dev BaseMainnet weETH_WETH price feed
    function weETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "weETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x841e380e3a98E4EE8912046d69731F4E21eFb1D7
        });
    }

    /// @dev BaseMainnet wrsETH_WETH price feed
    function wrsETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wrsETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xaeB318360f27748Acb200CE616E389A6C9409a07
        });
    }

    /// @dev BaseMainnet cbBTC_WETH price feed
    function cbBTC_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbBTC",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x4cfCE7795bF75dC3795369A953d9A9b8C2679AE4
        });
    }

    /// @dev KnownComet constructors

    /// @dev BaseMainnet Compound USDC
    function Comet_cUSDCv3() internal pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](4);

        collaterals[0] = KnownCometCollateral({
            asset: 0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22,
            supplyCap: 7500000000000000000000,
            priceFeed: 0x4687670f5f01716fAA382E2356C103BaD776752C,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0x4200000000000000000000000000000000000006,
            supplyCap: 11000000000000000000000,
            priceFeed: 0x71041dddad3595F9CEd3DcCFBe3D1F4b0a16Bb70,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.5e17,
            liquidateCollateralFactor: 9e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452,
            supplyCap: 700000000000000000000,
            priceFeed: 0x4b5DeE60531a72C1264319Ec6A22678a4D0C8118,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf,
            supplyCap: 9000000000,
            priceFeed: 0x8D38A3d6B3c3B7d96D6536DA7Eef94A9d7dbC991,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        return KnownComet({
            name: "Compound USDC",
            symbol: "cUSDCv3",
            cometAddress: 0xb125E6687d4313864e53df431d5425969c15Eb2F,
            rewardsAddress: 0x123964802e6ABabBE1Bc9547D72Ef1B69B00A6b1,
            factorScale: 1e18,
            baseAsset: 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913,
            collateralAssets: collaterals
        });
    }

    /// @dev BaseMainnet Compound WETH
    function Comet_cWETHv3() internal pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](7);

        collaterals[0] = KnownCometCollateral({
            asset: 0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22,
            supplyCap: 7500000000000000000000,
            priceFeed: 0x59e242D352ae13166B4987aE5c990C232f7f7CD6,
            liquidationFactor: 9.75e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0x2416092f143378750bb29b79eD961ab195CcEea5,
            supplyCap: 2000000000000000000000,
            priceFeed: 0x72874CfE957bb47795548e5a9fd740D135ba5E45,
            liquidationFactor: 9.4e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9.1e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452,
            supplyCap: 1200000000000000000000,
            priceFeed: 0x1F71901daf98d70B4BAF40DE080321e5C2676856,
            liquidationFactor: 9.75e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913,
            supplyCap: 20000000000000,
            priceFeed: 0x2F4eAF29dfeeF4654bD091F7112926E108eF4Ed0,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[4] = KnownCometCollateral({
            asset: 0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A,
            supplyCap: 2100000000000000000000,
            priceFeed: 0x841e380e3a98E4EE8912046d69731F4E21eFb1D7,
            liquidationFactor: 9.6e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[5] = KnownCometCollateral({
            asset: 0xEDfa23602D0EC14714057867A78d01e94176BEA0,
            supplyCap: 230000000000000000000,
            priceFeed: 0xaeB318360f27748Acb200CE616E389A6C9409a07,
            liquidationFactor: 9.6e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9.1e17
        });

        collaterals[6] = KnownCometCollateral({
            asset: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf,
            supplyCap: 4500000000,
            priceFeed: 0x4cfCE7795bF75dC3795369A953d9A9b8C2679AE4,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        return KnownComet({
            name: "Compound WETH",
            symbol: "cWETHv3",
            cometAddress: 0x46e6b214b524310239732D51387075E0e70970bf,
            rewardsAddress: 0x123964802e6ABabBE1Bc9547D72Ef1B69B00A6b1,
            factorScale: 1e18,
            baseAsset: 0x4200000000000000000000000000000000000006,
            collateralAssets: collaterals
        });
    }

    /// @dev All BaseMainnet known assets
    function knownAssets() internal pure returns (KnownAsset[] memory) {
        KnownAsset[] memory assets = new KnownAsset[](17);
        assets[0] = ETH();
        assets[1] = USDC();
        assets[2] = AERO();
        assets[3] = DEGEN();
        assets[4] = BRETT();
        assets[5] = HIGHER();
        assets[6] = LUM();
        assets[7] = WELL();
        assets[8] = MORPHO();
        assets[9] = COMP();
        assets[10] = cbETH();
        assets[11] = WETH();
        assets[12] = wstETH();
        assets[13] = cbBTC();
        assets[14] = ezETH();
        assets[15] = weETH();
        assets[16] = wrsETH();
        return assets;
    }

    /// @dev All BaseMainnet known price feeds
    function knownPriceFeeds() internal pure returns (KnownPriceFeed[] memory) {
        KnownPriceFeed[] memory priceFeeds = new KnownPriceFeed[](15);
        priceFeeds[0] = ETH_USD();
        priceFeeds[1] = USDC_USD();
        priceFeeds[2] = wstETH_ETH();
        priceFeeds[3] = COMP_USD();
        priceFeeds[4] = cbETH_USD();
        priceFeeds[5] = WETH_USD();
        priceFeeds[6] = wstETH_USD();
        priceFeeds[7] = cbBTC_USD();
        priceFeeds[8] = cbETH_WETH();
        priceFeeds[9] = ezETH_WETH();
        priceFeeds[10] = wstETH_WETH();
        priceFeeds[11] = USDC_WETH();
        priceFeeds[12] = weETH_WETH();
        priceFeeds[13] = wrsETH_WETH();
        priceFeeds[14] = cbBTC_WETH();
        return priceFeeds;
    }

    /// @dev All BaseMainnet known comets
    function knownComets() internal pure returns (KnownComet[] memory) {
        KnownComet[] memory comets = new KnownComet[](2);
        comets[0] = Comet_cUSDCv3();
        comets[1] = Comet_cWETHv3();
        return comets;
    }

    /// @dev The big BaseMainnet burrito
    function knownNetwork() internal pure returns (KnownNetwork memory) {
        return KnownNetwork({
            chainId: 8453,
            isTestnet: false,
            assets: knownAssets(),
            comets: knownComets(),
            priceFeeds: knownPriceFeeds()
        });
    }
}

library ArbitrumMainnet {
    /// @dev KnownAsset constructors

    /// @dev ArbitrumMainnet Ether
    function ETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Ether",
            symbol: "ETH",
            decimals: 18,
            assetAddress: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        });
    }

    /// @dev ArbitrumMainnet USD Coin
    function USDC() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "USD Coin",
            symbol: "USDC",
            decimals: 6,
            assetAddress: 0xaf88d065e77c8cC2239327C5EDb3A432268e5831
        });
    }

    /// @dev ArbitrumMainnet Tether USD
    function USDT() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Tether USD",
            symbol: "USDT",
            decimals: 6,
            assetAddress: 0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9
        });
    }

    /// @dev ArbitrumMainnet Wrapped BTC
    function WBTC() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped BTC",
            symbol: "WBTC",
            decimals: 8,
            assetAddress: 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f
        });
    }

    /// @dev ArbitrumMainnet Arbitrum
    function ARB() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Arbitrum",
            symbol: "ARB",
            decimals: 18,
            assetAddress: 0x912CE59144191C1204E64559FE8253a0e49E6548
        });
    }

    /// @dev ArbitrumMainnet Compound
    function COMP() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Compound",
            symbol: "COMP",
            decimals: 18,
            assetAddress: 0x354A6dA3fcde098F8389cad84b0182725c6C91dE
        });
    }

    /// @dev ArbitrumMainnet GMX
    function GMX() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "GMX",
            symbol: "GMX",
            decimals: 18,
            assetAddress: 0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a
        });
    }

    /// @dev ArbitrumMainnet Wrapped Ether
    function WETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped Ether",
            symbol: "WETH",
            decimals: 18,
            assetAddress: 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1
        });
    }

    /// @dev ArbitrumMainnet Wrapped liquid staked Ether 2.0
    function wstETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped liquid staked Ether 2.0",
            symbol: "wstETH",
            decimals: 18,
            assetAddress: 0x5979D7b546E38E414F7E9822514be443A4800529
        });
    }

    /// @dev ArbitrumMainnet Renzo Restaked ETH
    function ezETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Renzo Restaked ETH",
            symbol: "ezETH",
            decimals: 18,
            assetAddress: 0x2416092f143378750bb29b79eD961ab195CcEea5
        });
    }

    /// @dev ArbitrumMainnet Wrapped eETH
    function weETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped eETH",
            symbol: "weETH",
            decimals: 18,
            assetAddress: 0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe
        });
    }

    /// @dev ArbitrumMainnet Rocket Pool ETH
    function rETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Rocket Pool ETH",
            symbol: "rETH",
            decimals: 18,
            assetAddress: 0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8
        });
    }

    /// @dev ArbitrumMainnet KelpDao Restaked ETH
    function rsETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "KelpDao Restaked ETH",
            symbol: "rsETH",
            decimals: 18,
            assetAddress: 0x4186BFC76E2E237523CBC30FD220FE055156b41F
        });
    }

    /// @dev KnownPriceFeed constructors

    /// @dev ArbitrumMainnet ETH_USD price feed
    function ETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612
        });
    }

    /// @dev ArbitrumMainnet USDC_USD price feed
    function USDC_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3
        });
    }

    /// @dev ArbitrumMainnet USDT_USD price feed
    function USDT_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDT",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x3f3f5dF88dC9F13eac63DF89EC16ef6e7E25DdE7
        });
    }

    /// @dev ArbitrumMainnet WBTC_USD price feed
    function WBTC_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WBTC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xd0C7101eACbB49F3deCcCc166d238410D6D46d57
        });
    }

    /// @dev ArbitrumMainnet ARB_USD price feed
    function ARB_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ARB",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6
        });
    }

    /// @dev ArbitrumMainnet COMP_USD price feed
    function COMP_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "COMP",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xe7C53FFd03Eb6ceF7d208bC4C13446c76d1E5884
        });
    }

    /// @dev ArbitrumMainnet GMX_USD price feed
    function GMX_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "GMX",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xDB98056FecFff59D032aB628337A4887110df3dB
        });
    }

    /// @dev ArbitrumMainnet WETH_USD price feed
    function WETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612
        });
    }

    /// @dev ArbitrumMainnet wstETH_USD price feed
    function wstETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xe165155c34fE4cBfC55Fc554437907BDb1Af7e3e
        });
    }

    /// @dev ArbitrumMainnet ezETH_USD price feed
    function ezETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ezETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xC49399814452B41dA8a7cd76a159f5515cb3e493
        });
    }

    /// @dev ArbitrumMainnet ARB_USDT price feed
    function ARB_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ARB",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6
        });
    }

    /// @dev ArbitrumMainnet WETH_USDT price feed
    function WETH_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WETH",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612
        });
    }

    /// @dev ArbitrumMainnet wstETH_USDT price feed
    function wstETH_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0xe165155c34fE4cBfC55Fc554437907BDb1Af7e3e
        });
    }

    /// @dev ArbitrumMainnet WBTC_USDT price feed
    function WBTC_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WBTC",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0xd0C7101eACbB49F3deCcCc166d238410D6D46d57
        });
    }

    /// @dev ArbitrumMainnet GMX_USDT price feed
    function GMX_USDT() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "GMX",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0xDB98056FecFff59D032aB628337A4887110df3dB
        });
    }

    /// @dev ArbitrumMainnet weETH_WETH price feed
    function weETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "weETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xd3cf278F135D9831D2bF28F6672a4575906CA724
        });
    }

    /// @dev ArbitrumMainnet rETH_WETH price feed
    function rETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "rETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x970FfD8E335B8fa4cd5c869c7caC3a90671d5Dc3
        });
    }

    /// @dev ArbitrumMainnet wstETH_WETH price feed
    function wstETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x6C987dDE50dB1dcDd32Cd4175778C2a291978E2a
        });
    }

    /// @dev ArbitrumMainnet WBTC_WETH price feed
    function WBTC_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WBTC",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xFa454dE61b317b6535A0C462267208E8FdB89f45
        });
    }

    /// @dev ArbitrumMainnet rsETH_WETH price feed
    function rsETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "rsETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x3870FAc3De911c12A57E5a2532D15aD8Ca275A60
        });
    }

    /// @dev ArbitrumMainnet USDT_WETH price feed
    function USDT_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDT",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x84E93EC6170ED630f5ebD89A1AAE72d4F63f2713
        });
    }

    /// @dev ArbitrumMainnet USDC_WETH price feed
    function USDC_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x443EA0340cb75a160F31A440722dec7b5bc3C2E9
        });
    }

    /// @dev ArbitrumMainnet ezETH_WETH price feed
    function ezETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ezETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x72e9B6F907365d76C6192aD49C0C5ba356b7Fa48
        });
    }

    /// @dev KnownComet constructors

    /// @dev ArbitrumMainnet Compound USDC
    function Comet_cUSDCv3() internal pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](6);

        collaterals[0] = KnownCometCollateral({
            asset: 0x912CE59144191C1204E64559FE8253a0e49E6548,
            supplyCap: 16000000000000000000000000,
            priceFeed: 0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 7e17,
            liquidateCollateralFactor: 8e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a,
            supplyCap: 120000000000000000000000,
            priceFeed: 0xDB98056FecFff59D032aB628337A4887110df3dB,
            liquidationFactor: 8.5e17,
            borrowCollateralFactor: 6e17,
            liquidateCollateralFactor: 7.5e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1,
            supplyCap: 40000000000000000000000,
            priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.3e17,
            liquidateCollateralFactor: 9e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f,
            supplyCap: 100000000000,
            priceFeed: 0xd0C7101eACbB49F3deCcCc166d238410D6D46d57,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 7.5e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[4] = KnownCometCollateral({
            asset: 0x5979D7b546E38E414F7E9822514be443A4800529,
            supplyCap: 8000000000000000000000,
            priceFeed: 0xe165155c34fE4cBfC55Fc554437907BDb1Af7e3e,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[5] = KnownCometCollateral({
            asset: 0x2416092f143378750bb29b79eD961ab195CcEea5,
            supplyCap: 1400000000000000000000,
            priceFeed: 0xC49399814452B41dA8a7cd76a159f5515cb3e493,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        return KnownComet({
            name: "Compound USDC",
            symbol: "cUSDCv3",
            cometAddress: 0x9c4ec768c28520B50860ea7a15bd7213a9fF58bf,
            rewardsAddress: 0x88730d254A2f7e6AC8388c3198aFd694bA9f7fae,
            factorScale: 1e18,
            baseAsset: 0xaf88d065e77c8cC2239327C5EDb3A432268e5831,
            collateralAssets: collaterals
        });
    }

    /// @dev ArbitrumMainnet Compound USDT
    function Comet_cUSDTv3() internal pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](5);

        collaterals[0] = KnownCometCollateral({
            asset: 0x912CE59144191C1204E64559FE8253a0e49E6548,
            supplyCap: 7500000000000000000000000,
            priceFeed: 0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 7e17,
            liquidateCollateralFactor: 8e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1,
            supplyCap: 20000000000000000000000,
            priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.5e17,
            liquidateCollateralFactor: 9e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0x5979D7b546E38E414F7E9822514be443A4800529,
            supplyCap: 16000000000000000000000,
            priceFeed: 0xe165155c34fE4cBfC55Fc554437907BDb1Af7e3e,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f,
            supplyCap: 100000000000,
            priceFeed: 0xd0C7101eACbB49F3deCcCc166d238410D6D46d57,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 7e17,
            liquidateCollateralFactor: 8e17
        });

        collaterals[4] = KnownCometCollateral({
            asset: 0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a,
            supplyCap: 100000000000000000000000,
            priceFeed: 0xDB98056FecFff59D032aB628337A4887110df3dB,
            liquidationFactor: 8e17,
            borrowCollateralFactor: 6e17,
            liquidateCollateralFactor: 7e17
        });

        return KnownComet({
            name: "Compound USDT",
            symbol: "cUSDTv3",
            cometAddress: 0xd98Be00b5D27fc98112BdE293e487f8D4cA57d07,
            rewardsAddress: 0x88730d254A2f7e6AC8388c3198aFd694bA9f7fae,
            factorScale: 1e18,
            baseAsset: 0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9,
            collateralAssets: collaterals
        });
    }

    /// @dev ArbitrumMainnet Compound WETH
    function Comet_cWETHv3() internal pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](8);

        collaterals[0] = KnownCometCollateral({
            asset: 0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe,
            supplyCap: 24000000000000000000000,
            priceFeed: 0xd3cf278F135D9831D2bF28F6672a4575906CA724,
            liquidationFactor: 9.6e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8,
            supplyCap: 7500000000000000000000,
            priceFeed: 0x970FfD8E335B8fa4cd5c869c7caC3a90671d5Dc3,
            liquidationFactor: 9.7e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0x5979D7b546E38E414F7E9822514be443A4800529,
            supplyCap: 10000000000000000000000,
            priceFeed: 0x6C987dDE50dB1dcDd32Cd4175778C2a291978E2a,
            liquidationFactor: 9.7e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f,
            supplyCap: 100000000000,
            priceFeed: 0xFa454dE61b317b6535A0C462267208E8FdB89f45,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[4] = KnownCometCollateral({
            asset: 0x4186BFC76E2E237523CBC30FD220FE055156b41F,
            supplyCap: 3500000000000000000000,
            priceFeed: 0x3870FAc3De911c12A57E5a2532D15aD8Ca275A60,
            liquidationFactor: 9.6e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9.1e17
        });

        collaterals[5] = KnownCometCollateral({
            asset: 0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9,
            supplyCap: 20000000000000,
            priceFeed: 0x84E93EC6170ED630f5ebD89A1AAE72d4F63f2713,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[6] = KnownCometCollateral({
            asset: 0xaf88d065e77c8cC2239327C5EDb3A432268e5831,
            supplyCap: 30000000000000,
            priceFeed: 0x443EA0340cb75a160F31A440722dec7b5bc3C2E9,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[7] = KnownCometCollateral({
            asset: 0x2416092f143378750bb29b79eD961ab195CcEea5,
            supplyCap: 12000000000000000000000,
            priceFeed: 0x72e9B6F907365d76C6192aD49C0C5ba356b7Fa48,
            liquidationFactor: 9.4e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9.1e17
        });

        return KnownComet({
            name: "Compound WETH",
            symbol: "cWETHv3",
            cometAddress: 0x6f7D514bbD4aFf3BcD1140B7344b32f063dEe486,
            rewardsAddress: 0x88730d254A2f7e6AC8388c3198aFd694bA9f7fae,
            factorScale: 1e18,
            baseAsset: 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1,
            collateralAssets: collaterals
        });
    }

    /// @dev All ArbitrumMainnet known assets
    function knownAssets() internal pure returns (KnownAsset[] memory) {
        KnownAsset[] memory assets = new KnownAsset[](13);
        assets[0] = ETH();
        assets[1] = USDC();
        assets[2] = USDT();
        assets[3] = WBTC();
        assets[4] = ARB();
        assets[5] = COMP();
        assets[6] = GMX();
        assets[7] = WETH();
        assets[8] = wstETH();
        assets[9] = ezETH();
        assets[10] = weETH();
        assets[11] = rETH();
        assets[12] = rsETH();
        return assets;
    }

    /// @dev All ArbitrumMainnet known price feeds
    function knownPriceFeeds() internal pure returns (KnownPriceFeed[] memory) {
        KnownPriceFeed[] memory priceFeeds = new KnownPriceFeed[](23);
        priceFeeds[0] = ETH_USD();
        priceFeeds[1] = USDC_USD();
        priceFeeds[2] = USDT_USD();
        priceFeeds[3] = WBTC_USD();
        priceFeeds[4] = ARB_USD();
        priceFeeds[5] = COMP_USD();
        priceFeeds[6] = GMX_USD();
        priceFeeds[7] = WETH_USD();
        priceFeeds[8] = wstETH_USD();
        priceFeeds[9] = ezETH_USD();
        priceFeeds[10] = ARB_USDT();
        priceFeeds[11] = WETH_USDT();
        priceFeeds[12] = wstETH_USDT();
        priceFeeds[13] = WBTC_USDT();
        priceFeeds[14] = GMX_USDT();
        priceFeeds[15] = weETH_WETH();
        priceFeeds[16] = rETH_WETH();
        priceFeeds[17] = wstETH_WETH();
        priceFeeds[18] = WBTC_WETH();
        priceFeeds[19] = rsETH_WETH();
        priceFeeds[20] = USDT_WETH();
        priceFeeds[21] = USDC_WETH();
        priceFeeds[22] = ezETH_WETH();
        return priceFeeds;
    }

    /// @dev All ArbitrumMainnet known comets
    function knownComets() internal pure returns (KnownComet[] memory) {
        KnownComet[] memory comets = new KnownComet[](3);
        comets[0] = Comet_cUSDCv3();
        comets[1] = Comet_cUSDTv3();
        comets[2] = Comet_cWETHv3();
        return comets;
    }

    /// @dev The big ArbitrumMainnet burrito
    function knownNetwork() internal pure returns (KnownNetwork memory) {
        return KnownNetwork({
            chainId: 42161,
            isTestnet: false,
            assets: knownAssets(),
            comets: knownComets(),
            priceFeeds: knownPriceFeeds()
        });
    }
}

library EthereumSepolia {
    /// @dev KnownAsset constructors

    /// @dev EthereumSepolia Ether
    function ETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Ether",
            symbol: "ETH",
            decimals: 18,
            assetAddress: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        });
    }

    /// @dev EthereumSepolia USDC
    function USDC() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "USDC",
            symbol: "USDC",
            decimals: 6,
            assetAddress: 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238
        });
    }

    /// @dev EthereumSepolia Wrapped Ether
    function WETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped Ether",
            symbol: "WETH",
            decimals: 18,
            assetAddress: 0x2D5ee574e710219a521449679A4A7f2B43f046ad
        });
    }

    /// @dev EthereumSepolia Compound
    function COMP() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Compound",
            symbol: "COMP",
            decimals: 18,
            assetAddress: 0xA6c8D1c55951e8AC44a0EaA959Be5Fd21cc07531
        });
    }

    /// @dev EthereumSepolia Coinbase Wrapped Staked ETH
    function cbETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Coinbase Wrapped Staked ETH",
            symbol: "cbETH",
            decimals: 18,
            assetAddress: 0xb9fa8F5eC3Da13B508F462243Ad0555B46E028df
        });
    }

    /// @dev EthereumSepolia Wrapped liquid staked Ether 2.0
    function wstETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped liquid staked Ether 2.0",
            symbol: "wstETH",
            decimals: 18,
            assetAddress: 0xB82381A3fBD3FaFA77B3a7bE693342618240067b
        });
    }

    /// @dev EthereumSepolia Wrapped BTC
    function WBTC() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped BTC",
            symbol: "WBTC",
            decimals: 8,
            assetAddress: 0xa035b9e130F2B1AedC733eEFb1C67Ba4c503491F
        });
    }

    /// @dev KnownPriceFeed constructors

    /// @dev EthereumSepolia ETH_USD price feed
    function ETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
    }

    /// @dev EthereumSepolia WETH_USD price feed
    function WETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
    }

    /// @dev EthereumSepolia COMP_USD price feed
    function COMP_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "COMP",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x619db7F74C0061E2917D1D57f834D9D24C5529dA
        });
    }

    /// @dev EthereumSepolia cbETH_WETH price feed
    function cbETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xBE60803049CA4Aea3B75E4238d664aEbcdDd0773
        });
    }

    /// @dev EthereumSepolia wstETH_WETH price feed
    function wstETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x722c4ba7Eb8A1b0fD360bFF6cf19E5E2AA1C3DdF
        });
    }

    /// @dev EthereumSepolia USDC_USD price feed
    function USDC_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xA2F78ab2355fe2f984D808B5CeE7FD0A93D5270E
        });
    }

    /// @dev EthereumSepolia WBTC_USD price feed
    function WBTC_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WBTC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        });
    }

    /// @dev KnownComet constructors

    /// @dev EthereumSepolia Compound WETH
    function Comet_cWETHv3() internal pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](2);

        collaterals[0] = KnownCometCollateral({
            asset: 0xb9fa8F5eC3Da13B508F462243Ad0555B46E028df,
            supplyCap: 9000000000000000000000,
            priceFeed: 0xBE60803049CA4Aea3B75E4238d664aEbcdDd0773,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0xB82381A3fBD3FaFA77B3a7bE693342618240067b,
            supplyCap: 80000000000000000000000,
            priceFeed: 0x722c4ba7Eb8A1b0fD360bFF6cf19E5E2AA1C3DdF,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        return KnownComet({
            name: "Compound WETH",
            symbol: "cWETHv3",
            cometAddress: 0x2943ac1216979aD8dB76D9147F64E61adc126e96,
            rewardsAddress: 0x8bF5b658bdF0388E8b482ED51B14aef58f90abfD,
            factorScale: 1e18,
            baseAsset: 0x2D5ee574e710219a521449679A4A7f2B43f046ad,
            collateralAssets: collaterals
        });
    }

    /// @dev EthereumSepolia Compound USDC
    function Comet_cUSDCv3() internal pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](3);

        collaterals[0] = KnownCometCollateral({
            asset: 0xA6c8D1c55951e8AC44a0EaA959Be5Fd21cc07531,
            supplyCap: 500000000000000000000000,
            priceFeed: 0x619db7F74C0061E2917D1D57f834D9D24C5529dA,
            liquidationFactor: 9.2e17,
            borrowCollateralFactor: 6.5e17,
            liquidateCollateralFactor: 7e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0xa035b9e130F2B1AedC733eEFb1C67Ba4c503491F,
            supplyCap: 3500000000000,
            priceFeed: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43,
            liquidationFactor: 9.3e17,
            borrowCollateralFactor: 7e17,
            liquidateCollateralFactor: 7.5e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0x2D5ee574e710219a521449679A4A7f2B43f046ad,
            supplyCap: 1000000000000000000000000,
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306,
            liquidationFactor: 9.3e17,
            borrowCollateralFactor: 8.2e17,
            liquidateCollateralFactor: 8.5e17
        });

        return KnownComet({
            name: "Compound USDC",
            symbol: "cUSDCv3",
            cometAddress: 0xAec1F48e02Cfb822Be958B68C7957156EB3F0b6e,
            rewardsAddress: 0x8bF5b658bdF0388E8b482ED51B14aef58f90abfD,
            factorScale: 1e18,
            baseAsset: 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238,
            collateralAssets: collaterals
        });
    }

    /// @dev All EthereumSepolia known assets
    function knownAssets() internal pure returns (KnownAsset[] memory) {
        KnownAsset[] memory assets = new KnownAsset[](7);
        assets[0] = ETH();
        assets[1] = USDC();
        assets[2] = WETH();
        assets[3] = COMP();
        assets[4] = cbETH();
        assets[5] = wstETH();
        assets[6] = WBTC();
        return assets;
    }

    /// @dev All EthereumSepolia known price feeds
    function knownPriceFeeds() internal pure returns (KnownPriceFeed[] memory) {
        KnownPriceFeed[] memory priceFeeds = new KnownPriceFeed[](7);
        priceFeeds[0] = ETH_USD();
        priceFeeds[1] = WETH_USD();
        priceFeeds[2] = COMP_USD();
        priceFeeds[3] = cbETH_WETH();
        priceFeeds[4] = wstETH_WETH();
        priceFeeds[5] = USDC_USD();
        priceFeeds[6] = WBTC_USD();
        return priceFeeds;
    }

    /// @dev All EthereumSepolia known comets
    function knownComets() internal pure returns (KnownComet[] memory) {
        KnownComet[] memory comets = new KnownComet[](2);
        comets[0] = Comet_cWETHv3();
        comets[1] = Comet_cUSDCv3();
        return comets;
    }

    /// @dev The big EthereumSepolia burrito
    function knownNetwork() internal pure returns (KnownNetwork memory) {
        return KnownNetwork({
            chainId: 11155111,
            isTestnet: true,
            assets: knownAssets(),
            comets: knownComets(),
            priceFeeds: knownPriceFeeds()
        });
    }
}

library BaseSepolia {
    /// @dev KnownAsset constructors

    /// @dev BaseSepolia Ether
    function ETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Ether",
            symbol: "ETH",
            decimals: 18,
            assetAddress: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        });
    }

    /// @dev BaseSepolia USDC
    function USDC() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "USDC",
            symbol: "USDC",
            decimals: 6,
            assetAddress: 0x036CbD53842c5426634e7929541eC2318f3dCF7e
        });
    }

    /// @dev BaseSepolia Wrapped Ether
    function WETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped Ether",
            symbol: "WETH",
            decimals: 18,
            assetAddress: 0x4200000000000000000000000000000000000006
        });
    }

    /// @dev BaseSepolia Compound
    function COMP() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Compound",
            symbol: "COMP",
            decimals: 18,
            assetAddress: 0x2f535da74048c0874400f0371Fba20DF983A56e2
        });
    }

    /// @dev BaseSepolia Coinbase Wrapped Staked ETH
    function cbETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Coinbase Wrapped Staked ETH",
            symbol: "cbETH",
            decimals: 18,
            assetAddress: 0x774eD9EDB0C5202dF9A86183804b5D9E99dC6CA3
        });
    }

    /// @dev KnownPriceFeed constructors

    /// @dev BaseSepolia ETH_USD price feed
    function ETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x4aDC67696bA383F43DD60A9e78F2C97Fbbfc7cb1
        });
    }

    /// @dev BaseSepolia WETH_USD price feed
    function WETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x4aDC67696bA383F43DD60A9e78F2C97Fbbfc7cb1
        });
    }

    /// @dev BaseSepolia COMP_USD price feed
    function COMP_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "COMP",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x9123612E1791817ed4bFfC4b57CA8aA1E4bCdBaa
        });
    }

    /// @dev BaseSepolia cbETH_WETH price feed
    function cbETH_WETH() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x6490397583a86566C01F467790125F1FED556299
        });
    }

    /// @dev BaseSepolia USDC_USD price feed
    function USDC_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xDC6d86db02E198764B077e1af7B1d31BbF575508
        });
    }

    /// @dev BaseSepolia cbETH_USD price feed
    function cbETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x3e7e00F0c81712205A5F6c90D64879663c212873
        });
    }

    /// @dev Omitted duplicate WETH_USD price feed at 0xBD767F0b5925034F4e37D8990FC8fF080F6f92C8

    /// @dev Omitted duplicate USDC_USD price feed at 0xd30e2101a97dcbAeBCBC04F14C3f624E67A35165

    /// @dev KnownComet constructors

    /// @dev BaseSepolia Compound WETH
    function Comet_cWETHv3() internal pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](1);

        collaterals[0] = KnownCometCollateral({
            asset: 0x774eD9EDB0C5202dF9A86183804b5D9E99dC6CA3,
            supplyCap: 7500000000000000000000,
            priceFeed: 0x6490397583a86566C01F467790125F1FED556299,
            liquidationFactor: 9.75e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        return KnownComet({
            name: "Compound WETH",
            symbol: "cWETHv3",
            cometAddress: 0x61490650AbaA31393464C3f34E8B29cd1C44118E,
            rewardsAddress: 0x3394fa1baCC0b47dd0fF28C8573a476a161aF7BC,
            factorScale: 1e18,
            baseAsset: 0x4200000000000000000000000000000000000006,
            collateralAssets: collaterals
        });
    }

    /// @dev BaseSepolia Compound USDC
    function Comet_cUSDCv3() internal pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](2);

        collaterals[0] = KnownCometCollateral({
            asset: 0x774eD9EDB0C5202dF9A86183804b5D9E99dC6CA3,
            supplyCap: 800000000000000000000,
            priceFeed: 0x3e7e00F0c81712205A5F6c90D64879663c212873,
            liquidationFactor: 9.3e17,
            borrowCollateralFactor: 7.5e17,
            liquidateCollateralFactor: 8e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0x4200000000000000000000000000000000000006,
            supplyCap: 1000000000000000000000,
            priceFeed: 0xBD767F0b5925034F4e37D8990FC8fF080F6f92C8,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 7.75e17,
            liquidateCollateralFactor: 8.25e17
        });

        return KnownComet({
            name: "Compound USDC",
            symbol: "cUSDCv3",
            cometAddress: 0x571621Ce60Cebb0c1D442B5afb38B1663C6Bf017,
            rewardsAddress: 0x3394fa1baCC0b47dd0fF28C8573a476a161aF7BC,
            factorScale: 1e18,
            baseAsset: 0x036CbD53842c5426634e7929541eC2318f3dCF7e,
            collateralAssets: collaterals
        });
    }

    /// @dev All BaseSepolia known assets
    function knownAssets() internal pure returns (KnownAsset[] memory) {
        KnownAsset[] memory assets = new KnownAsset[](5);
        assets[0] = ETH();
        assets[1] = USDC();
        assets[2] = WETH();
        assets[3] = COMP();
        assets[4] = cbETH();
        return assets;
    }

    /// @dev All BaseSepolia known price feeds
    function knownPriceFeeds() internal pure returns (KnownPriceFeed[] memory) {
        KnownPriceFeed[] memory priceFeeds = new KnownPriceFeed[](8);
        priceFeeds[0] = ETH_USD();
        priceFeeds[1] = WETH_USD();
        priceFeeds[2] = COMP_USD();
        priceFeeds[3] = cbETH_WETH();
        priceFeeds[4] = USDC_USD();
        priceFeeds[5] = cbETH_USD();
        /// @dev Omitted duplicate USDC_USD price feed at 0xd30e2101a97dcbAeBCBC04F14C3f624E67A35165
        /// @dev Omitted duplicate WETH_USD price feed at 0xBD767F0b5925034F4e37D8990FC8fF080F6f92C8
        return priceFeeds;
    }

    /// @dev All BaseSepolia known comets
    function knownComets() internal pure returns (KnownComet[] memory) {
        KnownComet[] memory comets = new KnownComet[](2);
        comets[0] = Comet_cWETHv3();
        comets[1] = Comet_cUSDCv3();
        return comets;
    }

    /// @dev The big BaseSepolia burrito
    function knownNetwork() internal pure returns (KnownNetwork memory) {
        return KnownNetwork({
            chainId: 84532,
            isTestnet: true,
            assets: knownAssets(),
            comets: knownComets(),
            priceFeeds: knownPriceFeeds()
        });
    }
}

library ArbitrumSepolia {
    /// @dev KnownAsset constructors

    /// @dev ArbitrumSepolia Ether
    function ETH() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Ether",
            symbol: "ETH",
            decimals: 18,
            assetAddress: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        });
    }

    /// @dev ArbitrumSepolia USD Coin
    function USDC() internal pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "USD Coin",
            symbol: "USDC",
            decimals: 6,
            assetAddress: 0x75faf114eafb1BDbe2F0316DF893fd58CE46AA4d
        });
    }

    /// @dev KnownPriceFeed constructors

    /// @dev ArbitrumSepolia ETH_USD price feed
    function ETH_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xd30e2101a97dcbAeBCBC04F14C3f624E67A35165
        });
    }

    /// @dev ArbitrumSepolia USDC_USD price feed
    function USDC_USD() internal pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x0153002d20B96532C639313c2d54c3dA09109309
        });
    }

    /// @dev KnownComet constructors

    /// @dev All ArbitrumSepolia known assets
    function knownAssets() internal pure returns (KnownAsset[] memory) {
        KnownAsset[] memory assets = new KnownAsset[](2);
        assets[0] = ETH();
        assets[1] = USDC();
        return assets;
    }

    /// @dev All ArbitrumSepolia known price feeds
    function knownPriceFeeds() internal pure returns (KnownPriceFeed[] memory) {
        KnownPriceFeed[] memory priceFeeds = new KnownPriceFeed[](2);
        priceFeeds[0] = ETH_USD();
        priceFeeds[1] = USDC_USD();
        return priceFeeds;
    }

    /// @dev All ArbitrumSepolia known comets
    function knownComets() internal pure returns (KnownComet[] memory) {
        KnownComet[] memory comets = new KnownComet[](0);
        return comets;
    }

    /// @dev The big ArbitrumSepolia burrito
    function knownNetwork() internal pure returns (KnownNetwork memory) {
        return KnownNetwork({
            chainId: 421614,
            isTestnet: true,
            assets: knownAssets(),
            comets: knownComets(),
            priceFeeds: knownPriceFeeds()
        });
    }
}

/// @dev BuilderPack contracts, not to be imported by other code.

contract BuilderPackContract {
    string constant VERSION = "1";
    string constant GENDATE = "December 2nd, 2024";

    function CHAINS() public pure returns (uint256[] memory) {
        uint256[] memory chains = new uint256[](6);
        chains[0] = 1;
        chains[1] = 8453;
        chains[2] = 42161;
        chains[3] = 11155111;
        chains[4] = 84532;
        chains[5] = 421614;
        return chains;
    }

    function BLOCKS() public pure returns (uint256[] memory) {
        uint256[] memory blocks = new uint256[](6);
        blocks[0] = 21317040;
        blocks[1] = 23189778;
        blocks[2] = 280669072;
        blocks[3] = 7195000;
        blocks[4] = 18700000;
        blocks[5] = 102700000;
        return blocks;
    }

    function LIBRARIES() public pure returns (string[] memory) {
        string[] memory libraries = new string[](6);
        libraries[0] = "EthereumMainnet";
        libraries[1] = "BaseMainnet";
        libraries[2] = "ArbitrumMainnet";
        libraries[3] = "EthereumSepolia";
        libraries[4] = "BaseSepolia";
        libraries[5] = "ArbitrumSepolia";
        return libraries;
    }
}

contract ChainContract {
    /// @dev Ether
    function ETH(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.ETH();
        } else if (chainId == 8453) {
            return BaseMainnet.ETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.ETH();
        } else if (chainId == 11155111) {
            return EthereumSepolia.ETH();
        } else if (chainId == 84532) {
            return BaseSepolia.ETH();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.ETH();
        } else {
            revert NotFound("Asset for Ether not found on chain", chainId);
        }
    }

    /// @dev USD Coin
    function USDC(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.USDC();
        } else if (chainId == 8453) {
            return BaseMainnet.USDC();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.USDC();
        } else if (chainId == 11155111) {
            return EthereumSepolia.USDC();
        } else if (chainId == 84532) {
            return BaseSepolia.USDC();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.USDC();
        } else {
            revert NotFound("Asset for USD Coin not found on chain", chainId);
        }
    }

    /// @dev Dai Stablecoin
    function DAI(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.DAI();
        } else {
            revert NotFound("Asset for Dai Stablecoin not found on chain", chainId);
        }
    }

    /// @dev Tether USD
    function USDT(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.USDT();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.USDT();
        } else {
            revert NotFound("Asset for Tether USD not found on chain", chainId);
        }
    }

    /// @dev Frax
    function FRAX(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.FRAX();
        } else {
            revert NotFound("Asset for Frax not found on chain", chainId);
        }
    }

    /// @dev USDe
    function USDe(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.USDe();
        } else {
            revert NotFound("Asset for USDe not found on chain", chainId);
        }
    }

    /// @dev Arbitrum
    function ARB(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.ARB();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.ARB();
        } else {
            revert NotFound("Asset for Arbitrum not found on chain", chainId);
        }
    }

    /// @dev Blur
    function BLUR(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.BLUR();
        } else {
            revert NotFound("Asset for Blur not found on chain", chainId);
        }
    }

    /// @dev Curve DAO Token
    function CRV(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.CRV();
        } else {
            revert NotFound("Asset for Curve DAO Token not found on chain", chainId);
        }
    }

    /// @dev ENA
    function ENA(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.ENA();
        } else {
            revert NotFound("Asset for ENA not found on chain", chainId);
        }
    }

    /// @dev Lido DAO Token
    function LDO(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.LDO();
        } else {
            revert NotFound("Asset for Lido DAO Token not found on chain", chainId);
        }
    }

    /// @dev Pendle
    function PENDLE(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.PENDLE();
        } else {
            revert NotFound("Asset for Pendle not found on chain", chainId);
        }
    }

    /// @dev Pepe
    function PEPE(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.PEPE();
        } else {
            revert NotFound("Asset for Pepe not found on chain", chainId);
        }
    }

    /// @dev Rocket Pool Protocol
    function RPL(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.RPL();
        } else {
            revert NotFound("Asset for Rocket Pool Protocol not found on chain", chainId);
        }
    }

    /// @dev SHIBA INU
    function SHIB(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.SHIB();
        } else {
            revert NotFound("Asset for SHIBA INU not found on chain", chainId);
        }
    }

    /// @dev Compound
    function COMP(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.COMP();
        } else if (chainId == 8453) {
            return BaseMainnet.COMP();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.COMP();
        } else if (chainId == 11155111) {
            return EthereumSepolia.COMP();
        } else if (chainId == 84532) {
            return BaseSepolia.COMP();
        } else {
            revert NotFound("Asset for Compound not found on chain", chainId);
        }
    }

    /// @dev Wrapped BTC
    function WBTC(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.WBTC();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.WBTC();
        } else if (chainId == 11155111) {
            return EthereumSepolia.WBTC();
        } else {
            revert NotFound("Asset for Wrapped BTC not found on chain", chainId);
        }
    }

    /// @dev Wrapped Ether
    function WETH(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.WETH();
        } else if (chainId == 8453) {
            return BaseMainnet.WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.WETH();
        } else if (chainId == 11155111) {
            return EthereumSepolia.WETH();
        } else if (chainId == 84532) {
            return BaseSepolia.WETH();
        } else {
            revert NotFound("Asset for Wrapped Ether not found on chain", chainId);
        }
    }

    /// @dev Uniswap
    function UNI(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.UNI();
        } else {
            revert NotFound("Asset for Uniswap not found on chain", chainId);
        }
    }

    /// @dev ChainLink Token
    function LINK(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.LINK();
        } else {
            revert NotFound("Asset for ChainLink Token not found on chain", chainId);
        }
    }

    /// @dev Wrapped liquid staked Ether 2.0
    function wstETH(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.wstETH();
        } else if (chainId == 8453) {
            return BaseMainnet.wstETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.wstETH();
        } else if (chainId == 11155111) {
            return EthereumSepolia.wstETH();
        } else {
            revert NotFound("Asset for Wrapped liquid staked Ether 2.0 not found on chain", chainId);
        }
    }

    /// @dev Coinbase Wrapped BTC
    function cbBTC(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.cbBTC();
        } else if (chainId == 8453) {
            return BaseMainnet.cbBTC();
        } else {
            revert NotFound("Asset for Coinbase Wrapped BTC not found on chain", chainId);
        }
    }

    /// @dev tBTC v2
    function tBTC(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.tBTC();
        } else {
            revert NotFound("Asset for tBTC v2 not found on chain", chainId);
        }
    }

    /// @dev Coinbase Wrapped Staked ETH
    function cbETH(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.cbETH();
        } else if (chainId == 8453) {
            return BaseMainnet.cbETH();
        } else if (chainId == 11155111) {
            return EthereumSepolia.cbETH();
        } else if (chainId == 84532) {
            return BaseSepolia.cbETH();
        } else {
            revert NotFound("Asset for Coinbase Wrapped Staked ETH not found on chain", chainId);
        }
    }

    /// @dev Rocket Pool ETH
    function rETH(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.rETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.rETH();
        } else {
            revert NotFound("Asset for Rocket Pool ETH not found on chain", chainId);
        }
    }

    /// @dev rsETH
    function rsETH(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.rsETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.rsETH();
        } else {
            revert NotFound("Asset for rsETH not found on chain", chainId);
        }
    }

    /// @dev Wrapped eETH
    function weETH(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.weETH();
        } else if (chainId == 8453) {
            return BaseMainnet.weETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.weETH();
        } else {
            revert NotFound("Asset for Wrapped eETH not found on chain", chainId);
        }
    }

    /// @dev Staked ETH
    function osETH(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.osETH();
        } else {
            revert NotFound("Asset for Staked ETH not found on chain", chainId);
        }
    }

    /// @dev Renzo Restaked ETH
    function ezETH(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.ezETH();
        } else if (chainId == 8453) {
            return BaseMainnet.ezETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.ezETH();
        } else {
            revert NotFound("Asset for Renzo Restaked ETH not found on chain", chainId);
        }
    }

    /// @dev rswETH
    function rswETH(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.rswETH();
        } else {
            revert NotFound("Asset for rswETH not found on chain", chainId);
        }
    }

    /// @dev ETHx
    function ETHx(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.ETHx();
        } else {
            revert NotFound("Asset for ETHx not found on chain", chainId);
        }
    }

    /// @dev Wrapped Mountain Protocol USD
    function wUSDM(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.wUSDM();
        } else {
            revert NotFound("Asset for Wrapped Mountain Protocol USD not found on chain", chainId);
        }
    }

    /// @dev Staked FRAX
    function sFRAX(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 1) {
            return EthereumMainnet.sFRAX();
        } else {
            revert NotFound("Asset for Staked FRAX not found on chain", chainId);
        }
    }

    /// @dev Aerodrome
    function AERO(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.AERO();
        } else {
            revert NotFound("Asset for Aerodrome not found on chain", chainId);
        }
    }

    /// @dev Degen
    function DEGEN(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.DEGEN();
        } else {
            revert NotFound("Asset for Degen not found on chain", chainId);
        }
    }

    /// @dev Brett
    function BRETT(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.BRETT();
        } else {
            revert NotFound("Asset for Brett not found on chain", chainId);
        }
    }

    /// @dev higher
    function HIGHER(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.HIGHER();
        } else {
            revert NotFound("Asset for higher not found on chain", chainId);
        }
    }

    /// @dev luminous
    function LUM(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.LUM();
        } else {
            revert NotFound("Asset for luminous not found on chain", chainId);
        }
    }

    /// @dev WELL
    function WELL(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.WELL();
        } else {
            revert NotFound("Asset for WELL not found on chain", chainId);
        }
    }

    /// @dev Morpho Token
    function MORPHO(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.MORPHO();
        } else {
            revert NotFound("Asset for Morpho Token not found on chain", chainId);
        }
    }

    /// @dev rsETHWrapper
    function wrsETH(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 8453) {
            return BaseMainnet.wrsETH();
        } else {
            revert NotFound("Asset for rsETHWrapper not found on chain", chainId);
        }
    }

    /// @dev GMX
    function GMX(uint256 chainId) public pure returns (KnownAsset memory) {
        if (chainId == 42161) {
            return ArbitrumMainnet.GMX();
        } else {
            revert NotFound("Asset for GMX not found on chain", chainId);
        }
    }

    /// @dev ETH_USD price feed
    function ETH_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.ETH_USD();
        } else if (chainId == 8453) {
            return BaseMainnet.ETH_USD();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.ETH_USD();
        } else if (chainId == 11155111) {
            return EthereumSepolia.ETH_USD();
        } else if (chainId == 84532) {
            return BaseSepolia.ETH_USD();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.ETH_USD();
        } else {
            revert NotFound("PriceFeed for ETH_USD not found on chain", chainId);
        }
    }

    /// @dev USDC_USD price feed
    function USDC_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.USDC_USD();
        } else if (chainId == 8453) {
            return BaseMainnet.USDC_USD();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.USDC_USD();
        } else if (chainId == 11155111) {
            return EthereumSepolia.USDC_USD();
        } else if (chainId == 84532) {
            return BaseSepolia.USDC_USD();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.USDC_USD();
        } else {
            revert NotFound("PriceFeed for USDC_USD not found on chain", chainId);
        }
    }

    /// @dev sUSDe_USD price feed
    function sUSDe_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.sUSDe_USD();
        } else {
            revert NotFound("PriceFeed for sUSDe_USD not found on chain", chainId);
        }
    }

    /// @dev COMP_USD price feed
    function COMP_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.COMP_USD();
        } else if (chainId == 8453) {
            return BaseMainnet.COMP_USD();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.COMP_USD();
        } else if (chainId == 11155111) {
            return EthereumSepolia.COMP_USD();
        } else if (chainId == 84532) {
            return BaseSepolia.COMP_USD();
        } else {
            revert NotFound("PriceFeed for COMP_USD not found on chain", chainId);
        }
    }

    /// @dev WBTC_USD price feed
    function WBTC_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.WBTC_USD();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.WBTC_USD();
        } else if (chainId == 11155111) {
            return EthereumSepolia.WBTC_USD();
        } else {
            revert NotFound("PriceFeed for WBTC_USD not found on chain", chainId);
        }
    }

    /// @dev WETH_USD price feed
    function WETH_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.WETH_USD();
        } else if (chainId == 8453) {
            return BaseMainnet.WETH_USD();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.WETH_USD();
        } else if (chainId == 11155111) {
            return EthereumSepolia.WETH_USD();
        } else if (chainId == 84532) {
            return BaseSepolia.WETH_USD();
        } else {
            revert NotFound("PriceFeed for WETH_USD not found on chain", chainId);
        }
    }

    /// @dev UNI_USD price feed
    function UNI_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.UNI_USD();
        } else {
            revert NotFound("PriceFeed for UNI_USD not found on chain", chainId);
        }
    }

    /// @dev LINK_USD price feed
    function LINK_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.LINK_USD();
        } else {
            revert NotFound("PriceFeed for LINK_USD not found on chain", chainId);
        }
    }

    /// @dev wstETH_USD price feed
    function wstETH_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.wstETH_USD();
        } else if (chainId == 8453) {
            return BaseMainnet.wstETH_USD();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.wstETH_USD();
        } else {
            revert NotFound("PriceFeed for wstETH_USD not found on chain", chainId);
        }
    }

    /// @dev cbBTC_USD price feed
    function cbBTC_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.cbBTC_USD();
        } else if (chainId == 8453) {
            return BaseMainnet.cbBTC_USD();
        } else {
            revert NotFound("PriceFeed for cbBTC_USD not found on chain", chainId);
        }
    }

    /// @dev tBTC_USD price feed
    function tBTC_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.tBTC_USD();
        } else {
            revert NotFound("PriceFeed for tBTC_USD not found on chain", chainId);
        }
    }

    /// @dev cbETH_WETH price feed
    function cbETH_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.cbETH_WETH();
        } else if (chainId == 8453) {
            return BaseMainnet.cbETH_WETH();
        } else if (chainId == 11155111) {
            return EthereumSepolia.cbETH_WETH();
        } else if (chainId == 84532) {
            return BaseSepolia.cbETH_WETH();
        } else {
            revert NotFound("PriceFeed for cbETH_WETH not found on chain", chainId);
        }
    }

    /// @dev wstETH_WETH price feed
    function wstETH_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.wstETH_WETH();
        } else if (chainId == 8453) {
            return BaseMainnet.wstETH_WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.wstETH_WETH();
        } else if (chainId == 11155111) {
            return EthereumSepolia.wstETH_WETH();
        } else {
            revert NotFound("PriceFeed for wstETH_WETH not found on chain", chainId);
        }
    }

    /// @dev rETH_WETH price feed
    function rETH_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.rETH_WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.rETH_WETH();
        } else {
            revert NotFound("PriceFeed for rETH_WETH not found on chain", chainId);
        }
    }

    /// @dev rsETH_WETH price feed
    function rsETH_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.rsETH_WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.rsETH_WETH();
        } else {
            revert NotFound("PriceFeed for rsETH_WETH not found on chain", chainId);
        }
    }

    /// @dev weETH_WETH price feed
    function weETH_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.weETH_WETH();
        } else if (chainId == 8453) {
            return BaseMainnet.weETH_WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.weETH_WETH();
        } else {
            revert NotFound("PriceFeed for weETH_WETH not found on chain", chainId);
        }
    }

    /// @dev osETH_WETH price feed
    function osETH_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.osETH_WETH();
        } else {
            revert NotFound("PriceFeed for osETH_WETH not found on chain", chainId);
        }
    }

    /// @dev WBTC_WETH price feed
    function WBTC_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.WBTC_WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.WBTC_WETH();
        } else {
            revert NotFound("PriceFeed for WBTC_WETH not found on chain", chainId);
        }
    }

    /// @dev ezETH_WETH price feed
    function ezETH_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.ezETH_WETH();
        } else if (chainId == 8453) {
            return BaseMainnet.ezETH_WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.ezETH_WETH();
        } else {
            revert NotFound("PriceFeed for ezETH_WETH not found on chain", chainId);
        }
    }

    /// @dev cbBTC_WETH price feed
    function cbBTC_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.cbBTC_WETH();
        } else if (chainId == 8453) {
            return BaseMainnet.cbBTC_WETH();
        } else {
            revert NotFound("PriceFeed for cbBTC_WETH not found on chain", chainId);
        }
    }

    /// @dev rswETH_WETH price feed
    function rswETH_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.rswETH_WETH();
        } else {
            revert NotFound("PriceFeed for rswETH_WETH not found on chain", chainId);
        }
    }

    /// @dev tBTC_WETH price feed
    function tBTC_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.tBTC_WETH();
        } else {
            revert NotFound("PriceFeed for tBTC_WETH not found on chain", chainId);
        }
    }

    /// @dev ETHx_WETH price feed
    function ETHx_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.ETHx_WETH();
        } else {
            revert NotFound("PriceFeed for ETHx_WETH not found on chain", chainId);
        }
    }

    /// @dev USDT_USD price feed
    function USDT_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.USDT_USD();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.USDT_USD();
        } else {
            revert NotFound("PriceFeed for USDT_USD not found on chain", chainId);
        }
    }

    /// @dev COMP_USDT price feed
    function COMP_USDT(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.COMP_USDT();
        } else {
            revert NotFound("PriceFeed for COMP_USDT not found on chain", chainId);
        }
    }

    /// @dev WETH_USDT price feed
    function WETH_USDT(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.WETH_USDT();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.WETH_USDT();
        } else {
            revert NotFound("PriceFeed for WETH_USDT not found on chain", chainId);
        }
    }

    /// @dev WBTC_USDT price feed
    function WBTC_USDT(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.WBTC_USDT();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.WBTC_USDT();
        } else {
            revert NotFound("PriceFeed for WBTC_USDT not found on chain", chainId);
        }
    }

    /// @dev UNI_USDT price feed
    function UNI_USDT(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.UNI_USDT();
        } else {
            revert NotFound("PriceFeed for UNI_USDT not found on chain", chainId);
        }
    }

    /// @dev LINK_USDT price feed
    function LINK_USDT(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.LINK_USDT();
        } else {
            revert NotFound("PriceFeed for LINK_USDT not found on chain", chainId);
        }
    }

    /// @dev wstETH_USDT price feed
    function wstETH_USDT(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.wstETH_USDT();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.wstETH_USDT();
        } else {
            revert NotFound("PriceFeed for wstETH_USDT not found on chain", chainId);
        }
    }

    /// @dev cbBTC_USDT price feed
    function cbBTC_USDT(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.cbBTC_USDT();
        } else {
            revert NotFound("PriceFeed for cbBTC_USDT not found on chain", chainId);
        }
    }

    /// @dev tBTC_USDT price feed
    function tBTC_USDT(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.tBTC_USDT();
        } else {
            revert NotFound("PriceFeed for tBTC_USDT not found on chain", chainId);
        }
    }

    /// @dev wUSDM_USDT price feed
    function wUSDM_USDT(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.wUSDM_USDT();
        } else {
            revert NotFound("PriceFeed for wUSDM_USDT not found on chain", chainId);
        }
    }

    /// @dev sFRAX_USDT price feed
    function sFRAX_USDT(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 1) {
            return EthereumMainnet.sFRAX_USDT();
        } else {
            revert NotFound("PriceFeed for sFRAX_USDT not found on chain", chainId);
        }
    }

    /// @dev wstETH_ETH price feed
    function wstETH_ETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 8453) {
            return BaseMainnet.wstETH_ETH();
        } else {
            revert NotFound("PriceFeed for wstETH_ETH not found on chain", chainId);
        }
    }

    /// @dev cbETH_USD price feed
    function cbETH_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 8453) {
            return BaseMainnet.cbETH_USD();
        } else if (chainId == 84532) {
            return BaseSepolia.cbETH_USD();
        } else {
            revert NotFound("PriceFeed for cbETH_USD not found on chain", chainId);
        }
    }

    /// @dev USDC_WETH price feed
    function USDC_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 8453) {
            return BaseMainnet.USDC_WETH();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.USDC_WETH();
        } else {
            revert NotFound("PriceFeed for USDC_WETH not found on chain", chainId);
        }
    }

    /// @dev wrsETH_WETH price feed
    function wrsETH_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 8453) {
            return BaseMainnet.wrsETH_WETH();
        } else {
            revert NotFound("PriceFeed for wrsETH_WETH not found on chain", chainId);
        }
    }

    /// @dev ARB_USD price feed
    function ARB_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 42161) {
            return ArbitrumMainnet.ARB_USD();
        } else {
            revert NotFound("PriceFeed for ARB_USD not found on chain", chainId);
        }
    }

    /// @dev GMX_USD price feed
    function GMX_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 42161) {
            return ArbitrumMainnet.GMX_USD();
        } else {
            revert NotFound("PriceFeed for GMX_USD not found on chain", chainId);
        }
    }

    /// @dev ezETH_USD price feed
    function ezETH_USD(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 42161) {
            return ArbitrumMainnet.ezETH_USD();
        } else {
            revert NotFound("PriceFeed for ezETH_USD not found on chain", chainId);
        }
    }

    /// @dev ARB_USDT price feed
    function ARB_USDT(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 42161) {
            return ArbitrumMainnet.ARB_USDT();
        } else {
            revert NotFound("PriceFeed for ARB_USDT not found on chain", chainId);
        }
    }

    /// @dev GMX_USDT price feed
    function GMX_USDT(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 42161) {
            return ArbitrumMainnet.GMX_USDT();
        } else {
            revert NotFound("PriceFeed for GMX_USDT not found on chain", chainId);
        }
    }

    /// @dev USDT_WETH price feed
    function USDT_WETH(uint256 chainId) public pure returns (KnownPriceFeed memory) {
        if (chainId == 42161) {
            return ArbitrumMainnet.USDT_WETH();
        } else {
            revert NotFound("PriceFeed for USDT_WETH not found on chain", chainId);
        }
    }

    /// @dev Compound USDC
    function Comet_cUSDCv3(uint256 chainId) public pure returns (KnownComet memory) {
        if (chainId == 1) {
            return EthereumMainnet.Comet_cUSDCv3();
        } else if (chainId == 8453) {
            return BaseMainnet.Comet_cUSDCv3();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.Comet_cUSDCv3();
        } else if (chainId == 11155111) {
            return EthereumSepolia.Comet_cUSDCv3();
        } else if (chainId == 84532) {
            return BaseSepolia.Comet_cUSDCv3();
        } else {
            revert NotFound("Comet for cUSDCv3 not found on chain", chainId);
        }
    }

    /// @dev Compound WETH
    function Comet_cWETHv3(uint256 chainId) public pure returns (KnownComet memory) {
        if (chainId == 1) {
            return EthereumMainnet.Comet_cWETHv3();
        } else if (chainId == 8453) {
            return BaseMainnet.Comet_cWETHv3();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.Comet_cWETHv3();
        } else if (chainId == 11155111) {
            return EthereumSepolia.Comet_cWETHv3();
        } else if (chainId == 84532) {
            return BaseSepolia.Comet_cWETHv3();
        } else {
            revert NotFound("Comet for cWETHv3 not found on chain", chainId);
        }
    }

    /// @dev Compound USDT
    function Comet_cUSDTv3(uint256 chainId) public pure returns (KnownComet memory) {
        if (chainId == 1) {
            return EthereumMainnet.Comet_cUSDTv3();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.Comet_cUSDTv3();
        } else {
            revert NotFound("Comet for cUSDTv3 not found on chain", chainId);
        }
    }

    /// @dev All known assets, by chain id
    function knownAssets(uint256 chainId) public pure returns (KnownAsset[] memory) {
        if (chainId == 1) {
            return EthereumMainnet.knownAssets();
        } else if (chainId == 8453) {
            return BaseMainnet.knownAssets();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.knownAssets();
        } else if (chainId == 11155111) {
            return EthereumSepolia.knownAssets();
        } else if (chainId == 84532) {
            return BaseSepolia.knownAssets();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.knownAssets();
        } else {
            revert NotFound("Network not found for chain id", chainId);
        }
    }

    /// @dev All known price feeds, by chain id
    function knownPriceFeeds(uint256 chainId) public pure returns (KnownPriceFeed[] memory) {
        if (chainId == 1) {
            return EthereumMainnet.knownPriceFeeds();
        } else if (chainId == 8453) {
            return BaseMainnet.knownPriceFeeds();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.knownPriceFeeds();
        } else if (chainId == 11155111) {
            return EthereumSepolia.knownPriceFeeds();
        } else if (chainId == 84532) {
            return BaseSepolia.knownPriceFeeds();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.knownPriceFeeds();
        } else {
            revert NotFound("Network not found for chain id", chainId);
        }
    }

    /// @dev All known comets, by chain id
    function knownComets(uint256 chainId) public pure returns (KnownComet[] memory) {
        if (chainId == 1) {
            return EthereumMainnet.knownComets();
        } else if (chainId == 8453) {
            return BaseMainnet.knownComets();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.knownComets();
        } else if (chainId == 11155111) {
            return EthereumSepolia.knownComets();
        } else if (chainId == 84532) {
            return BaseSepolia.knownComets();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.knownComets();
        } else {
            revert NotFound("Network not found for chain id", chainId);
        }
    }

    /// @dev Big burrito, by chain id
    function knownNetwork(uint256 chainId) public pure returns (KnownNetwork memory) {
        if (chainId == 1) {
            return EthereumMainnet.knownNetwork();
        } else if (chainId == 8453) {
            return BaseMainnet.knownNetwork();
        } else if (chainId == 42161) {
            return ArbitrumMainnet.knownNetwork();
        } else if (chainId == 11155111) {
            return EthereumSepolia.knownNetwork();
        } else if (chainId == 84532) {
            return BaseSepolia.knownNetwork();
        } else if (chainId == 421614) {
            return ArbitrumSepolia.knownNetwork();
        } else {
            revert NotFound("Network not found for chain id", chainId);
        }
    }
}

contract EthereumMainnetContract {
    /// @dev KnownAsset constructors

    /// @dev EthereumMainnet Ether
    function ETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Ether",
            symbol: "ETH",
            decimals: 18,
            assetAddress: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        });
    }

    /// @dev EthereumMainnet USD Coin
    function USDC() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "USD Coin",
            symbol: "USDC",
            decimals: 6,
            assetAddress: 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
        });
    }

    /// @dev EthereumMainnet Dai Stablecoin
    function DAI() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Dai Stablecoin",
            symbol: "DAI",
            decimals: 18,
            assetAddress: 0x6B175474E89094C44Da98b954EedeAC495271d0F
        });
    }

    /// @dev EthereumMainnet Tether USD
    function USDT() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Tether USD",
            symbol: "USDT",
            decimals: 6,
            assetAddress: 0xdAC17F958D2ee523a2206206994597C13D831ec7
        });
    }

    /// @dev EthereumMainnet Frax
    function FRAX() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Frax",
            symbol: "FRAX",
            decimals: 18,
            assetAddress: 0x853d955aCEf822Db058eb8505911ED77F175b99e
        });
    }

    /// @dev EthereumMainnet USDe
    function USDe() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "USDe",
            symbol: "USDe",
            decimals: 18,
            assetAddress: 0x4c9EDD5852cd905f086C759E8383e09bff1E68B3
        });
    }

    /// @dev EthereumMainnet Arbitrum
    function ARB() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Arbitrum",
            symbol: "ARB",
            decimals: 18,
            assetAddress: 0xB50721BCf8d664c30412Cfbc6cf7a15145234ad1
        });
    }

    /// @dev EthereumMainnet Blur
    function BLUR() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Blur",
            symbol: "BLUR",
            decimals: 18,
            assetAddress: 0x5283D291DBCF85356A21bA090E6db59121208b44
        });
    }

    /// @dev EthereumMainnet Curve DAO Token
    function CRV() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Curve DAO Token",
            symbol: "CRV",
            decimals: 18,
            assetAddress: 0xD533a949740bb3306d119CC777fa900bA034cd52
        });
    }

    /// @dev EthereumMainnet ENA
    function ENA() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "ENA",
            symbol: "ENA",
            decimals: 18,
            assetAddress: 0x57e114B691Db790C35207b2e685D4A43181e6061
        });
    }

    /// @dev EthereumMainnet Lido DAO Token
    function LDO() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Lido DAO Token",
            symbol: "LDO",
            decimals: 18,
            assetAddress: 0x5A98FcBEA516Cf06857215779Fd812CA3beF1B32
        });
    }

    /// @dev EthereumMainnet Pendle
    function PENDLE() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Pendle",
            symbol: "PENDLE",
            decimals: 18,
            assetAddress: 0x808507121B80c02388fAd14726482e061B8da827
        });
    }

    /// @dev EthereumMainnet Pepe
    function PEPE() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Pepe",
            symbol: "PEPE",
            decimals: 18,
            assetAddress: 0x6982508145454Ce325dDbE47a25d4ec3d2311933
        });
    }

    /// @dev EthereumMainnet Rocket Pool Protocol
    function RPL() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Rocket Pool Protocol",
            symbol: "RPL",
            decimals: 18,
            assetAddress: 0xD33526068D116cE69F19A9ee46F0bd304F21A51f
        });
    }

    /// @dev EthereumMainnet SHIBA INU
    function SHIB() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "SHIBA INU",
            symbol: "SHIB",
            decimals: 18,
            assetAddress: 0x95aD61b0a150d79219dCF64E1E6Cc01f0B64C4cE
        });
    }

    /// @dev EthereumMainnet Compound
    function COMP() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Compound",
            symbol: "COMP",
            decimals: 18,
            assetAddress: 0xc00e94Cb662C3520282E6f5717214004A7f26888
        });
    }

    /// @dev EthereumMainnet Wrapped BTC
    function WBTC() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped BTC",
            symbol: "WBTC",
            decimals: 8,
            assetAddress: 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599
        });
    }

    /// @dev EthereumMainnet Wrapped Ether
    function WETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped Ether",
            symbol: "WETH",
            decimals: 18,
            assetAddress: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2
        });
    }

    /// @dev EthereumMainnet Uniswap
    function UNI() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Uniswap",
            symbol: "UNI",
            decimals: 18,
            assetAddress: 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
        });
    }

    /// @dev EthereumMainnet ChainLink Token
    function LINK() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "ChainLink Token",
            symbol: "LINK",
            decimals: 18,
            assetAddress: 0x514910771AF9Ca656af840dff83E8264EcF986CA
        });
    }

    /// @dev EthereumMainnet Wrapped liquid staked Ether 2.0
    function wstETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped liquid staked Ether 2.0",
            symbol: "wstETH",
            decimals: 18,
            assetAddress: 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0
        });
    }

    /// @dev EthereumMainnet Coinbase Wrapped BTC
    function cbBTC() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Coinbase Wrapped BTC",
            symbol: "cbBTC",
            decimals: 8,
            assetAddress: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf
        });
    }

    /// @dev EthereumMainnet tBTC v2
    function tBTC() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "tBTC v2",
            symbol: "tBTC",
            decimals: 18,
            assetAddress: 0x18084fbA666a33d37592fA2633fD49a74DD93a88
        });
    }

    /// @dev EthereumMainnet Coinbase Wrapped Staked ETH
    function cbETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Coinbase Wrapped Staked ETH",
            symbol: "cbETH",
            decimals: 18,
            assetAddress: 0xBe9895146f7AF43049ca1c1AE358B0541Ea49704
        });
    }

    /// @dev EthereumMainnet Rocket Pool ETH
    function rETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Rocket Pool ETH",
            symbol: "rETH",
            decimals: 18,
            assetAddress: 0xae78736Cd615f374D3085123A210448E74Fc6393
        });
    }

    /// @dev EthereumMainnet rsETH
    function rsETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "rsETH",
            symbol: "rsETH",
            decimals: 18,
            assetAddress: 0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7
        });
    }

    /// @dev EthereumMainnet Wrapped eETH
    function weETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped eETH",
            symbol: "weETH",
            decimals: 18,
            assetAddress: 0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee
        });
    }

    /// @dev EthereumMainnet Staked ETH
    function osETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Staked ETH",
            symbol: "osETH",
            decimals: 18,
            assetAddress: 0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38
        });
    }

    /// @dev EthereumMainnet Renzo Restaked ETH
    function ezETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Renzo Restaked ETH",
            symbol: "ezETH",
            decimals: 18,
            assetAddress: 0xbf5495Efe5DB9ce00f80364C8B423567e58d2110
        });
    }

    /// @dev EthereumMainnet rswETH
    function rswETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "rswETH",
            symbol: "rswETH",
            decimals: 18,
            assetAddress: 0xFAe103DC9cf190eD75350761e95403b7b8aFa6c0
        });
    }

    /// @dev EthereumMainnet ETHx
    function ETHx() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "ETHx",
            symbol: "ETHx",
            decimals: 18,
            assetAddress: 0xA35b1B31Ce002FBF2058D22F30f95D405200A15b
        });
    }

    /// @dev EthereumMainnet Wrapped Mountain Protocol USD
    function wUSDM() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped Mountain Protocol USD",
            symbol: "wUSDM",
            decimals: 18,
            assetAddress: 0x57F5E098CaD7A3D1Eed53991D4d66C45C9AF7812
        });
    }

    /// @dev EthereumMainnet Staked FRAX
    function sFRAX() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Staked FRAX",
            symbol: "sFRAX",
            decimals: 18,
            assetAddress: 0xA663B02CF0a4b149d2aD41910CB81e23e1c41c32
        });
    }

    /// @dev KnownPriceFeed constructors

    /// @dev EthereumMainnet ETH_USD price feed
    function ETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
    }

    /// @dev EthereumMainnet USDC_USD price feed
    function USDC_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6
        });
    }

    /// @dev EthereumMainnet sUSDe_USD price feed
    function sUSDe_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "sUSDe",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xFF3BC18cCBd5999CE63E788A1c250a88626aD099
        });
    }

    /// @dev EthereumMainnet COMP_USD price feed
    function COMP_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "COMP",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5
        });
    }

    /// @dev EthereumMainnet WBTC_USD price feed
    function WBTC_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WBTC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c
        });
    }

    /// @dev EthereumMainnet WETH_USD price feed
    function WETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
    }

    /// @dev EthereumMainnet UNI_USD price feed
    function UNI_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "UNI",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x553303d460EE0afB37EdFf9bE42922D8FF63220e
        });
    }

    /// @dev EthereumMainnet LINK_USD price feed
    function LINK_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "LINK",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c
        });
    }

    /// @dev EthereumMainnet wstETH_USD price feed
    function wstETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x023ee795361B28cDbB94e302983578486A0A5f1B
        });
    }

    /// @dev EthereumMainnet cbBTC_USD price feed
    function cbBTC_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbBTC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x0A4F4F9E84Fc4F674F0D209f94d41FaFE5aF887D
        });
    }

    /// @dev EthereumMainnet tBTC_USD price feed
    function tBTC_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "tBTC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xAA9527bf3183A96fe6e55831c96dE5cd988d3484
        });
    }

    /// @dev EthereumMainnet cbETH_WETH price feed
    function cbETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x23a982b74a3236A5F2297856d4391B2edBBB5549
        });
    }

    /// @dev EthereumMainnet wstETH_WETH price feed
    function wstETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x4F67e4d9BD67eFa28236013288737D39AeF48e79
        });
    }

    /// @dev EthereumMainnet rETH_WETH price feed
    function rETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "rETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xA3A7fB5963D1d69B95EEC4957f77678EF073Ba08
        });
    }

    /// @dev EthereumMainnet rsETH_WETH price feed
    function rsETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "rsETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xFa454dE61b317b6535A0C462267208E8FdB89f45
        });
    }

    /// @dev EthereumMainnet weETH_WETH price feed
    function weETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "weETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x1Ad4CEBa9f8135A557bBe317DB62Aa125C330F26
        });
    }

    /// @dev EthereumMainnet osETH_WETH price feed
    function osETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "osETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x66F5AfDaD14b30816b47b707240D1E8E3344D04d
        });
    }

    /// @dev EthereumMainnet WBTC_WETH price feed
    function WBTC_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WBTC",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xd98Be00b5D27fc98112BdE293e487f8D4cA57d07
        });
    }

    /// @dev EthereumMainnet ezETH_WETH price feed
    function ezETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ezETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xdE43600De5016B50752cc2615332d8cCBED6EC1b
        });
    }

    /// @dev EthereumMainnet cbBTC_WETH price feed
    function cbBTC_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbBTC",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x57A71A9C632b2e6D8b0eB9A157888A3Fc87400D1
        });
    }

    /// @dev EthereumMainnet rswETH_WETH price feed
    function rswETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "rswETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xDd18688Bb75Af704f3Fb1183e459C4d4D41132D9
        });
    }

    /// @dev EthereumMainnet tBTC_WETH price feed
    function tBTC_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "tBTC",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x1933F7e5f8B0423fbAb28cE9c8C39C2cC414027B
        });
    }

    /// @dev EthereumMainnet ETHx_WETH price feed
    function ETHx_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ETHx",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x9F2F60f38BBc275aF8F88a21c0e2BfE751E97C1f
        });
    }

    /// @dev EthereumMainnet USDT_USD price feed
    function USDT_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDT",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D
        });
    }

    /// @dev EthereumMainnet COMP_USDT price feed
    function COMP_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "COMP",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5
        });
    }

    /// @dev EthereumMainnet WETH_USDT price feed
    function WETH_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WETH",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
    }

    /// @dev EthereumMainnet WBTC_USDT price feed
    function WBTC_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WBTC",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x4E64E54c9f0313852a230782B3ba4B3B0952B499
        });
    }

    /// @dev EthereumMainnet UNI_USDT price feed
    function UNI_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "UNI",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x553303d460EE0afB37EdFf9bE42922D8FF63220e
        });
    }

    /// @dev EthereumMainnet LINK_USDT price feed
    function LINK_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "LINK",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c
        });
    }

    /// @dev EthereumMainnet wstETH_USDT price feed
    function wstETH_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x023ee795361B28cDbB94e302983578486A0A5f1B
        });
    }

    /// @dev EthereumMainnet cbBTC_USDT price feed
    function cbBTC_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbBTC",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x2D09142Eae60Fd8BD454a276E95AeBdFFD05722d
        });
    }

    /// @dev EthereumMainnet tBTC_USDT price feed
    function tBTC_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "tBTC",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x7b03a016dBC36dB8e05C480192faDcdB0a06bC37
        });
    }

    /// @dev EthereumMainnet wUSDM_USDT price feed
    function wUSDM_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wUSDM",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0xe3a409eD15CD53aFdEFdd191ad945cEC528A2496
        });
    }

    /// @dev EthereumMainnet sFRAX_USDT price feed
    function sFRAX_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "sFRAX",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x403F2083B6E220147f8a8832f0B284B4Ed5777d1
        });
    }

    /// @dev KnownComet constructors

    /// @dev EthereumMainnet Compound USDC
    function Comet_cUSDCv3() public pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](8);

        collaterals[0] = KnownCometCollateral({
            asset: 0xc00e94Cb662C3520282E6f5717214004A7f26888,
            supplyCap: 100000000000000000000000,
            priceFeed: 0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5,
            liquidationFactor: 7.5e17,
            borrowCollateralFactor: 5e17,
            liquidateCollateralFactor: 7e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599,
            supplyCap: 1000000000000,
            priceFeed: 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,
            supplyCap: 500000000000000000000000,
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.25e17,
            liquidateCollateralFactor: 8.95e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984,
            supplyCap: 2600000000000000000000000,
            priceFeed: 0x553303d460EE0afB37EdFf9bE42922D8FF63220e,
            liquidationFactor: 8.3e17,
            borrowCollateralFactor: 6.8e17,
            liquidateCollateralFactor: 7.4e17
        });

        collaterals[4] = KnownCometCollateral({
            asset: 0x514910771AF9Ca656af840dff83E8264EcF986CA,
            supplyCap: 1000000000000000000000000,
            priceFeed: 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c,
            liquidationFactor: 8.3e17,
            borrowCollateralFactor: 7.3e17,
            liquidateCollateralFactor: 7.9e17
        });

        collaterals[5] = KnownCometCollateral({
            asset: 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0,
            supplyCap: 40000000000000000000000,
            priceFeed: 0x023ee795361B28cDbB94e302983578486A0A5f1B,
            liquidationFactor: 9.2e17,
            borrowCollateralFactor: 8.2e17,
            liquidateCollateralFactor: 8.7e17
        });

        collaterals[6] = KnownCometCollateral({
            asset: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf,
            supplyCap: 9300000000,
            priceFeed: 0x0A4F4F9E84Fc4F674F0D209f94d41FaFE5aF887D,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[7] = KnownCometCollateral({
            asset: 0x18084fbA666a33d37592fA2633fD49a74DD93a88,
            supplyCap: 285000000000000000000,
            priceFeed: 0xAA9527bf3183A96fe6e55831c96dE5cd988d3484,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 7.6e17,
            liquidateCollateralFactor: 8.1e17
        });

        return KnownComet({
            name: "Compound USDC",
            symbol: "cUSDCv3",
            cometAddress: 0xc3d688B66703497DAA19211EEdff47f25384cdc3,
            rewardsAddress: 0x1B0e765F6224C21223AeA2af16c1C46E38885a40,
            factorScale: 1e18,
            baseAsset: 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48,
            collateralAssets: collaterals
        });
    }

    /// @dev EthereumMainnet Compound WETH
    function Comet_cWETHv3() public pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](12);

        collaterals[0] = KnownCometCollateral({
            asset: 0xBe9895146f7AF43049ca1c1AE358B0541Ea49704,
            supplyCap: 10000000000000000000000,
            priceFeed: 0x23a982b74a3236A5F2297856d4391B2edBBB5549,
            liquidationFactor: 9.75e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0,
            supplyCap: 64500000000000000000000,
            priceFeed: 0x4F67e4d9BD67eFa28236013288737D39AeF48e79,
            liquidationFactor: 9.75e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0xae78736Cd615f374D3085123A210448E74Fc6393,
            supplyCap: 30000000000000000000000,
            priceFeed: 0xA3A7fB5963D1d69B95EEC4957f77678EF073Ba08,
            liquidationFactor: 9.75e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7,
            supplyCap: 37000000000000000000000,
            priceFeed: 0xFa454dE61b317b6535A0C462267208E8FdB89f45,
            liquidationFactor: 9.6e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9.1e17
        });

        collaterals[4] = KnownCometCollateral({
            asset: 0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee,
            supplyCap: 22500000000000000000000,
            priceFeed: 0x1Ad4CEBa9f8135A557bBe317DB62Aa125C330F26,
            liquidationFactor: 9.6e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[5] = KnownCometCollateral({
            asset: 0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38,
            supplyCap: 10000000000000000000000,
            priceFeed: 0x66F5AfDaD14b30816b47b707240D1E8E3344D04d,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[6] = KnownCometCollateral({
            asset: 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599,
            supplyCap: 100000000000,
            priceFeed: 0xd98Be00b5D27fc98112BdE293e487f8D4cA57d07,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[7] = KnownCometCollateral({
            asset: 0xbf5495Efe5DB9ce00f80364C8B423567e58d2110,
            supplyCap: 80000000000000000000000,
            priceFeed: 0xdE43600De5016B50752cc2615332d8cCBED6EC1b,
            liquidationFactor: 9.4e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9.1e17
        });

        collaterals[8] = KnownCometCollateral({
            asset: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf,
            supplyCap: 9300000000,
            priceFeed: 0x57A71A9C632b2e6D8b0eB9A157888A3Fc87400D1,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[9] = KnownCometCollateral({
            asset: 0xFAe103DC9cf190eD75350761e95403b7b8aFa6c0,
            supplyCap: 1000000000000000000000,
            priceFeed: 0xDd18688Bb75Af704f3Fb1183e459C4d4D41132D9,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[10] = KnownCometCollateral({
            asset: 0x18084fbA666a33d37592fA2633fD49a74DD93a88,
            supplyCap: 315000000000000000000,
            priceFeed: 0x1933F7e5f8B0423fbAb28cE9c8C39C2cC414027B,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 7.6e17,
            liquidateCollateralFactor: 8.1e17
        });

        collaterals[11] = KnownCometCollateral({
            asset: 0xA35b1B31Ce002FBF2058D22F30f95D405200A15b,
            supplyCap: 2100000000000000000000,
            priceFeed: 0x9F2F60f38BBc275aF8F88a21c0e2BfE751E97C1f,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.5e17,
            liquidateCollateralFactor: 9e17
        });

        return KnownComet({
            name: "Compound WETH",
            symbol: "cWETHv3",
            cometAddress: 0xA17581A9E3356d9A858b789D68B4d866e593aE94,
            rewardsAddress: 0x1B0e765F6224C21223AeA2af16c1C46E38885a40,
            factorScale: 1e18,
            baseAsset: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,
            collateralAssets: collaterals
        });
    }

    /// @dev EthereumMainnet Compound USDT
    function Comet_cUSDTv3() public pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](10);

        collaterals[0] = KnownCometCollateral({
            asset: 0xc00e94Cb662C3520282E6f5717214004A7f26888,
            supplyCap: 100000000000000000000000,
            priceFeed: 0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5,
            liquidationFactor: 7.5e17,
            borrowCollateralFactor: 5e17,
            liquidateCollateralFactor: 7e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,
            supplyCap: 500000000000000000000000,
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.3e17,
            liquidateCollateralFactor: 9e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599,
            supplyCap: 140000000000,
            priceFeed: 0x4E64E54c9f0313852a230782B3ba4B3B0952B499,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984,
            supplyCap: 1300000000000000000000000,
            priceFeed: 0x553303d460EE0afB37EdFf9bE42922D8FF63220e,
            liquidationFactor: 8.3e17,
            borrowCollateralFactor: 6.8e17,
            liquidateCollateralFactor: 7.4e17
        });

        collaterals[4] = KnownCometCollateral({
            asset: 0x514910771AF9Ca656af840dff83E8264EcF986CA,
            supplyCap: 500000000000000000000000,
            priceFeed: 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c,
            liquidationFactor: 8.3e17,
            borrowCollateralFactor: 7.3e17,
            liquidateCollateralFactor: 7.9e17
        });

        collaterals[5] = KnownCometCollateral({
            asset: 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0,
            supplyCap: 45000000000000000000000,
            priceFeed: 0x023ee795361B28cDbB94e302983578486A0A5f1B,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[6] = KnownCometCollateral({
            asset: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf,
            supplyCap: 9300000000,
            priceFeed: 0x2D09142Eae60Fd8BD454a276E95AeBdFFD05722d,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[7] = KnownCometCollateral({
            asset: 0x18084fbA666a33d37592fA2633fD49a74DD93a88,
            supplyCap: 285000000000000000000,
            priceFeed: 0x7b03a016dBC36dB8e05C480192faDcdB0a06bC37,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 7.6e17,
            liquidateCollateralFactor: 8.1e17
        });

        collaterals[8] = KnownCometCollateral({
            asset: 0x57F5E098CaD7A3D1Eed53991D4d66C45C9AF7812,
            supplyCap: 6500000000000000000000000,
            priceFeed: 0xe3a409eD15CD53aFdEFdd191ad945cEC528A2496,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9e17
        });

        collaterals[9] = KnownCometCollateral({
            asset: 0xA663B02CF0a4b149d2aD41910CB81e23e1c41c32,
            supplyCap: 10000000000000000000000000,
            priceFeed: 0x403F2083B6E220147f8a8832f0B284B4Ed5777d1,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9e17
        });

        return KnownComet({
            name: "Compound USDT",
            symbol: "cUSDTv3",
            cometAddress: 0x3Afdc9BCA9213A35503b077a6072F3D0d5AB0840,
            rewardsAddress: 0x1B0e765F6224C21223AeA2af16c1C46E38885a40,
            factorScale: 1e18,
            baseAsset: 0xdAC17F958D2ee523a2206206994597C13D831ec7,
            collateralAssets: collaterals
        });
    }

    /// @dev All EthereumMainnet known assets
    function knownAssets() public pure returns (KnownAsset[] memory) {
        KnownAsset[] memory assets = new KnownAsset[](33);
        assets[0] = ETH();
        assets[1] = USDC();
        assets[2] = DAI();
        assets[3] = USDT();
        assets[4] = FRAX();
        assets[5] = USDe();
        assets[6] = ARB();
        assets[7] = BLUR();
        assets[8] = CRV();
        assets[9] = ENA();
        assets[10] = LDO();
        assets[11] = PENDLE();
        assets[12] = PEPE();
        assets[13] = RPL();
        assets[14] = SHIB();
        assets[15] = COMP();
        assets[16] = WBTC();
        assets[17] = WETH();
        assets[18] = UNI();
        assets[19] = LINK();
        assets[20] = wstETH();
        assets[21] = cbBTC();
        assets[22] = tBTC();
        assets[23] = cbETH();
        assets[24] = rETH();
        assets[25] = rsETH();
        assets[26] = weETH();
        assets[27] = osETH();
        assets[28] = ezETH();
        assets[29] = rswETH();
        assets[30] = ETHx();
        assets[31] = wUSDM();
        assets[32] = sFRAX();
        return assets;
    }

    /// @dev All EthereumMainnet known price feeds
    function knownPriceFeeds() public pure returns (KnownPriceFeed[] memory) {
        KnownPriceFeed[] memory priceFeeds = new KnownPriceFeed[](34);
        priceFeeds[0] = ETH_USD();
        priceFeeds[1] = USDC_USD();
        priceFeeds[2] = sUSDe_USD();
        priceFeeds[3] = COMP_USD();
        priceFeeds[4] = WBTC_USD();
        priceFeeds[5] = WETH_USD();
        priceFeeds[6] = UNI_USD();
        priceFeeds[7] = LINK_USD();
        priceFeeds[8] = wstETH_USD();
        priceFeeds[9] = cbBTC_USD();
        priceFeeds[10] = tBTC_USD();
        priceFeeds[11] = cbETH_WETH();
        priceFeeds[12] = wstETH_WETH();
        priceFeeds[13] = rETH_WETH();
        priceFeeds[14] = rsETH_WETH();
        priceFeeds[15] = weETH_WETH();
        priceFeeds[16] = osETH_WETH();
        priceFeeds[17] = WBTC_WETH();
        priceFeeds[18] = ezETH_WETH();
        priceFeeds[19] = cbBTC_WETH();
        priceFeeds[20] = rswETH_WETH();
        priceFeeds[21] = tBTC_WETH();
        priceFeeds[22] = ETHx_WETH();
        priceFeeds[23] = USDT_USD();
        priceFeeds[24] = COMP_USDT();
        priceFeeds[25] = WETH_USDT();
        priceFeeds[26] = WBTC_USDT();
        priceFeeds[27] = UNI_USDT();
        priceFeeds[28] = LINK_USDT();
        priceFeeds[29] = wstETH_USDT();
        priceFeeds[30] = cbBTC_USDT();
        priceFeeds[31] = tBTC_USDT();
        priceFeeds[32] = wUSDM_USDT();
        priceFeeds[33] = sFRAX_USDT();
        return priceFeeds;
    }

    /// @dev All EthereumMainnet known comets
    function knownComets() public pure returns (KnownComet[] memory) {
        KnownComet[] memory comets = new KnownComet[](3);
        comets[0] = Comet_cUSDCv3();
        comets[1] = Comet_cWETHv3();
        comets[2] = Comet_cUSDTv3();
        return comets;
    }

    /// @dev The big EthereumMainnet burrito
    function knownNetwork() public pure returns (KnownNetwork memory) {
        return KnownNetwork({
            chainId: 1,
            isTestnet: false,
            assets: knownAssets(),
            comets: knownComets(),
            priceFeeds: knownPriceFeeds()
        });
    }
}

contract BaseMainnetContract {
    /// @dev KnownAsset constructors

    /// @dev BaseMainnet Ether
    function ETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Ether",
            symbol: "ETH",
            decimals: 18,
            assetAddress: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        });
    }

    /// @dev BaseMainnet USD Coin
    function USDC() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "USD Coin",
            symbol: "USDC",
            decimals: 6,
            assetAddress: 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
        });
    }

    /// @dev BaseMainnet Aerodrome
    function AERO() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Aerodrome",
            symbol: "AERO",
            decimals: 18,
            assetAddress: 0x940181a94A35A4569E4529A3CDfB74e38FD98631
        });
    }

    /// @dev BaseMainnet Degen
    function DEGEN() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Degen",
            symbol: "DEGEN",
            decimals: 18,
            assetAddress: 0x4ed4E862860beD51a9570b96d89aF5E1B0Efefed
        });
    }

    /// @dev BaseMainnet Brett
    function BRETT() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Brett",
            symbol: "BRETT",
            decimals: 18,
            assetAddress: 0x532f27101965dd16442E59d40670FaF5eBB142E4
        });
    }

    /// @dev BaseMainnet higher
    function HIGHER() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "higher",
            symbol: "HIGHER",
            decimals: 18,
            assetAddress: 0x0578d8A44db98B23BF096A382e016e29a5Ce0ffe
        });
    }

    /// @dev BaseMainnet luminous
    function LUM() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "luminous",
            symbol: "LUM",
            decimals: 18,
            assetAddress: 0x0fD7a301B51d0A83FCAf6718628174D527B373b6
        });
    }

    /// @dev BaseMainnet WELL
    function WELL() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "WELL",
            symbol: "WELL",
            decimals: 18,
            assetAddress: 0xA88594D404727625A9437C3f886C7643872296AE
        });
    }

    /// @dev BaseMainnet Morpho Token
    function MORPHO() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Morpho Token",
            symbol: "MORPHO",
            decimals: 18,
            assetAddress: 0xBAa5CC21fd487B8Fcc2F632f3F4E8D37262a0842
        });
    }

    /// @dev BaseMainnet Compound
    function COMP() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Compound",
            symbol: "COMP",
            decimals: 18,
            assetAddress: 0x9e1028F5F1D5eDE59748FFceE5532509976840E0
        });
    }

    /// @dev BaseMainnet Coinbase Wrapped Staked ETH
    function cbETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Coinbase Wrapped Staked ETH",
            symbol: "cbETH",
            decimals: 18,
            assetAddress: 0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22
        });
    }

    /// @dev BaseMainnet Wrapped Ether
    function WETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped Ether",
            symbol: "WETH",
            decimals: 18,
            assetAddress: 0x4200000000000000000000000000000000000006
        });
    }

    /// @dev BaseMainnet Wrapped liquid staked Ether 2.0
    function wstETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped liquid staked Ether 2.0",
            symbol: "wstETH",
            decimals: 18,
            assetAddress: 0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452
        });
    }

    /// @dev BaseMainnet Coinbase Wrapped BTC
    function cbBTC() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Coinbase Wrapped BTC",
            symbol: "cbBTC",
            decimals: 8,
            assetAddress: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf
        });
    }

    /// @dev BaseMainnet Renzo Restaked ETH
    function ezETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Renzo Restaked ETH",
            symbol: "ezETH",
            decimals: 18,
            assetAddress: 0x2416092f143378750bb29b79eD961ab195CcEea5
        });
    }

    /// @dev BaseMainnet Wrapped eETH
    function weETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped eETH",
            symbol: "weETH",
            decimals: 18,
            assetAddress: 0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A
        });
    }

    /// @dev BaseMainnet rsETHWrapper
    function wrsETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "rsETHWrapper",
            symbol: "wrsETH",
            decimals: 18,
            assetAddress: 0xEDfa23602D0EC14714057867A78d01e94176BEA0
        });
    }

    /// @dev KnownPriceFeed constructors

    /// @dev BaseMainnet ETH_USD price feed
    function ETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x71041dddad3595F9CEd3DcCFBe3D1F4b0a16Bb70
        });
    }

    /// @dev BaseMainnet USDC_USD price feed
    function USDC_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x7e860098F58bBFC8648a4311b374B1D669a2bc6B
        });
    }

    /// @dev BaseMainnet wstETH_ETH price feed
    function wstETH_ETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "ETH",
            decimals: 18,
            priceFeed: 0x43a5C292A453A3bF3606fa856197f09D7B74251a
        });
    }

    /// @dev BaseMainnet COMP_USD price feed
    function COMP_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "COMP",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x9DDa783DE64A9d1A60c49ca761EbE528C35BA428
        });
    }

    /// @dev BaseMainnet cbETH_USD price feed
    function cbETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x4687670f5f01716fAA382E2356C103BaD776752C
        });
    }

    /// @dev BaseMainnet WETH_USD price feed
    function WETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x71041dddad3595F9CEd3DcCFBe3D1F4b0a16Bb70
        });
    }

    /// @dev BaseMainnet wstETH_USD price feed
    function wstETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x4b5DeE60531a72C1264319Ec6A22678a4D0C8118
        });
    }

    /// @dev BaseMainnet cbBTC_USD price feed
    function cbBTC_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbBTC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x8D38A3d6B3c3B7d96D6536DA7Eef94A9d7dbC991
        });
    }

    /// @dev BaseMainnet cbETH_WETH price feed
    function cbETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x59e242D352ae13166B4987aE5c990C232f7f7CD6
        });
    }

    /// @dev BaseMainnet ezETH_WETH price feed
    function ezETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ezETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x72874CfE957bb47795548e5a9fd740D135ba5E45
        });
    }

    /// @dev BaseMainnet wstETH_WETH price feed
    function wstETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x1F71901daf98d70B4BAF40DE080321e5C2676856
        });
    }

    /// @dev BaseMainnet USDC_WETH price feed
    function USDC_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x2F4eAF29dfeeF4654bD091F7112926E108eF4Ed0
        });
    }

    /// @dev BaseMainnet weETH_WETH price feed
    function weETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "weETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x841e380e3a98E4EE8912046d69731F4E21eFb1D7
        });
    }

    /// @dev BaseMainnet wrsETH_WETH price feed
    function wrsETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wrsETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xaeB318360f27748Acb200CE616E389A6C9409a07
        });
    }

    /// @dev BaseMainnet cbBTC_WETH price feed
    function cbBTC_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbBTC",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x4cfCE7795bF75dC3795369A953d9A9b8C2679AE4
        });
    }

    /// @dev KnownComet constructors

    /// @dev BaseMainnet Compound USDC
    function Comet_cUSDCv3() public pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](4);

        collaterals[0] = KnownCometCollateral({
            asset: 0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22,
            supplyCap: 7500000000000000000000,
            priceFeed: 0x4687670f5f01716fAA382E2356C103BaD776752C,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0x4200000000000000000000000000000000000006,
            supplyCap: 11000000000000000000000,
            priceFeed: 0x71041dddad3595F9CEd3DcCFBe3D1F4b0a16Bb70,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.5e17,
            liquidateCollateralFactor: 9e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452,
            supplyCap: 700000000000000000000,
            priceFeed: 0x4b5DeE60531a72C1264319Ec6A22678a4D0C8118,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf,
            supplyCap: 9000000000,
            priceFeed: 0x8D38A3d6B3c3B7d96D6536DA7Eef94A9d7dbC991,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        return KnownComet({
            name: "Compound USDC",
            symbol: "cUSDCv3",
            cometAddress: 0xb125E6687d4313864e53df431d5425969c15Eb2F,
            rewardsAddress: 0x123964802e6ABabBE1Bc9547D72Ef1B69B00A6b1,
            factorScale: 1e18,
            baseAsset: 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913,
            collateralAssets: collaterals
        });
    }

    /// @dev BaseMainnet Compound WETH
    function Comet_cWETHv3() public pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](7);

        collaterals[0] = KnownCometCollateral({
            asset: 0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22,
            supplyCap: 7500000000000000000000,
            priceFeed: 0x59e242D352ae13166B4987aE5c990C232f7f7CD6,
            liquidationFactor: 9.75e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0x2416092f143378750bb29b79eD961ab195CcEea5,
            supplyCap: 2000000000000000000000,
            priceFeed: 0x72874CfE957bb47795548e5a9fd740D135ba5E45,
            liquidationFactor: 9.4e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9.1e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452,
            supplyCap: 1200000000000000000000,
            priceFeed: 0x1F71901daf98d70B4BAF40DE080321e5C2676856,
            liquidationFactor: 9.75e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913,
            supplyCap: 20000000000000,
            priceFeed: 0x2F4eAF29dfeeF4654bD091F7112926E108eF4Ed0,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[4] = KnownCometCollateral({
            asset: 0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A,
            supplyCap: 2100000000000000000000,
            priceFeed: 0x841e380e3a98E4EE8912046d69731F4E21eFb1D7,
            liquidationFactor: 9.6e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[5] = KnownCometCollateral({
            asset: 0xEDfa23602D0EC14714057867A78d01e94176BEA0,
            supplyCap: 230000000000000000000,
            priceFeed: 0xaeB318360f27748Acb200CE616E389A6C9409a07,
            liquidationFactor: 9.6e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9.1e17
        });

        collaterals[6] = KnownCometCollateral({
            asset: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf,
            supplyCap: 4500000000,
            priceFeed: 0x4cfCE7795bF75dC3795369A953d9A9b8C2679AE4,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        return KnownComet({
            name: "Compound WETH",
            symbol: "cWETHv3",
            cometAddress: 0x46e6b214b524310239732D51387075E0e70970bf,
            rewardsAddress: 0x123964802e6ABabBE1Bc9547D72Ef1B69B00A6b1,
            factorScale: 1e18,
            baseAsset: 0x4200000000000000000000000000000000000006,
            collateralAssets: collaterals
        });
    }

    /// @dev All BaseMainnet known assets
    function knownAssets() public pure returns (KnownAsset[] memory) {
        KnownAsset[] memory assets = new KnownAsset[](17);
        assets[0] = ETH();
        assets[1] = USDC();
        assets[2] = AERO();
        assets[3] = DEGEN();
        assets[4] = BRETT();
        assets[5] = HIGHER();
        assets[6] = LUM();
        assets[7] = WELL();
        assets[8] = MORPHO();
        assets[9] = COMP();
        assets[10] = cbETH();
        assets[11] = WETH();
        assets[12] = wstETH();
        assets[13] = cbBTC();
        assets[14] = ezETH();
        assets[15] = weETH();
        assets[16] = wrsETH();
        return assets;
    }

    /// @dev All BaseMainnet known price feeds
    function knownPriceFeeds() public pure returns (KnownPriceFeed[] memory) {
        KnownPriceFeed[] memory priceFeeds = new KnownPriceFeed[](15);
        priceFeeds[0] = ETH_USD();
        priceFeeds[1] = USDC_USD();
        priceFeeds[2] = wstETH_ETH();
        priceFeeds[3] = COMP_USD();
        priceFeeds[4] = cbETH_USD();
        priceFeeds[5] = WETH_USD();
        priceFeeds[6] = wstETH_USD();
        priceFeeds[7] = cbBTC_USD();
        priceFeeds[8] = cbETH_WETH();
        priceFeeds[9] = ezETH_WETH();
        priceFeeds[10] = wstETH_WETH();
        priceFeeds[11] = USDC_WETH();
        priceFeeds[12] = weETH_WETH();
        priceFeeds[13] = wrsETH_WETH();
        priceFeeds[14] = cbBTC_WETH();
        return priceFeeds;
    }

    /// @dev All BaseMainnet known comets
    function knownComets() public pure returns (KnownComet[] memory) {
        KnownComet[] memory comets = new KnownComet[](2);
        comets[0] = Comet_cUSDCv3();
        comets[1] = Comet_cWETHv3();
        return comets;
    }

    /// @dev The big BaseMainnet burrito
    function knownNetwork() public pure returns (KnownNetwork memory) {
        return KnownNetwork({
            chainId: 8453,
            isTestnet: false,
            assets: knownAssets(),
            comets: knownComets(),
            priceFeeds: knownPriceFeeds()
        });
    }
}

contract ArbitrumMainnetContract {
    /// @dev KnownAsset constructors

    /// @dev ArbitrumMainnet Ether
    function ETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Ether",
            symbol: "ETH",
            decimals: 18,
            assetAddress: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        });
    }

    /// @dev ArbitrumMainnet USD Coin
    function USDC() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "USD Coin",
            symbol: "USDC",
            decimals: 6,
            assetAddress: 0xaf88d065e77c8cC2239327C5EDb3A432268e5831
        });
    }

    /// @dev ArbitrumMainnet Tether USD
    function USDT() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Tether USD",
            symbol: "USDT",
            decimals: 6,
            assetAddress: 0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9
        });
    }

    /// @dev ArbitrumMainnet Wrapped BTC
    function WBTC() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped BTC",
            symbol: "WBTC",
            decimals: 8,
            assetAddress: 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f
        });
    }

    /// @dev ArbitrumMainnet Arbitrum
    function ARB() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Arbitrum",
            symbol: "ARB",
            decimals: 18,
            assetAddress: 0x912CE59144191C1204E64559FE8253a0e49E6548
        });
    }

    /// @dev ArbitrumMainnet Compound
    function COMP() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Compound",
            symbol: "COMP",
            decimals: 18,
            assetAddress: 0x354A6dA3fcde098F8389cad84b0182725c6C91dE
        });
    }

    /// @dev ArbitrumMainnet GMX
    function GMX() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "GMX",
            symbol: "GMX",
            decimals: 18,
            assetAddress: 0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a
        });
    }

    /// @dev ArbitrumMainnet Wrapped Ether
    function WETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped Ether",
            symbol: "WETH",
            decimals: 18,
            assetAddress: 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1
        });
    }

    /// @dev ArbitrumMainnet Wrapped liquid staked Ether 2.0
    function wstETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped liquid staked Ether 2.0",
            symbol: "wstETH",
            decimals: 18,
            assetAddress: 0x5979D7b546E38E414F7E9822514be443A4800529
        });
    }

    /// @dev ArbitrumMainnet Renzo Restaked ETH
    function ezETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Renzo Restaked ETH",
            symbol: "ezETH",
            decimals: 18,
            assetAddress: 0x2416092f143378750bb29b79eD961ab195CcEea5
        });
    }

    /// @dev ArbitrumMainnet Wrapped eETH
    function weETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped eETH",
            symbol: "weETH",
            decimals: 18,
            assetAddress: 0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe
        });
    }

    /// @dev ArbitrumMainnet Rocket Pool ETH
    function rETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Rocket Pool ETH",
            symbol: "rETH",
            decimals: 18,
            assetAddress: 0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8
        });
    }

    /// @dev ArbitrumMainnet KelpDao Restaked ETH
    function rsETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "KelpDao Restaked ETH",
            symbol: "rsETH",
            decimals: 18,
            assetAddress: 0x4186BFC76E2E237523CBC30FD220FE055156b41F
        });
    }

    /// @dev KnownPriceFeed constructors

    /// @dev ArbitrumMainnet ETH_USD price feed
    function ETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612
        });
    }

    /// @dev ArbitrumMainnet USDC_USD price feed
    function USDC_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3
        });
    }

    /// @dev ArbitrumMainnet USDT_USD price feed
    function USDT_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDT",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x3f3f5dF88dC9F13eac63DF89EC16ef6e7E25DdE7
        });
    }

    /// @dev ArbitrumMainnet WBTC_USD price feed
    function WBTC_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WBTC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xd0C7101eACbB49F3deCcCc166d238410D6D46d57
        });
    }

    /// @dev ArbitrumMainnet ARB_USD price feed
    function ARB_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ARB",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6
        });
    }

    /// @dev ArbitrumMainnet COMP_USD price feed
    function COMP_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "COMP",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xe7C53FFd03Eb6ceF7d208bC4C13446c76d1E5884
        });
    }

    /// @dev ArbitrumMainnet GMX_USD price feed
    function GMX_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "GMX",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xDB98056FecFff59D032aB628337A4887110df3dB
        });
    }

    /// @dev ArbitrumMainnet WETH_USD price feed
    function WETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612
        });
    }

    /// @dev ArbitrumMainnet wstETH_USD price feed
    function wstETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xe165155c34fE4cBfC55Fc554437907BDb1Af7e3e
        });
    }

    /// @dev ArbitrumMainnet ezETH_USD price feed
    function ezETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ezETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xC49399814452B41dA8a7cd76a159f5515cb3e493
        });
    }

    /// @dev ArbitrumMainnet ARB_USDT price feed
    function ARB_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ARB",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6
        });
    }

    /// @dev ArbitrumMainnet WETH_USDT price feed
    function WETH_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WETH",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612
        });
    }

    /// @dev ArbitrumMainnet wstETH_USDT price feed
    function wstETH_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0xe165155c34fE4cBfC55Fc554437907BDb1Af7e3e
        });
    }

    /// @dev ArbitrumMainnet WBTC_USDT price feed
    function WBTC_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WBTC",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0xd0C7101eACbB49F3deCcCc166d238410D6D46d57
        });
    }

    /// @dev ArbitrumMainnet GMX_USDT price feed
    function GMX_USDT() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "GMX",
            symbolOut: "USDT",
            decimals: 8,
            priceFeed: 0xDB98056FecFff59D032aB628337A4887110df3dB
        });
    }

    /// @dev ArbitrumMainnet weETH_WETH price feed
    function weETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "weETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xd3cf278F135D9831D2bF28F6672a4575906CA724
        });
    }

    /// @dev ArbitrumMainnet rETH_WETH price feed
    function rETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "rETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x970FfD8E335B8fa4cd5c869c7caC3a90671d5Dc3
        });
    }

    /// @dev ArbitrumMainnet wstETH_WETH price feed
    function wstETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x6C987dDE50dB1dcDd32Cd4175778C2a291978E2a
        });
    }

    /// @dev ArbitrumMainnet WBTC_WETH price feed
    function WBTC_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WBTC",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xFa454dE61b317b6535A0C462267208E8FdB89f45
        });
    }

    /// @dev ArbitrumMainnet rsETH_WETH price feed
    function rsETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "rsETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x3870FAc3De911c12A57E5a2532D15aD8Ca275A60
        });
    }

    /// @dev ArbitrumMainnet USDT_WETH price feed
    function USDT_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDT",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x84E93EC6170ED630f5ebD89A1AAE72d4F63f2713
        });
    }

    /// @dev ArbitrumMainnet USDC_WETH price feed
    function USDC_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x443EA0340cb75a160F31A440722dec7b5bc3C2E9
        });
    }

    /// @dev ArbitrumMainnet ezETH_WETH price feed
    function ezETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ezETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x72e9B6F907365d76C6192aD49C0C5ba356b7Fa48
        });
    }

    /// @dev KnownComet constructors

    /// @dev ArbitrumMainnet Compound USDC
    function Comet_cUSDCv3() public pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](6);

        collaterals[0] = KnownCometCollateral({
            asset: 0x912CE59144191C1204E64559FE8253a0e49E6548,
            supplyCap: 16000000000000000000000000,
            priceFeed: 0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 7e17,
            liquidateCollateralFactor: 8e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a,
            supplyCap: 120000000000000000000000,
            priceFeed: 0xDB98056FecFff59D032aB628337A4887110df3dB,
            liquidationFactor: 8.5e17,
            borrowCollateralFactor: 6e17,
            liquidateCollateralFactor: 7.5e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1,
            supplyCap: 40000000000000000000000,
            priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.3e17,
            liquidateCollateralFactor: 9e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f,
            supplyCap: 100000000000,
            priceFeed: 0xd0C7101eACbB49F3deCcCc166d238410D6D46d57,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 7.5e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[4] = KnownCometCollateral({
            asset: 0x5979D7b546E38E414F7E9822514be443A4800529,
            supplyCap: 8000000000000000000000,
            priceFeed: 0xe165155c34fE4cBfC55Fc554437907BDb1Af7e3e,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[5] = KnownCometCollateral({
            asset: 0x2416092f143378750bb29b79eD961ab195CcEea5,
            supplyCap: 1400000000000000000000,
            priceFeed: 0xC49399814452B41dA8a7cd76a159f5515cb3e493,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        return KnownComet({
            name: "Compound USDC",
            symbol: "cUSDCv3",
            cometAddress: 0x9c4ec768c28520B50860ea7a15bd7213a9fF58bf,
            rewardsAddress: 0x88730d254A2f7e6AC8388c3198aFd694bA9f7fae,
            factorScale: 1e18,
            baseAsset: 0xaf88d065e77c8cC2239327C5EDb3A432268e5831,
            collateralAssets: collaterals
        });
    }

    /// @dev ArbitrumMainnet Compound USDT
    function Comet_cUSDTv3() public pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](5);

        collaterals[0] = KnownCometCollateral({
            asset: 0x912CE59144191C1204E64559FE8253a0e49E6548,
            supplyCap: 7500000000000000000000000,
            priceFeed: 0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 7e17,
            liquidateCollateralFactor: 8e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1,
            supplyCap: 20000000000000000000000,
            priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8.5e17,
            liquidateCollateralFactor: 9e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0x5979D7b546E38E414F7E9822514be443A4800529,
            supplyCap: 16000000000000000000000,
            priceFeed: 0xe165155c34fE4cBfC55Fc554437907BDb1Af7e3e,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f,
            supplyCap: 100000000000,
            priceFeed: 0xd0C7101eACbB49F3deCcCc166d238410D6D46d57,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 7e17,
            liquidateCollateralFactor: 8e17
        });

        collaterals[4] = KnownCometCollateral({
            asset: 0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a,
            supplyCap: 100000000000000000000000,
            priceFeed: 0xDB98056FecFff59D032aB628337A4887110df3dB,
            liquidationFactor: 8e17,
            borrowCollateralFactor: 6e17,
            liquidateCollateralFactor: 7e17
        });

        return KnownComet({
            name: "Compound USDT",
            symbol: "cUSDTv3",
            cometAddress: 0xd98Be00b5D27fc98112BdE293e487f8D4cA57d07,
            rewardsAddress: 0x88730d254A2f7e6AC8388c3198aFd694bA9f7fae,
            factorScale: 1e18,
            baseAsset: 0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9,
            collateralAssets: collaterals
        });
    }

    /// @dev ArbitrumMainnet Compound WETH
    function Comet_cWETHv3() public pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](8);

        collaterals[0] = KnownCometCollateral({
            asset: 0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe,
            supplyCap: 24000000000000000000000,
            priceFeed: 0xd3cf278F135D9831D2bF28F6672a4575906CA724,
            liquidationFactor: 9.6e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8,
            supplyCap: 7500000000000000000000,
            priceFeed: 0x970FfD8E335B8fa4cd5c869c7caC3a90671d5Dc3,
            liquidationFactor: 9.7e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0x5979D7b546E38E414F7E9822514be443A4800529,
            supplyCap: 10000000000000000000000,
            priceFeed: 0x6C987dDE50dB1dcDd32Cd4175778C2a291978E2a,
            liquidationFactor: 9.7e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[3] = KnownCometCollateral({
            asset: 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f,
            supplyCap: 100000000000,
            priceFeed: 0xFa454dE61b317b6535A0C462267208E8FdB89f45,
            liquidationFactor: 9e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[4] = KnownCometCollateral({
            asset: 0x4186BFC76E2E237523CBC30FD220FE055156b41F,
            supplyCap: 3500000000000000000000,
            priceFeed: 0x3870FAc3De911c12A57E5a2532D15aD8Ca275A60,
            liquidationFactor: 9.6e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9.1e17
        });

        collaterals[5] = KnownCometCollateral({
            asset: 0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9,
            supplyCap: 20000000000000,
            priceFeed: 0x84E93EC6170ED630f5ebD89A1AAE72d4F63f2713,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[6] = KnownCometCollateral({
            asset: 0xaf88d065e77c8cC2239327C5EDb3A432268e5831,
            supplyCap: 30000000000000,
            priceFeed: 0x443EA0340cb75a160F31A440722dec7b5bc3C2E9,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 8e17,
            liquidateCollateralFactor: 8.5e17
        });

        collaterals[7] = KnownCometCollateral({
            asset: 0x2416092f143378750bb29b79eD961ab195CcEea5,
            supplyCap: 12000000000000000000000,
            priceFeed: 0x72e9B6F907365d76C6192aD49C0C5ba356b7Fa48,
            liquidationFactor: 9.4e17,
            borrowCollateralFactor: 8.8e17,
            liquidateCollateralFactor: 9.1e17
        });

        return KnownComet({
            name: "Compound WETH",
            symbol: "cWETHv3",
            cometAddress: 0x6f7D514bbD4aFf3BcD1140B7344b32f063dEe486,
            rewardsAddress: 0x88730d254A2f7e6AC8388c3198aFd694bA9f7fae,
            factorScale: 1e18,
            baseAsset: 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1,
            collateralAssets: collaterals
        });
    }

    /// @dev All ArbitrumMainnet known assets
    function knownAssets() public pure returns (KnownAsset[] memory) {
        KnownAsset[] memory assets = new KnownAsset[](13);
        assets[0] = ETH();
        assets[1] = USDC();
        assets[2] = USDT();
        assets[3] = WBTC();
        assets[4] = ARB();
        assets[5] = COMP();
        assets[6] = GMX();
        assets[7] = WETH();
        assets[8] = wstETH();
        assets[9] = ezETH();
        assets[10] = weETH();
        assets[11] = rETH();
        assets[12] = rsETH();
        return assets;
    }

    /// @dev All ArbitrumMainnet known price feeds
    function knownPriceFeeds() public pure returns (KnownPriceFeed[] memory) {
        KnownPriceFeed[] memory priceFeeds = new KnownPriceFeed[](23);
        priceFeeds[0] = ETH_USD();
        priceFeeds[1] = USDC_USD();
        priceFeeds[2] = USDT_USD();
        priceFeeds[3] = WBTC_USD();
        priceFeeds[4] = ARB_USD();
        priceFeeds[5] = COMP_USD();
        priceFeeds[6] = GMX_USD();
        priceFeeds[7] = WETH_USD();
        priceFeeds[8] = wstETH_USD();
        priceFeeds[9] = ezETH_USD();
        priceFeeds[10] = ARB_USDT();
        priceFeeds[11] = WETH_USDT();
        priceFeeds[12] = wstETH_USDT();
        priceFeeds[13] = WBTC_USDT();
        priceFeeds[14] = GMX_USDT();
        priceFeeds[15] = weETH_WETH();
        priceFeeds[16] = rETH_WETH();
        priceFeeds[17] = wstETH_WETH();
        priceFeeds[18] = WBTC_WETH();
        priceFeeds[19] = rsETH_WETH();
        priceFeeds[20] = USDT_WETH();
        priceFeeds[21] = USDC_WETH();
        priceFeeds[22] = ezETH_WETH();
        return priceFeeds;
    }

    /// @dev All ArbitrumMainnet known comets
    function knownComets() public pure returns (KnownComet[] memory) {
        KnownComet[] memory comets = new KnownComet[](3);
        comets[0] = Comet_cUSDCv3();
        comets[1] = Comet_cUSDTv3();
        comets[2] = Comet_cWETHv3();
        return comets;
    }

    /// @dev The big ArbitrumMainnet burrito
    function knownNetwork() public pure returns (KnownNetwork memory) {
        return KnownNetwork({
            chainId: 42161,
            isTestnet: false,
            assets: knownAssets(),
            comets: knownComets(),
            priceFeeds: knownPriceFeeds()
        });
    }
}

contract EthereumSepoliaContract {
    /// @dev KnownAsset constructors

    /// @dev EthereumSepolia Ether
    function ETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Ether",
            symbol: "ETH",
            decimals: 18,
            assetAddress: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        });
    }

    /// @dev EthereumSepolia USDC
    function USDC() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "USDC",
            symbol: "USDC",
            decimals: 6,
            assetAddress: 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238
        });
    }

    /// @dev EthereumSepolia Wrapped Ether
    function WETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped Ether",
            symbol: "WETH",
            decimals: 18,
            assetAddress: 0x2D5ee574e710219a521449679A4A7f2B43f046ad
        });
    }

    /// @dev EthereumSepolia Compound
    function COMP() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Compound",
            symbol: "COMP",
            decimals: 18,
            assetAddress: 0xA6c8D1c55951e8AC44a0EaA959Be5Fd21cc07531
        });
    }

    /// @dev EthereumSepolia Coinbase Wrapped Staked ETH
    function cbETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Coinbase Wrapped Staked ETH",
            symbol: "cbETH",
            decimals: 18,
            assetAddress: 0xb9fa8F5eC3Da13B508F462243Ad0555B46E028df
        });
    }

    /// @dev EthereumSepolia Wrapped liquid staked Ether 2.0
    function wstETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped liquid staked Ether 2.0",
            symbol: "wstETH",
            decimals: 18,
            assetAddress: 0xB82381A3fBD3FaFA77B3a7bE693342618240067b
        });
    }

    /// @dev EthereumSepolia Wrapped BTC
    function WBTC() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped BTC",
            symbol: "WBTC",
            decimals: 8,
            assetAddress: 0xa035b9e130F2B1AedC733eEFb1C67Ba4c503491F
        });
    }

    /// @dev KnownPriceFeed constructors

    /// @dev EthereumSepolia ETH_USD price feed
    function ETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
    }

    /// @dev EthereumSepolia WETH_USD price feed
    function WETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
    }

    /// @dev EthereumSepolia COMP_USD price feed
    function COMP_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "COMP",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x619db7F74C0061E2917D1D57f834D9D24C5529dA
        });
    }

    /// @dev EthereumSepolia cbETH_WETH price feed
    function cbETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0xBE60803049CA4Aea3B75E4238d664aEbcdDd0773
        });
    }

    /// @dev EthereumSepolia wstETH_WETH price feed
    function wstETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "wstETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x722c4ba7Eb8A1b0fD360bFF6cf19E5E2AA1C3DdF
        });
    }

    /// @dev EthereumSepolia USDC_USD price feed
    function USDC_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xA2F78ab2355fe2f984D808B5CeE7FD0A93D5270E
        });
    }

    /// @dev EthereumSepolia WBTC_USD price feed
    function WBTC_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WBTC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        });
    }

    /// @dev KnownComet constructors

    /// @dev EthereumSepolia Compound WETH
    function Comet_cWETHv3() public pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](2);

        collaterals[0] = KnownCometCollateral({
            asset: 0xb9fa8F5eC3Da13B508F462243Ad0555B46E028df,
            supplyCap: 9000000000000000000000,
            priceFeed: 0xBE60803049CA4Aea3B75E4238d664aEbcdDd0773,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0xB82381A3fBD3FaFA77B3a7bE693342618240067b,
            supplyCap: 80000000000000000000000,
            priceFeed: 0x722c4ba7Eb8A1b0fD360bFF6cf19E5E2AA1C3DdF,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        return KnownComet({
            name: "Compound WETH",
            symbol: "cWETHv3",
            cometAddress: 0x2943ac1216979aD8dB76D9147F64E61adc126e96,
            rewardsAddress: 0x8bF5b658bdF0388E8b482ED51B14aef58f90abfD,
            factorScale: 1e18,
            baseAsset: 0x2D5ee574e710219a521449679A4A7f2B43f046ad,
            collateralAssets: collaterals
        });
    }

    /// @dev EthereumSepolia Compound USDC
    function Comet_cUSDCv3() public pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](3);

        collaterals[0] = KnownCometCollateral({
            asset: 0xA6c8D1c55951e8AC44a0EaA959Be5Fd21cc07531,
            supplyCap: 500000000000000000000000,
            priceFeed: 0x619db7F74C0061E2917D1D57f834D9D24C5529dA,
            liquidationFactor: 9.2e17,
            borrowCollateralFactor: 6.5e17,
            liquidateCollateralFactor: 7e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0xa035b9e130F2B1AedC733eEFb1C67Ba4c503491F,
            supplyCap: 3500000000000,
            priceFeed: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43,
            liquidationFactor: 9.3e17,
            borrowCollateralFactor: 7e17,
            liquidateCollateralFactor: 7.5e17
        });

        collaterals[2] = KnownCometCollateral({
            asset: 0x2D5ee574e710219a521449679A4A7f2B43f046ad,
            supplyCap: 1000000000000000000000000,
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306,
            liquidationFactor: 9.3e17,
            borrowCollateralFactor: 8.2e17,
            liquidateCollateralFactor: 8.5e17
        });

        return KnownComet({
            name: "Compound USDC",
            symbol: "cUSDCv3",
            cometAddress: 0xAec1F48e02Cfb822Be958B68C7957156EB3F0b6e,
            rewardsAddress: 0x8bF5b658bdF0388E8b482ED51B14aef58f90abfD,
            factorScale: 1e18,
            baseAsset: 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238,
            collateralAssets: collaterals
        });
    }

    /// @dev All EthereumSepolia known assets
    function knownAssets() public pure returns (KnownAsset[] memory) {
        KnownAsset[] memory assets = new KnownAsset[](7);
        assets[0] = ETH();
        assets[1] = USDC();
        assets[2] = WETH();
        assets[3] = COMP();
        assets[4] = cbETH();
        assets[5] = wstETH();
        assets[6] = WBTC();
        return assets;
    }

    /// @dev All EthereumSepolia known price feeds
    function knownPriceFeeds() public pure returns (KnownPriceFeed[] memory) {
        KnownPriceFeed[] memory priceFeeds = new KnownPriceFeed[](7);
        priceFeeds[0] = ETH_USD();
        priceFeeds[1] = WETH_USD();
        priceFeeds[2] = COMP_USD();
        priceFeeds[3] = cbETH_WETH();
        priceFeeds[4] = wstETH_WETH();
        priceFeeds[5] = USDC_USD();
        priceFeeds[6] = WBTC_USD();
        return priceFeeds;
    }

    /// @dev All EthereumSepolia known comets
    function knownComets() public pure returns (KnownComet[] memory) {
        KnownComet[] memory comets = new KnownComet[](2);
        comets[0] = Comet_cWETHv3();
        comets[1] = Comet_cUSDCv3();
        return comets;
    }

    /// @dev The big EthereumSepolia burrito
    function knownNetwork() public pure returns (KnownNetwork memory) {
        return KnownNetwork({
            chainId: 11155111,
            isTestnet: true,
            assets: knownAssets(),
            comets: knownComets(),
            priceFeeds: knownPriceFeeds()
        });
    }
}

contract BaseSepoliaContract {
    /// @dev KnownAsset constructors

    /// @dev BaseSepolia Ether
    function ETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Ether",
            symbol: "ETH",
            decimals: 18,
            assetAddress: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        });
    }

    /// @dev BaseSepolia USDC
    function USDC() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "USDC",
            symbol: "USDC",
            decimals: 6,
            assetAddress: 0x036CbD53842c5426634e7929541eC2318f3dCF7e
        });
    }

    /// @dev BaseSepolia Wrapped Ether
    function WETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Wrapped Ether",
            symbol: "WETH",
            decimals: 18,
            assetAddress: 0x4200000000000000000000000000000000000006
        });
    }

    /// @dev BaseSepolia Compound
    function COMP() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Compound",
            symbol: "COMP",
            decimals: 18,
            assetAddress: 0x2f535da74048c0874400f0371Fba20DF983A56e2
        });
    }

    /// @dev BaseSepolia Coinbase Wrapped Staked ETH
    function cbETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Coinbase Wrapped Staked ETH",
            symbol: "cbETH",
            decimals: 18,
            assetAddress: 0x774eD9EDB0C5202dF9A86183804b5D9E99dC6CA3
        });
    }

    /// @dev KnownPriceFeed constructors

    /// @dev BaseSepolia ETH_USD price feed
    function ETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x4aDC67696bA383F43DD60A9e78F2C97Fbbfc7cb1
        });
    }

    /// @dev BaseSepolia WETH_USD price feed
    function WETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "WETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x4aDC67696bA383F43DD60A9e78F2C97Fbbfc7cb1
        });
    }

    /// @dev BaseSepolia COMP_USD price feed
    function COMP_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "COMP",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x9123612E1791817ed4bFfC4b57CA8aA1E4bCdBaa
        });
    }

    /// @dev BaseSepolia cbETH_WETH price feed
    function cbETH_WETH() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbETH",
            symbolOut: "WETH",
            decimals: 8,
            priceFeed: 0x6490397583a86566C01F467790125F1FED556299
        });
    }

    /// @dev BaseSepolia USDC_USD price feed
    function USDC_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xDC6d86db02E198764B077e1af7B1d31BbF575508
        });
    }

    /// @dev BaseSepolia cbETH_USD price feed
    function cbETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "cbETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x3e7e00F0c81712205A5F6c90D64879663c212873
        });
    }

    /// @dev Omitted duplicate WETH_USD price feed at 0xBD767F0b5925034F4e37D8990FC8fF080F6f92C8

    /// @dev Omitted duplicate USDC_USD price feed at 0xd30e2101a97dcbAeBCBC04F14C3f624E67A35165

    /// @dev KnownComet constructors

    /// @dev BaseSepolia Compound WETH
    function Comet_cWETHv3() public pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](1);

        collaterals[0] = KnownCometCollateral({
            asset: 0x774eD9EDB0C5202dF9A86183804b5D9E99dC6CA3,
            supplyCap: 7500000000000000000000,
            priceFeed: 0x6490397583a86566C01F467790125F1FED556299,
            liquidationFactor: 9.75e17,
            borrowCollateralFactor: 9e17,
            liquidateCollateralFactor: 9.3e17
        });

        return KnownComet({
            name: "Compound WETH",
            symbol: "cWETHv3",
            cometAddress: 0x61490650AbaA31393464C3f34E8B29cd1C44118E,
            rewardsAddress: 0x3394fa1baCC0b47dd0fF28C8573a476a161aF7BC,
            factorScale: 1e18,
            baseAsset: 0x4200000000000000000000000000000000000006,
            collateralAssets: collaterals
        });
    }

    /// @dev BaseSepolia Compound USDC
    function Comet_cUSDCv3() public pure returns (KnownComet memory) {
        KnownCometCollateral[] memory collaterals = new KnownCometCollateral[](2);

        collaterals[0] = KnownCometCollateral({
            asset: 0x774eD9EDB0C5202dF9A86183804b5D9E99dC6CA3,
            supplyCap: 800000000000000000000,
            priceFeed: 0x3e7e00F0c81712205A5F6c90D64879663c212873,
            liquidationFactor: 9.3e17,
            borrowCollateralFactor: 7.5e17,
            liquidateCollateralFactor: 8e17
        });

        collaterals[1] = KnownCometCollateral({
            asset: 0x4200000000000000000000000000000000000006,
            supplyCap: 1000000000000000000000,
            priceFeed: 0xBD767F0b5925034F4e37D8990FC8fF080F6f92C8,
            liquidationFactor: 9.5e17,
            borrowCollateralFactor: 7.75e17,
            liquidateCollateralFactor: 8.25e17
        });

        return KnownComet({
            name: "Compound USDC",
            symbol: "cUSDCv3",
            cometAddress: 0x571621Ce60Cebb0c1D442B5afb38B1663C6Bf017,
            rewardsAddress: 0x3394fa1baCC0b47dd0fF28C8573a476a161aF7BC,
            factorScale: 1e18,
            baseAsset: 0x036CbD53842c5426634e7929541eC2318f3dCF7e,
            collateralAssets: collaterals
        });
    }

    /// @dev All BaseSepolia known assets
    function knownAssets() public pure returns (KnownAsset[] memory) {
        KnownAsset[] memory assets = new KnownAsset[](5);
        assets[0] = ETH();
        assets[1] = USDC();
        assets[2] = WETH();
        assets[3] = COMP();
        assets[4] = cbETH();
        return assets;
    }

    /// @dev All BaseSepolia known price feeds
    function knownPriceFeeds() public pure returns (KnownPriceFeed[] memory) {
        KnownPriceFeed[] memory priceFeeds = new KnownPriceFeed[](8);
        priceFeeds[0] = ETH_USD();
        priceFeeds[1] = WETH_USD();
        priceFeeds[2] = COMP_USD();
        priceFeeds[3] = cbETH_WETH();
        priceFeeds[4] = USDC_USD();
        priceFeeds[5] = cbETH_USD();
        /// @dev Omitted duplicate USDC_USD price feed at 0xd30e2101a97dcbAeBCBC04F14C3f624E67A35165
        /// @dev Omitted duplicate WETH_USD price feed at 0xBD767F0b5925034F4e37D8990FC8fF080F6f92C8
        return priceFeeds;
    }

    /// @dev All BaseSepolia known comets
    function knownComets() public pure returns (KnownComet[] memory) {
        KnownComet[] memory comets = new KnownComet[](2);
        comets[0] = Comet_cWETHv3();
        comets[1] = Comet_cUSDCv3();
        return comets;
    }

    /// @dev The big BaseSepolia burrito
    function knownNetwork() public pure returns (KnownNetwork memory) {
        return KnownNetwork({
            chainId: 84532,
            isTestnet: true,
            assets: knownAssets(),
            comets: knownComets(),
            priceFeeds: knownPriceFeeds()
        });
    }
}

contract ArbitrumSepoliaContract {
    /// @dev KnownAsset constructors

    /// @dev ArbitrumSepolia Ether
    function ETH() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "Ether",
            symbol: "ETH",
            decimals: 18,
            assetAddress: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        });
    }

    /// @dev ArbitrumSepolia USD Coin
    function USDC() public pure returns (KnownAsset memory) {
        return KnownAsset({
            name: "USD Coin",
            symbol: "USDC",
            decimals: 6,
            assetAddress: 0x75faf114eafb1BDbe2F0316DF893fd58CE46AA4d
        });
    }

    /// @dev KnownPriceFeed constructors

    /// @dev ArbitrumSepolia ETH_USD price feed
    function ETH_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "ETH",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0xd30e2101a97dcbAeBCBC04F14C3f624E67A35165
        });
    }

    /// @dev ArbitrumSepolia USDC_USD price feed
    function USDC_USD() public pure returns (KnownPriceFeed memory) {
        return KnownPriceFeed({
            symbolIn: "USDC",
            symbolOut: "USD",
            decimals: 8,
            priceFeed: 0x0153002d20B96532C639313c2d54c3dA09109309
        });
    }

    /// @dev KnownComet constructors

    /// @dev All ArbitrumSepolia known assets
    function knownAssets() public pure returns (KnownAsset[] memory) {
        KnownAsset[] memory assets = new KnownAsset[](2);
        assets[0] = ETH();
        assets[1] = USDC();
        return assets;
    }

    /// @dev All ArbitrumSepolia known price feeds
    function knownPriceFeeds() public pure returns (KnownPriceFeed[] memory) {
        KnownPriceFeed[] memory priceFeeds = new KnownPriceFeed[](2);
        priceFeeds[0] = ETH_USD();
        priceFeeds[1] = USDC_USD();
        return priceFeeds;
    }

    /// @dev All ArbitrumSepolia known comets
    function knownComets() public pure returns (KnownComet[] memory) {
        KnownComet[] memory comets = new KnownComet[](0);
        return comets;
    }

    /// @dev The big ArbitrumSepolia burrito
    function knownNetwork() public pure returns (KnownNetwork memory) {
        return KnownNetwork({
            chainId: 421614,
            isTestnet: true,
            assets: knownAssets(),
            comets: knownComets(),
            priceFeeds: knownPriceFeeds()
        });
    }
}