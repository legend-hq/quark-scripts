// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {QuarkBuilderTest, Accounts, PaymentInfo, QuarkBuilder} from "test/builder/lib/QuarkBuilderTest.sol";

import {Actions} from "src/builder/Actions.sol";
import {CCTPBridgeActions} from "src/BridgeScripts.sol";
import {CodeJarHelper} from "src/builder/CodeJarHelper.sol";
import {CometRepayAndWithdrawMultipleAssets} from "src/DeFiScripts.sol";
import {Paycall} from "src/Paycall.sol";
import {Strings} from "src/builder/Strings.sol";

contract QuarkBuilderCometRepayTest is Test, QuarkBuilderTest {
    function repayIntent_(
        uint256 amount,
        string memory assetSymbol,
        uint256 chainId,
        uint256[] memory collateralAmounts,
        string[] memory collateralAssetSymbols
    ) internal pure returns (QuarkBuilder.CometRepayIntent memory) {
        return QuarkBuilder.CometRepayIntent({
            amount: amount,
            assetSymbol: assetSymbol,
            blockTimestamp: BLOCK_TIMESTAMP,
            chainId: chainId,
            collateralAmounts: collateralAmounts,
            collateralAssetSymbols: collateralAssetSymbols,
            comet: COMET_1,
            repayer: address(0xa11ce)
        });
    }

    function testCometRepayInvalidInput() public {
        uint256[] memory collateralAmounts = new uint256[](2);
        collateralAmounts[0] = 1e18;
        collateralAmounts[1] = 1e18;

        string[] memory collateralAssetSymbols = new string[](1);
        collateralAssetSymbols[0] = "LINK";

        QuarkBuilder builder = new QuarkBuilder();

        vm.expectRevert(QuarkBuilder.InvalidInput.selector);

        builder.cometRepay(
            repayIntent_(1e6, "USDC", 1, collateralAmounts, collateralAssetSymbols),
            chainAccountsList_(3e6),
            paymentUsd_()
        );
    }

    function testCometRepayFundsUnavailable() public {
        uint256[] memory collateralAmounts = new uint256[](0);
        string[] memory collateralAssetSymbols = new string[](0);

        QuarkBuilder builder = new QuarkBuilder();

        vm.expectRevert(abi.encodeWithSelector(QuarkBuilder.FundsUnavailable.selector, "USDC", 1e6, 0));

        builder.cometRepay(
            repayIntent_(1e6, "USDC", 1, collateralAmounts, collateralAssetSymbols), // attempting to repay 1 USDC
            chainAccountsList_(0e6), // but user has 0 USDC
            paymentUsd_()
        );
    }

    function testCometRepayMaxCostTooHigh() public {
        QuarkBuilder builder = new QuarkBuilder();
        PaymentInfo.PaymentMaxCost[] memory maxCosts = new PaymentInfo.PaymentMaxCost[](1);
        maxCosts[0] = PaymentInfo.PaymentMaxCost({chainId: 1, amount: 0.5e6}); // action costs .5 USDC

        uint256[] memory collateralAmounts = new uint256[](0);
        string[] memory collateralAssetSymbols = new string[](0);

        ChainPortfolio[] memory chainPortfolios = new ChainPortfolio[](1);
        chainPortfolios[0] = ChainPortfolio({
            chainId: 1,
            account: address(0xa11ce),
            nextNonce: 12,
            assetSymbols: stringArray("USDC", "USDT", "LINK", "WETH"),
            assetBalances: uintArray(0.4e6, 0, 0, 1e18) // user does not have enough USDC
        });

        vm.expectRevert(QuarkBuilder.MaxCostTooHigh.selector);

        builder.cometRepay(
            repayIntent_(1e18, "WETH", 1, collateralAmounts, collateralAssetSymbols),
            chainAccountsFromChainPortfolios(chainPortfolios),
            paymentUsdc_(maxCosts)
        );
    }

    function testCometRepay() public {
        uint256[] memory collateralAmounts = new uint256[](1);
        collateralAmounts[0] = 1e18;

        string[] memory collateralAssetSymbols = new string[](1);
        collateralAssetSymbols[0] = "LINK";

        ChainPortfolio[] memory chainPortfolios = new ChainPortfolio[](2);
        chainPortfolios[0] = ChainPortfolio({
            chainId: 1,
            account: address(0xa11ce),
            nextNonce: 12,
            assetSymbols: stringArray("USDC", "USDT", "LINK", "WETH"),
            assetBalances: uintArray(1e6, 0, 0, 0) // has 1 USDC
        });
        chainPortfolios[1] = ChainPortfolio({
            chainId: 8453,
            account: address(0xb0b),
            nextNonce: 2,
            assetSymbols: stringArray("USDC", "USDT", "LINK", "WETH"),
            assetBalances: uintArray(0, 0, 0, 0)
        });

        QuarkBuilder builder = new QuarkBuilder();
        QuarkBuilder.BuilderResult memory result = builder.cometRepay(
            repayIntent_(
                1e6, // repaying 1 USDC
                "USDC",
                1,
                collateralAmounts, // withdrawing 1 LINK
                collateralAssetSymbols
            ),
            chainAccountsFromChainPortfolios(chainPortfolios),
            paymentUsd_()
        );

        assertEq(result.paymentCurrency, "usd", "usd currency");

        // Check the quark operations
        assertEq(result.quarkOperations.length, 1, "one operation");
        assertEq(
            result.quarkOperations[0].scriptAddress,
            address(
                uint160(
                    uint256(
                        keccak256(
                            abi.encodePacked(
                                bytes1(0xff),
                                /* codeJar address */
                                address(CodeJarHelper.CODE_JAR_ADDRESS),
                                uint256(0),
                                /* script bytecode */
                                keccak256(type(CometRepayAndWithdrawMultipleAssets).creationCode)
                            )
                        )
                    )
                )
            ),
            "script address is correct given the code jar address on mainnet"
        );
        address[] memory collateralAssets = new address[](1);
        collateralAssets[0] = link_(1);
        assertEq(
            result.quarkOperations[0].scriptCalldata,
            abi.encodeCall(
                CometRepayAndWithdrawMultipleAssets.run, (COMET_1, collateralAssets, collateralAmounts, usdc_(1), 1e6)
            ),
            "calldata is CometRepayAndWithdrawMultipleAssets.run(COMET_1, [LINK], [1e18], USDC, 1e6);"
        );
        assertEq(result.quarkOperations[0].scriptSources.length, 1);
        assertEq(result.quarkOperations[0].scriptSources[0], type(CometRepayAndWithdrawMultipleAssets).creationCode);
        assertEq(
            result.quarkOperations[0].expiry, BLOCK_TIMESTAMP + 7 days, "expiry is current blockTimestamp + 7 days"
        );

        // check the actions
        assertEq(result.actions.length, 1, "one action");
        assertEq(result.actions[0].chainId, 1, "operation is on chainid 1");
        assertEq(result.actions[0].quarkAccount, address(0xa11ce), "0xa11ce sends the funds");
        assertEq(result.actions[0].actionType, "REPAY", "action type is 'REPAY'");
        assertEq(result.actions[0].paymentMethod, "OFFCHAIN", "payment method is 'OFFCHAIN'");
        assertEq(result.actions[0].paymentToken, address(0), "payment token is null");
        assertEq(result.actions[0].paymentMaxCost, 0, "payment has no max cost, since 'OFFCHAIN'");

        uint256[] memory collateralAssetPrices = new uint256[](1);
        collateralAssetPrices[0] = 14e8;

        assertEq(
            result.actions[0].actionContext,
            abi.encode(
                Actions.RepayActionContext({
                    amount: 1e6,
                    assetSymbol: "USDC",
                    chainId: 1,
                    collateralAmounts: collateralAmounts,
                    collateralAssetPrices: collateralAssetPrices,
                    collateralAssets: collateralAssets,
                    comet: COMET_1,
                    price: 1e8,
                    token: usdc_(1)
                })
            ),
            "action context encoded from RepayActionContext"
        );

        // TODO: Check the contents of the EIP712 data
        assertNotEq(result.eip712Data.digest, hex"", "non-empty digest");
        assertNotEq(result.eip712Data.domainSeparator, hex"", "non-empty domain separator");
        assertNotEq(result.eip712Data.hashStruct, hex"", "non-empty hashStruct");
    }

    function testCometRepayWithPaycall() public {
        string[] memory collateralAssetSymbols = new string[](1);
        collateralAssetSymbols[0] = "LINK";

        uint256[] memory collateralAmounts = new uint256[](1);
        collateralAmounts[0] = 1e18;

        ChainPortfolio[] memory chainPortfolios = new ChainPortfolio[](2);
        chainPortfolios[0] = ChainPortfolio({
            chainId: 1,
            account: address(0xa11ce),
            nextNonce: 12,
            assetSymbols: stringArray("USDC", "USDT", "LINK", "WETH"),
            assetBalances: uintArray(2e6, 0, 0, 0)
        });
        chainPortfolios[1] = ChainPortfolio({
            chainId: 8453,
            account: address(0xb0b),
            nextNonce: 2,
            assetSymbols: stringArray("USDC", "USDT", "LINK", "WETH"),
            assetBalances: uintArray(0, 0, 0, 0)
        });

        PaymentInfo.PaymentMaxCost[] memory maxCosts = new PaymentInfo.PaymentMaxCost[](1);
        maxCosts[0] = PaymentInfo.PaymentMaxCost({chainId: 1, amount: 0.1e6});

        QuarkBuilder builder = new QuarkBuilder();
        QuarkBuilder.BuilderResult memory result = builder.cometRepay(
            repayIntent_(
                1e6, // repaying 1 USDC
                "USDC",
                1,
                collateralAmounts, // withdrawing 1 LINK
                collateralAssetSymbols
            ),
            chainAccountsFromChainPortfolios(chainPortfolios),
            paymentUsdc_(maxCosts) // and paying with USDC
        );

        address cometRepayAndWithdrawMultipleAssetsAddress =
            CodeJarHelper.getCodeAddress(type(CometRepayAndWithdrawMultipleAssets).creationCode);
        address paycallAddress = paycallUsdc_(1);

        assertEq(result.paymentCurrency, "usdc", "usdc currency");

        // Check the quark operations
        assertEq(result.quarkOperations.length, 1, "one operation");
        assertEq(
            result.quarkOperations[0].scriptAddress,
            paycallAddress,
            "script address is correct given the code jar address on mainnet"
        );

        address[] memory collateralAssets = new address[](1);
        collateralAssets[0] = link_(1);

        assertEq(
            result.quarkOperations[0].scriptCalldata,
            abi.encodeWithSelector(
                Paycall.run.selector,
                cometRepayAndWithdrawMultipleAssetsAddress,
                abi.encodeWithSelector(
                    CometRepayAndWithdrawMultipleAssets.run.selector,
                    COMET_1,
                    collateralAssets,
                    collateralAmounts,
                    usdc_(1),
                    1e6
                ),
                0.1e6
            ),
            "calldata is Paycall.run(CometRepayAndWithdrawMultipleAssets.run(COMET_1, [LINK_1], [1e18], USDC_1, 1e6), 0.1e6);"
        );
        assertEq(result.quarkOperations[0].scriptSources.length, 2);
        assertEq(result.quarkOperations[0].scriptSources[0], type(CometRepayAndWithdrawMultipleAssets).creationCode);
        assertEq(
            result.quarkOperations[0].scriptSources[1],
            abi.encodePacked(type(Paycall).creationCode, abi.encode(ETH_USD_PRICE_FEED_1, USDC_1))
        );
        assertEq(
            result.quarkOperations[0].expiry, BLOCK_TIMESTAMP + 7 days, "expiry is current blockTimestamp + 7 days"
        );

        // check the actions
        assertEq(result.actions.length, 1, "one action");
        assertEq(result.actions[0].chainId, 1, "operation is on chainid 1");
        assertEq(result.actions[0].quarkAccount, address(0xa11ce), "0xa11ce sends the funds");
        assertEq(result.actions[0].actionType, "REPAY", "action type is 'REPAY'");
        assertEq(result.actions[0].paymentMethod, "PAY_CALL", "payment method is 'PAY_CALL'");
        assertEq(result.actions[0].paymentToken, USDC_1, "payment token is USDC");
        assertEq(result.actions[0].paymentMaxCost, 0.1e6, "payment max is set to .1e6 in this test case");

        uint256[] memory collateralAssetPrices = new uint256[](1);
        collateralAssetPrices[0] = 14e8;

        assertEq(
            result.actions[0].actionContext,
            abi.encode(
                Actions.RepayActionContext({
                    amount: 1e6,
                    assetSymbol: "USDC",
                    chainId: 1,
                    collateralAmounts: collateralAmounts,
                    collateralAssetPrices: collateralAssetPrices,
                    collateralAssets: collateralAssets,
                    comet: COMET_1,
                    price: 1e8,
                    token: usdc_(1)
                })
            ),
            "action context encoded from RepayActionContext"
        );

        // TODO: Check the contents of the EIP712 data
        assertNotEq(result.eip712Data.digest, hex"", "non-empty digest");
        assertNotEq(result.eip712Data.domainSeparator, hex"", "non-empty domain separator");
        assertNotEq(result.eip712Data.hashStruct, hex"", "non-empty hashStruct");
    }

    // pay for a transaction with funds currently supplied as collateral
    function testCometRepayPayFromWithdraw() public {
        QuarkBuilder builder = new QuarkBuilder();
        PaymentInfo.PaymentMaxCost[] memory maxCosts = new PaymentInfo.PaymentMaxCost[](1);
        maxCosts[0] = PaymentInfo.PaymentMaxCost({chainId: 1, amount: 0.5e6}); // action costs .5 USDC

        uint256[] memory collateralAmounts = new uint256[](1);
        collateralAmounts[0] = 1e6;

        string[] memory collateralAssetSymbols = new string[](1);
        collateralAssetSymbols[0] = "USDC";

        ChainPortfolio[] memory chainPortfolios = new ChainPortfolio[](2);
        chainPortfolios[0] = ChainPortfolio({
            chainId: 1,
            account: address(0xa11ce),
            nextNonce: 12,
            assetSymbols: stringArray("USDC", "USDT", "LINK", "WETH"),
            assetBalances: uintArray(0, 0, 0, 1e18)
        });
        chainPortfolios[1] = ChainPortfolio({
            chainId: 8453,
            account: address(0xb0b),
            nextNonce: 2,
            assetSymbols: stringArray("USDC", "USDT", "LINK", "WETH"),
            assetBalances: uintArray(0, 0, 0, 0)
        });

        QuarkBuilder.BuilderResult memory result = builder.cometRepay(
            repayIntent_(
                1e18, // repaying 1 WETH
                "WETH",
                1,
                collateralAmounts, // and withdrawing 1 USDC
                collateralAssetSymbols
            ),
            chainAccountsFromChainPortfolios(chainPortfolios),
            paymentUsdc_(maxCosts) // user is paying with USDC that is currently supplied as collateral
        );

        address cometRepayAndWithdrawMultipleAssetsAddress =
            CodeJarHelper.getCodeAddress(type(CometRepayAndWithdrawMultipleAssets).creationCode);
        address paycallAddress = paycallUsdc_(1);

        assertEq(result.paymentCurrency, "usdc", "usdc currency");

        address[] memory collateralAssets = new address[](1);
        collateralAssets[0] = usdc_(1);

        // Check the quark operations
        assertEq(result.quarkOperations.length, 1, "one operation");
        assertEq(
            result.quarkOperations[0].scriptAddress,
            paycallAddress,
            "script address is correct given the code jar address on mainnet"
        );
        assertEq(
            result.quarkOperations[0].scriptCalldata,
            abi.encodeWithSelector(
                Paycall.run.selector,
                cometRepayAndWithdrawMultipleAssetsAddress,
                abi.encodeWithSelector(
                    CometRepayAndWithdrawMultipleAssets.run.selector,
                    COMET_1,
                    collateralAssets,
                    collateralAmounts,
                    weth_(1),
                    1e18
                ),
                0.5e6
            ),
            "calldata is Paycall.run(CometRepayAndWithdrawMultipleAssets.run(COMET_1, [USDC_1], [1e6], WETH_1, 1e18), 0.5e6);"
        );

        assertEq(result.quarkOperations[0].scriptSources.length, 2);
        assertEq(result.quarkOperations[0].scriptSources[0], type(CometRepayAndWithdrawMultipleAssets).creationCode);
        assertEq(
            result.quarkOperations[0].scriptSources[1],
            abi.encodePacked(type(Paycall).creationCode, abi.encode(ETH_USD_PRICE_FEED_1, USDC_1))
        );
        assertEq(
            result.quarkOperations[0].expiry, BLOCK_TIMESTAMP + 7 days, "expiry is current blockTimestamp + 7 days"
        );

        // check the actions
        assertEq(result.actions.length, 1, "one action");
        assertEq(result.actions[0].chainId, 1, "operation is on chainid 1");
        assertEq(result.actions[0].quarkAccount, address(0xa11ce), "0xa11ce sends the funds");
        assertEq(result.actions[0].actionType, "REPAY", "action type is 'REPAY'");
        assertEq(result.actions[0].paymentMethod, "PAY_CALL", "payment method is 'PAY_CALL'");
        assertEq(result.actions[0].paymentToken, USDC_1, "payment token is USDC");
        assertEq(result.actions[0].paymentMaxCost, 0.5e6, "payment max is set to .5e6 in this test case");

        uint256[] memory collateralAssetPrices = new uint256[](1);
        collateralAssetPrices[0] = 1e8;

        assertEq(
            result.actions[0].actionContext,
            abi.encode(
                Actions.RepayActionContext({
                    amount: 1e18,
                    assetSymbol: "WETH",
                    chainId: 1,
                    collateralAmounts: collateralAmounts,
                    collateralAssetPrices: collateralAssetPrices,
                    collateralAssets: collateralAssets,
                    comet: COMET_1,
                    price: 3000e8,
                    token: weth_(1)
                })
            ),
            "action context encoded from RepayActionContext"
        );

        // TODO: Check the contents of the EIP712 data
        assertNotEq(result.eip712Data.digest, hex"", "non-empty digest");
        assertNotEq(result.eip712Data.domainSeparator, hex"", "non-empty domain separator");
        assertNotEq(result.eip712Data.hashStruct, hex"", "non-empty hashStruct");
    }

    function testCometRepayWithBridge() public {
        QuarkBuilder builder = new QuarkBuilder();

        PaymentInfo.PaymentMaxCost[] memory maxCosts = new PaymentInfo.PaymentMaxCost[](2);
        maxCosts[0] = PaymentInfo.PaymentMaxCost({chainId: 1, amount: 0.1e6});
        maxCosts[1] = PaymentInfo.PaymentMaxCost({chainId: 8453, amount: 0.2e6});

        string[] memory collateralAssetSymbols = new string[](1);
        collateralAssetSymbols[0] = "LINK";

        uint256[] memory collateralAmounts = new uint256[](1);
        collateralAmounts[0] = 1e18;

        ChainPortfolio[] memory chainPortfolios = new ChainPortfolio[](2);
        chainPortfolios[0] = ChainPortfolio({
            chainId: 1,
            account: address(0xa11ce),
            nextNonce: 12,
            assetSymbols: stringArray("USDC", "USDT", "LINK", "WETH"),
            assetBalances: uintArray(4e6, 0, 0, 0) // 4 USDC on mainnet
        });
        chainPortfolios[1] = ChainPortfolio({
            chainId: 8453,
            account: address(0xb0b),
            nextNonce: 2,
            assetSymbols: stringArray("USDC", "USDT", "LINK", "WETH"),
            assetBalances: uintArray(0, 0, 0, 0) // no assets on base
        });

        QuarkBuilder.BuilderResult memory result = builder.cometRepay(
            repayIntent_(
                2e6,
                "USDC", // repaying 2 USDC, bridged from mainnet to base
                8453,
                collateralAmounts,
                collateralAssetSymbols
            ),
            chainAccountsFromChainPortfolios(chainPortfolios),
            paymentUsdc_(maxCosts)
        );

        address paycallAddress = paycallUsdc_(1);
        address paycallAddressBase = paycallUsdc_(8453);
        address cctpBridgeActionsAddress = CodeJarHelper.getCodeAddress(type(CCTPBridgeActions).creationCode);
        address cometRepayAndWithdrawMultipleAssetsAddress =
            CodeJarHelper.getCodeAddress(type(CometRepayAndWithdrawMultipleAssets).creationCode);

        assertEq(result.paymentCurrency, "usdc", "usdc currency");

        // Check the quark operations
        // first operation
        assertEq(result.quarkOperations.length, 2, "two operations");
        assertEq(
            result.quarkOperations[0].scriptAddress,
            paycallAddress,
            "script address is correct given the code jar address on base"
        );
        assertEq(
            result.quarkOperations[0].scriptCalldata,
            abi.encodeWithSelector(
                Paycall.run.selector,
                cctpBridgeActionsAddress,
                abi.encodeWithSelector(
                    CCTPBridgeActions.bridgeUSDC.selector,
                    address(0xBd3fa81B58Ba92a82136038B25aDec7066af3155),
                    2.2e6, // 2e6 repaid + 0.2e6 max cost on Base
                    6,
                    bytes32(uint256(uint160(0xa11ce))),
                    usdc_(1)
                ),
                0.1e6
            ),
            "calldata is Paycall.run(CCTPBridgeActions.bridgeUSDC(0xBd3fa81B58Ba92a82136038B25aDec7066af3155, 2.2e6, 6, 0xa11ce, USDC_1)), 0.1e6);"
        );
        assertEq(result.quarkOperations[0].scriptSources.length, 2);
        assertEq(result.quarkOperations[0].scriptSources[0], type(CCTPBridgeActions).creationCode);
        assertEq(
            result.quarkOperations[0].scriptSources[1],
            abi.encodePacked(type(Paycall).creationCode, abi.encode(ETH_USD_PRICE_FEED_1, USDC_1))
        );
        assertEq(
            result.quarkOperations[0].expiry, BLOCK_TIMESTAMP + 7 days, "expiry is current blockTimestamp + 7 days"
        );

        // second operation
        assertEq(
            result.quarkOperations[1].scriptAddress,
            paycallAddressBase,
            "script address[1] has been wrapped with paycall address"
        );

        address[] memory collateralAssets = new address[](1);
        collateralAssets[0] = link_(8453);

        assertEq(
            result.quarkOperations[1].scriptCalldata,
            abi.encodeWithSelector(
                Paycall.run.selector,
                cometRepayAndWithdrawMultipleAssetsAddress,
                abi.encodeWithSelector(
                    CometRepayAndWithdrawMultipleAssets.run.selector,
                    COMET_1,
                    collateralAssets,
                    collateralAmounts,
                    usdc_(8453),
                    2e6
                ),
                0.2e6
            ),
            "calldata is Paycall.run(CometRepayAndWithdrawMultipleAssets.run(COMET_1, [LINK_8453], [1e18], USDC_8453, 2e6), 0.2e6);"
        );
        assertEq(result.quarkOperations[1].scriptSources.length, 2);
        assertEq(result.quarkOperations[1].scriptSources[0], type(CometRepayAndWithdrawMultipleAssets).creationCode);
        assertEq(
            result.quarkOperations[1].scriptSources[1],
            abi.encodePacked(type(Paycall).creationCode, abi.encode(ETH_USD_PRICE_FEED_8453, USDC_8453))
        );
        assertEq(
            result.quarkOperations[1].expiry, BLOCK_TIMESTAMP + 7 days, "expiry is current blockTimestamp + 7 days"
        );

        // Check the actions
        assertEq(result.actions.length, 2, "two actions");
        // first action
        assertEq(result.actions[0].chainId, 1, "operation is on chainid 1");
        assertEq(result.actions[0].quarkAccount, address(0xa11ce), "0xa11ce sends the funds");
        assertEq(result.actions[0].actionType, "BRIDGE", "action type is 'BRIDGE'");
        assertEq(result.actions[0].paymentMethod, "PAY_CALL", "payment method is 'PAY_CALL'");
        assertEq(result.actions[0].paymentToken, USDC_1, "payment token is USDC on mainnet");
        assertEq(result.actions[0].paymentMaxCost, 0.1e6, "payment should have max cost of 0.1e6");
        assertEq(
            result.actions[0].actionContext,
            abi.encode(
                Actions.BridgeActionContext({
                    amount: 2.2e6,
                    price: 1e8,
                    token: USDC_1,
                    assetSymbol: "USDC",
                    chainId: 1,
                    recipient: address(0xa11ce),
                    destinationChainId: 8453,
                    bridgeType: Actions.BRIDGE_TYPE_CCTP
                })
            ),
            "action context encoded from BridgeActionContext"
        );
        // second action
        assertEq(result.actions[1].chainId, 8453, "operation is on chainid 8453");
        assertEq(result.actions[1].quarkAccount, address(0xa11ce), "0xa11ce sends the funds");
        assertEq(result.actions[1].actionType, "REPAY", "action type is 'REPAY'");
        assertEq(result.actions[1].paymentMethod, "PAY_CALL", "payment method is 'PAY_CALL'");
        assertEq(result.actions[1].paymentToken, USDC_8453, "payment token is USDC on Base");
        assertEq(result.actions[1].paymentMaxCost, 0.2e6, "payment should have max cost of 0.2e6");

        uint256[] memory collateralAssetPrices = new uint256[](1);
        collateralAssetPrices[0] = 14e8;

        assertEq(
            result.actions[1].actionContext,
            abi.encode(
                Actions.RepayActionContext({
                    amount: 2e6,
                    assetSymbol: "USDC",
                    chainId: 8453,
                    collateralAmounts: collateralAmounts,
                    collateralAssetPrices: collateralAssetPrices,
                    collateralAssets: collateralAssets,
                    comet: COMET_1,
                    price: 1e8,
                    token: usdc_(8453)
                })
            ),
            "action context encoded from RepayActionContext"
        );

        // TODO: Check the contents of the EIP712 data
        assertNotEq(result.eip712Data.digest, hex"", "non-empty digest");
        assertNotEq(result.eip712Data.domainSeparator, hex"", "non-empty domain separator");
        assertNotEq(result.eip712Data.hashStruct, hex"", "non-empty hashStruct");
    }
}