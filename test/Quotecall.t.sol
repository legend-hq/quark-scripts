// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.27;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "forge-std/StdUtils.sol";

import {CodeJar} from "codejar/src/CodeJar.sol";

import {QuarkWallet} from "quark-core/src/QuarkWallet.sol";
import {QuarkNonceManager} from "quark-core/src/QuarkNonceManager.sol";

import {QuarkWalletProxyFactory} from "quark-proxy/src/QuarkWalletProxyFactory.sol";

import {Ethcall} from "quark-core-scripts/src/Ethcall.sol";
import {Multicall} from "quark-core-scripts/src/Multicall.sol";

import {Counter} from "test/lib/Counter.sol";
import {Reverts} from "test/lib/Reverts.sol";

import {YulHelper} from "test/lib/YulHelper.sol";
import {SignatureHelper} from "test/lib/SignatureHelper.sol";
import {QuarkOperationHelper, ScriptType} from "test/lib/QuarkOperationHelper.sol";
import "quark-core-scripts/src/vendor/chainlink/AggregatorV3Interface.sol";

import {IComet, IERC20} from "src/DeFiScripts.sol";
import {Quotecall} from "src/Quotecall.sol";

contract QuotecallTest is Test {
    event PayForGas(address indexed payer, address indexed payee, address indexed paymentToken, uint256 amount);

    QuarkWalletProxyFactory public factory;
    Counter public counter;
    uint256 alicePrivateKey = 0xa11ce;
    address alice = vm.addr(alicePrivateKey);
    CodeJar codeJar;

    // Comet address in mainnet
    address constant cUSDCv3 = 0xc3d688B66703497DAA19211EEdff47f25384cdc3;
    address constant cWETHv3 = 0xA17581A9E3356d9A858b789D68B4d866e593aE94;
    address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address constant USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address constant WBTC = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;

    bytes multicall = new YulHelper().getCode("Multicall.sol/Multicall.json");
    bytes ethcall = new YulHelper().getCode("Ethcall.sol/Ethcall.json");
    bytes reverts = new YulHelper().getCode("Reverts.sol/Reverts.json");

    bytes cometSupplyScript = new YulHelper().getCode("DeFiScripts.sol/CometSupplyActions.json");

    bytes cometWithdrawScript = new YulHelper().getCode("DeFiScripts.sol/CometWithdrawActions.json");

    bytes uniswapSwapScript = new YulHelper().getCode("DeFiScripts.sol/UniswapSwapActions.json");

    address ethcallAddress;
    address multicallAddress;
    address revertsAddress;
    bytes quotecall;
    address quotecallAddress;
    address cometSupplyScriptAddress;
    address cometWithdrawScriptAddress;
    address uniswapSwapScriptAddress;

    function setUp() public {
        vm.createSelectFork(
            vm.envString("MAINNET_RPC_URL"),
            18429607 // 2023-10-25 13:24:00 PST
        );
        factory = new QuarkWalletProxyFactory(address(new QuarkWallet(new CodeJar(), new QuarkNonceManager())));
        counter = new Counter();
        counter.setNumber(0);

        codeJar = QuarkWallet(payable(factory.walletImplementation())).codeJar();
        ethcallAddress = codeJar.saveCode(ethcall);
        multicallAddress = codeJar.saveCode(multicall);
        revertsAddress = codeJar.saveCode(reverts);

        quotecall = abi.encodePacked(type(Quotecall).creationCode);
        quotecallAddress = codeJar.saveCode(quotecall);

        cometSupplyScriptAddress = codeJar.saveCode(cometSupplyScript);
        cometWithdrawScriptAddress = codeJar.saveCode(cometWithdrawScript);
        uniswapSwapScriptAddress = codeJar.saveCode(uniswapSwapScript);
    }

    /* ===== call context-based tests ===== */

    function testInitializeProperlyFromConstructor() public {
        // There are no public variables to check
    }

    function testRevertsForInvalidCallContext() public {
        Quotecall quotecallContract = Quotecall(quotecallAddress);
        // Direct calls fail when called directly
        vm.expectRevert(abi.encodeWithSelector(Quotecall.InvalidCallContext.selector));
        quotecallContract.run(
            ethcallAddress,
            abi.encodeWithSelector(
                Quotecall.run.selector,
                address(counter),
                abi.encodeCall(Counter.setNumber, (1)),
                0 // value
            ),
            USDC,
            10e6
        );
    }

    /* ===== general tests ===== */

    function testPayWithUSDCAndNoDelegatecall() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));
        // Give wallet some USDC for payment
        deal(USDC, address(wallet), 1000e6);

        // Execute through quotecall
        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            quotecall,
            abi.encodeWithSelector(Quotecall.run.selector, address(0), "", USDC, 10e6),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        // gas: meter execute
        vm.resumeGasMetering();
        vm.expectEmit(true, true, true, true);
        emit PayForGas(address(wallet), tx.origin, USDC, 10e6);
        wallet.executeQuarkOperation(op, signature);

        assertEq(IERC20(USDC).balanceOf(address(wallet)), 990e6);
    }

    function testSimpleCounterAndPayWithUSDC() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));
        // Give wallet some USDC for payment
        deal(USDC, address(wallet), 1000e6);

        // Compose array of parameters
        address[] memory callContracts = new address[](2);
        bytes[] memory callDatas = new bytes[](2);
        callContracts[0] = ethcallAddress;
        callDatas[0] = abi.encodeWithSelector(
            Ethcall.run.selector,
            address(counter),
            abi.encodeWithSignature("increment(uint256)", (20)),
            0 // value
        );
        callContracts[1] = ethcallAddress;
        callDatas[1] = abi.encodeWithSelector(
            Ethcall.run.selector,
            address(counter),
            abi.encodeWithSignature("decrement(uint256)", (5)),
            0 // value
        );
        assertEq(counter.number(), 0);

        // Execute through quotecall
        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            quotecall,
            abi.encodeWithSelector(
                Quotecall.run.selector,
                multicallAddress,
                abi.encodeWithSelector(Multicall.run.selector, callContracts, callDatas),
                USDC,
                10e6
            ),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        // gas: meter execute
        vm.resumeGasMetering();
        vm.expectEmit(true, true, true, true);
        emit PayForGas(address(wallet), tx.origin, USDC, 10e6);
        wallet.executeQuarkOperation(op, signature);

        assertEq(counter.number(), 15);
        assertEq(IERC20(USDC).balanceOf(address(wallet)), 990e6);
    }

    function testSimpleTransferTokenAndPayWithUSDC() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));
        // Give wallet some USDC for payment
        deal(USDC, address(wallet), 1000e6);

        // Execute through quotecall
        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            quotecall,
            abi.encodeWithSelector(
                Quotecall.run.selector,
                ethcallAddress,
                abi.encodeWithSelector(
                    Ethcall.run.selector,
                    USDC,
                    abi.encodeWithSignature("transfer(address,uint256)", address(this), 10e6),
                    0
                ),
                USDC,
                10e6
            ),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        // gas: meter execute
        vm.resumeGasMetering();
        vm.expectEmit(true, true, true, true);
        emit PayForGas(address(wallet), tx.origin, USDC, 10e6);
        wallet.executeQuarkOperation(op, signature);

        assertEq(IERC20(USDC).balanceOf(address(wallet)), 980e6);
        assertEq(IERC20(USDC).balanceOf(address(this)), 10e6);
    }

    function testReturnCallResult() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));

        counter.setNumber(5);
        // Deal some USDC
        deal(USDC, address(wallet), 1000e6);
        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            quotecall,
            abi.encodeWithSelector(
                Quotecall.run.selector,
                ethcallAddress,
                abi.encodeWithSelector(
                    Ethcall.run.selector, address(counter), abi.encodeWithSignature("decrement(uint256)", (1)), 0
                ),
                USDC,
                8e6
            ),
            ScriptType.ScriptSource
        );

        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        // gas: meter execute
        vm.resumeGasMetering();
        bytes memory quarkReturn = wallet.executeQuarkOperation(op, signature);
        bytes memory returnData = abi.decode(quarkReturn, (bytes));
        bytes memory returnData2 = abi.decode(returnData, (bytes));

        assertEq(counter.number(), 4);
        assertEq(abi.decode(returnData2, (uint256)), 4);
    }

    function testQuotecallForPayWithUSDT() public {
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));

        // Deal some USDT and WETH
        deal(USDT, address(wallet), 1000e6);
        deal(WETH, address(wallet), 1 ether);

        // Pay with USDT
        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            quotecall,
            abi.encodeWithSelector(
                Quotecall.run.selector,
                ethcallAddress,
                abi.encodeWithSelector(
                    Ethcall.run.selector,
                    WETH,
                    abi.encodeWithSignature("transfer(address,uint256)", address(this), 1 ether),
                    0
                ),
                USDT,
                10e6
            ),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        vm.resumeGasMetering();
        vm.expectEmit(true, true, true, true);
        emit PayForGas(address(wallet), tx.origin, USDT, 10e6);
        wallet.executeQuarkOperation(op, signature);

        assertEq(IERC20(WETH).balanceOf(address(this)), 1 ether);
        // About $8 in USD fees
        assertEq(IERC20(USDT).balanceOf(address(wallet)), 990e6);
    }

    function testQuotecallForPayWithWBTC() public {
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));

        // Deal some WBTC and WETH
        deal(WBTC, address(wallet), 1e8);
        deal(WETH, address(wallet), 1 ether);

        // Pay with WBTC
        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            quotecall,
            abi.encodeWithSelector(
                Quotecall.run.selector,
                ethcallAddress,
                abi.encodeWithSelector(
                    Ethcall.run.selector,
                    WETH,
                    abi.encodeWithSignature("transfer(address,uint256)", address(this), 1 ether),
                    0
                ),
                WBTC,
                30e3
            ),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        vm.resumeGasMetering();
        vm.expectEmit(true, true, true, true);
        emit PayForGas(address(wallet), tx.origin, WBTC, 30e3);
        wallet.executeQuarkOperation(op, signature);

        assertEq(IERC20(WETH).balanceOf(address(this)), 1 ether);
        assertEq(IERC20(WBTC).balanceOf(address(wallet)), 99_970_000);
    }

    function testQuotecallRevertsWhenCallReverts() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));
        // Give wallet some USDC for payment
        deal(USDC, address(wallet), 1000e6);

        // Execute through quotecall
        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            quotecall,
            abi.encodeWithSelector(Quotecall.run.selector, revertsAddress, "", USDC, 8e6),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        // gas: meter execute
        vm.resumeGasMetering();
        vm.expectRevert(abi.encodeWithSelector(Reverts.Whoops.selector));
        wallet.executeQuarkOperation(op, signature);

        assertEq(IERC20(USDC).balanceOf(address(wallet)), 1000e6);
    }
}
