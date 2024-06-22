// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {Accounts} from "../../src/builder/Accounts.sol";
import {PaymentInfo} from "../../src/builder/PaymentInfo.sol";
import {QuarkBuilder} from "../../src/builder/QuarkBuilder.sol";

contract QuarkBuilderTest {
    address constant USDC_1 = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address constant USDC_8453 = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913;
    // Random address for mock of USDC in random unsupported L2 chain
    address constant USDC_7777 = 0x8D89c5CaA76592e30e0410B9e68C0f235c62B312;

    address constant ETH_USD_PRICE_FEED_1 = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
    address constant ETH_USD_PRICE_FEED_8453 = 0x71041dddad3595F9CEd3DcCFBe3D1F4b0a16Bb70;

    /**
     *
     * Fixture Functions
     *
     * @dev to avoid variable shadowing warnings and to provide a visual signifier when
     * a function call is used to mock some data, we suffix all of our fixture-generating
     * functions with a single underscore, like so: transferIntent_(...).
     */
    function transferUsdc_(uint256 chainId, uint256 amount, address recipient, uint256 blockTimestamp)
        internal
        pure
        returns (QuarkBuilder.TransferIntent memory)
    {
        return QuarkBuilder.TransferIntent({
            chainId: chainId,
            sender: address(0xa11ce),
            recipient: recipient,
            amount: amount,
            assetSymbol: "USDC",
            blockTimestamp: blockTimestamp
        });
    }

    function paymentUsdc_() internal pure returns (PaymentInfo.Payment memory) {
        return paymentUsdc_(new PaymentInfo.PaymentMaxCost[](0));
    }

    function paymentUsdc_(PaymentInfo.PaymentMaxCost[] memory maxCosts)
        internal
        pure
        returns (PaymentInfo.Payment memory)
    {
        return PaymentInfo.Payment({isToken: true, currency: "usdc", maxCosts: maxCosts});
    }

    function paymentUsd_() internal pure returns (PaymentInfo.Payment memory) {
        return paymentUsd_(new PaymentInfo.PaymentMaxCost[](0));
    }

    function paymentUsd_(PaymentInfo.PaymentMaxCost[] memory maxCosts)
        internal
        pure
        returns (PaymentInfo.Payment memory)
    {
        return PaymentInfo.Payment({isToken: false, currency: "usd", maxCosts: maxCosts});
    }

    function chainAccountsList_(uint256 amount) internal pure returns (Accounts.ChainAccounts[] memory) {
        Accounts.ChainAccounts[] memory chainAccountsList = new Accounts.ChainAccounts[](2);
        chainAccountsList[0] = Accounts.ChainAccounts({
            chainId: 1,
            quarkStates: quarkStates_(address(0xa11ce), 12),
            assetPositionsList: assetPositionsList_(1, address(0xa11ce), uint256(amount / 2))
        });
        chainAccountsList[1] = Accounts.ChainAccounts({
            chainId: 8453,
            quarkStates: quarkStates_(address(0xb0b), 2),
            assetPositionsList: assetPositionsList_(8453, address(0xb0b), uint256(amount / 2))
        });
        return chainAccountsList;
    }

    function quarkStates_() internal pure returns (Accounts.QuarkState[] memory) {
        Accounts.QuarkState[] memory quarkStates = new Accounts.QuarkState[](1);
        quarkStates[0] = quarkState_();
        return quarkStates;
    }

    function maxCosts_(uint256 chainId, uint256 amount) internal pure returns (PaymentInfo.PaymentMaxCost[] memory) {
        PaymentInfo.PaymentMaxCost[] memory maxCosts = new PaymentInfo.PaymentMaxCost[](1);
        maxCosts[0] = PaymentInfo.PaymentMaxCost({chainId: chainId, amount: amount});
        return maxCosts;
    }

    function assetPositionsList_(uint256 chainId, address account, uint256 balance)
        internal
        pure
        returns (Accounts.AssetPositions[] memory)
    {
        Accounts.AssetPositions[] memory assetPositionsList = new Accounts.AssetPositions[](1);
        assetPositionsList[0] = Accounts.AssetPositions({
            asset: usdc_(chainId),
            symbol: "USDC",
            decimals: 6,
            usdPrice: 1_0000_0000,
            accountBalances: accountBalances_(account, balance)
        });
        return assetPositionsList;
    }

    function accountBalances_(address account, uint256 balance)
        internal
        pure
        returns (Accounts.AccountBalance[] memory)
    {
        Accounts.AccountBalance[] memory accountBalances = new Accounts.AccountBalance[](1);
        accountBalances[0] = Accounts.AccountBalance({account: account, balance: balance});
        return accountBalances;
    }

    function usdc_(uint256 chainId) internal pure returns (address) {
        if (chainId == 1) return USDC_1;
        if (chainId == 8453) return USDC_8453;
        if (chainId == 7777) return USDC_7777; // Mock with random L2's usdc
        revert("no mock usdc for that chain id bye");
    }

    function quarkStates_(address account, uint96 nextNonce) internal pure returns (Accounts.QuarkState[] memory) {
        Accounts.QuarkState[] memory quarkStates = new Accounts.QuarkState[](1);
        quarkStates[0] = quarkState_(account, nextNonce);
        return quarkStates;
    }

    function quarkState_() internal pure returns (Accounts.QuarkState memory) {
        return quarkState_(address(0xa11ce), 3);
    }

    function quarkState_(address account, uint96 nextNonce) internal pure returns (Accounts.QuarkState memory) {
        return Accounts.QuarkState({account: account, quarkNextNonce: nextNonce});
    }
}
