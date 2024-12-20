// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.27;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "forge-std/StdUtils.sol";

import {CodeJar} from "codejar/src/CodeJar.sol";

import {QuarkWallet} from "quark-core/src/QuarkWallet.sol";
import {QuarkNonceManager} from "quark-core/src/QuarkNonceManager.sol";

import {QuarkWalletProxyFactory} from "quark-proxy/src/QuarkWalletProxyFactory.sol";

import {Ethcall} from "src/Ethcall.sol";
import {Multicall} from "src/Multicall.sol";

import {Counter} from "./lib/Counter.sol";

import {YulHelper} from "./lib/YulHelper.sol";
import {SignatureHelper} from "./lib/SignatureHelper.sol";
import {QuarkOperationHelper, ScriptType} from "./lib/QuarkOperationHelper.sol";

import "src/DeFiScripts.sol";

contract MulticallTest is Test {
    QuarkWalletProxyFactory public factory;
    Counter public counter;
    uint256 alicePrivateKey = 0xa11ce;
    address alice = vm.addr(alicePrivateKey);

    // Comet address in mainnet
    address constant cUSDCv3 = 0xc3d688B66703497DAA19211EEdff47f25384cdc3;
    address constant cWETHv3 = 0xA17581A9E3356d9A858b789D68B4d866e593aE94;
    address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    // Uniswap router info on mainnet
    address constant uniswapRouter = 0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45;
    bytes ethcall = new YulHelper().getCode("Ethcall.sol/Ethcall.json");
    bytes multicall;

    bytes cometSupplyScript = new YulHelper().getCode("DeFiScripts.sol/CometSupplyActions.json");

    bytes cometWithdrawScript = new YulHelper().getCode("DeFiScripts.sol/CometWithdrawActions.json");

    bytes uniswapSwapScript = new YulHelper().getCode("DeFiScripts.sol/UniswapSwapActions.json");

    address ethcallAddress;
    address multicallAddress;
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

        CodeJar codeJar = QuarkWallet(payable(factory.walletImplementation())).codeJar();
        ethcallAddress = codeJar.saveCode(ethcall);
        multicall = type(Multicall).creationCode;
        multicallAddress = codeJar.saveCode(multicall);
        cometSupplyScriptAddress = codeJar.saveCode(cometSupplyScript);
        cometWithdrawScriptAddress = codeJar.saveCode(cometWithdrawScript);
        uniswapSwapScriptAddress = codeJar.saveCode(uniswapSwapScript);
    }

    /* ===== call context-based tests ===== */
    function testRevertsForInvalidCallContext() public {
        // Direct calls succeed when uninitialized
        address[] memory callContracts = new address[](0);
        bytes[] memory callDatas = new bytes[](0);
        Multicall multicallContract = Multicall(multicallAddress);

        // Direct calls fail once initialized
        vm.expectRevert(abi.encodeWithSelector(Multicall.InvalidCallContext.selector));
        multicallContract.run(callContracts, callDatas);
    }

    function testCallcodeToMulticallSucceedsWhenUninitialized() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));
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

        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            multicall,
            abi.encodeWithSelector(Multicall.run.selector, callContracts, callDatas),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        // gas: meter execute
        vm.resumeGasMetering();
        wallet.executeQuarkOperation(op, signature);
        assertEq(counter.number(), 15);
    }

    /* ===== general tests ===== */

    function testInvokeCounterTwice() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));
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

        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            multicall,
            abi.encodeWithSelector(Multicall.run.selector, callContracts, callDatas),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        // gas: meter execute
        vm.resumeGasMetering();
        wallet.executeQuarkOperation(op, signature);
        assertEq(counter.number(), 15);
    }

    function testSupplyWETHWithdrawUSDCOnComet() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));
        // Set up some funds for test
        deal(WETH, address(wallet), 100 ether);

        // Compose array of parameters
        address[] memory callContracts = new address[](3);
        bytes[] memory callDatas = new bytes[](3);

        // Approve Comet to spend USDC
        callContracts[0] = ethcallAddress;
        callDatas[0] = abi.encodeWithSelector(
            Ethcall.run.selector,
            WETH,
            abi.encodeCall(IERC20.approve, (cUSDCv3, 100 ether)),
            0 // value
        );
        // Supply WETH to Comet
        callContracts[1] = ethcallAddress;
        callDatas[1] = abi.encodeWithSelector(
            Ethcall.run.selector,
            cUSDCv3,
            abi.encodeCall(IComet.supply, (WETH, 100 ether)),
            0 // value
        );
        // Withdraw USDC from Comet
        callContracts[2] = ethcallAddress;
        callDatas[2] = abi.encodeWithSelector(
            Ethcall.run.selector,
            cUSDCv3,
            abi.encodeCall(IComet.withdraw, (USDC, 1000e6)),
            0 // value
        );

        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            multicall,
            abi.encodeWithSelector(Multicall.run.selector, callContracts, callDatas),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        // gas: meter execute
        vm.resumeGasMetering();
        wallet.executeQuarkOperation(op, signature);
        assertEq(IERC20(USDC).balanceOf(address(wallet)), 1000e6);
        assertEq(IComet(cUSDCv3).collateralBalanceOf(address(wallet), WETH), 100 ether);
        assertApproxEqAbs(IComet(cUSDCv3).borrowBalanceOf(address(wallet)), 1000e6, 2);
    }

    function testInvalidInput() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));
        // Compose array of parameters
        address[] memory callContracts = new address[](2);
        bytes[] memory callDatas = new bytes[](1);
        callContracts[0] = ethcallAddress;
        callDatas[0] = abi.encodeWithSelector(
            Ethcall.run.selector,
            address(counter),
            abi.encodeWithSignature("increment(uint256)", (20)),
            0 // value
        );
        callContracts[1] = address(counter);

        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            multicall,
            abi.encodeWithSelector(Multicall.run.selector, callContracts, callDatas),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        // gas: meter execute
        vm.expectRevert(abi.encodeWithSelector(Multicall.InvalidInput.selector));
        vm.resumeGasMetering();
        wallet.executeQuarkOperation(op, signature);
    }

    function testMulticallError() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));
        // Set up some funds for test
        deal(WETH, address(wallet), 100 ether);

        // Compose array of parameters
        address[] memory callContracts = new address[](4);
        bytes[] memory callDatas = new bytes[](4);

        // Approve Comet to spend WETH
        callContracts[0] = ethcallAddress;
        callDatas[0] = abi.encodeWithSelector(
            Ethcall.run.selector,
            WETH,
            abi.encodeCall(IERC20.approve, (cUSDCv3, 100 ether)),
            0 // value
        );
        // Supply WETH to Comet
        callContracts[1] = ethcallAddress;
        callDatas[1] = abi.encodeWithSelector(
            Ethcall.run.selector,
            cUSDCv3,
            abi.encodeCall(IComet.supply, (WETH, 100 ether)),
            0 // value
        );

        // Withdraw USDC from Comet
        callContracts[2] = ethcallAddress;
        callDatas[2] = abi.encodeWithSelector(
            Ethcall.run.selector,
            cUSDCv3,
            abi.encodeCall(IComet.withdraw, (USDC, 1000e6)),
            0 // value
        );
        // Send USDC to Stranger; will fail (insufficient balance)
        callContracts[3] = ethcallAddress;
        callDatas[3] = abi.encodeWithSelector(
            Ethcall.run.selector,
            USDC,
            abi.encodeCall(IERC20.transfer, (address(123), 10_000e6)),
            0 // value
        );

        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            multicall,
            abi.encodeWithSelector(Multicall.run.selector, callContracts, callDatas),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        // gas: meter execute
        vm.expectRevert(
            abi.encodeWithSelector(
                Multicall.MulticallError.selector,
                3,
                callContracts[3],
                abi.encodeWithSignature("Error(string)", "ERC20: transfer amount exceeds balance")
            )
        );
        vm.resumeGasMetering();
        wallet.executeQuarkOperation(op, signature);
    }

    function testEmptyInputIsValid() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));
        // Compose array of parameters
        address[] memory callContracts = new address[](0);
        bytes[] memory callDatas = new bytes[](0);

        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            multicall,
            abi.encodeWithSelector(Multicall.run.selector, callContracts, callDatas),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        // gas: meter execute
        vm.resumeGasMetering();
        // Empty array is a valid input representing a no-op, and it should not revert
        wallet.executeQuarkOperation(op, signature);
    }

    function testMulticallShouldReturnCallResults() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));
        counter.setNumber(0);
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

        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            multicall,
            abi.encodeWithSelector(Multicall.run.selector, callContracts, callDatas),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        // gas: meter execute
        vm.resumeGasMetering();
        bytes memory quarkReturn = wallet.executeQuarkOperation(op, signature);

        bytes[] memory returnDatas = abi.decode(quarkReturn, (bytes[]));
        assertEq(counter.number(), 15);
        assertEq(returnDatas.length, 2);
        assertEq(abi.decode(returnDatas[0], (bytes)).length, 0);
        assertEq(abi.decode(abi.decode(returnDatas[1], (bytes)), (uint256)), 15);
    }

    function testExecutorCanMulticallAcrossSubwallets() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();

        QuarkWallet primary = QuarkWallet(factory.create(alice, address(0)));
        QuarkWallet walletA = QuarkWallet(factory.create(alice, address(primary), bytes32("a")));
        QuarkWallet walletB = QuarkWallet(factory.create(alice, address(primary), bytes32("b")));

        // give sub-wallet A 1 WETH
        deal(WETH, address(walletA), 1 ether);

        // compose cross-wallet interaction
        address[] memory wallets = new address[](3);
        bytes[] memory walletCalls = new bytes[](3);

        // 1. transfer 0.5 WETH from wallet A to wallet B
        wallets[0] = address(walletA);
        walletCalls[0] = abi.encodeWithSignature(
            "executeScript(bytes32,address,bytes,bytes[])",
            new QuarkOperationHelper().semiRandomNonce(
                QuarkWallet(payable(factory.walletImplementation())).nonceManager(), walletA
            ),
            ethcallAddress,
            abi.encodeWithSelector(
                Ethcall.run.selector,
                WETH,
                abi.encodeCall(IERC20.transfer, (address(walletB), 0.5 ether)),
                0 // value
            ),
            new bytes[](0)
        );

        // 2. approve Comet cUSDCv3 to receive 0.5 WETH from wallet B
        bytes32 walletBNextNonce = new QuarkOperationHelper().semiRandomNonce(
            QuarkWallet(payable(factory.walletImplementation())).nonceManager(), walletB
        );
        wallets[1] = address(walletB);
        walletCalls[1] = abi.encodeWithSignature(
            "executeScript(bytes32,address,bytes,bytes[])",
            walletBNextNonce,
            ethcallAddress,
            abi.encodeWithSelector(
                Ethcall.run.selector,
                WETH,
                abi.encodeCall(IERC20.approve, (cUSDCv3, 0.5 ether)),
                0 // value
            ),
            new bytes[](0)
        );

        // 3. supply 0.5 WETH from wallet B to Comet cUSDCv3
        wallets[2] = address(walletB);
        walletCalls[2] = abi.encodeWithSignature(
            "executeScript(bytes32,address,bytes,bytes[])",
            bytes32(uint256(walletBNextNonce) + 1),
            ethcallAddress,
            abi.encodeWithSelector(
                Ethcall.run.selector,
                cUSDCv3,
                abi.encodeCall(IComet.supply, (WETH, 0.5 ether)),
                0 // value
            ),
            new bytes[](0)
        );

        // okay, woof, now wrap all that in ethcalls...
        address[] memory targets = new address[](3);
        targets[0] = ethcallAddress;
        targets[1] = ethcallAddress;
        targets[2] = ethcallAddress;
        bytes[] memory calls = new bytes[](3);
        calls[0] = abi.encodeCall(
            Ethcall.run,
            (
                wallets[0],
                walletCalls[0],
                0 // value
            )
        );
        calls[1] = abi.encodeCall(
            Ethcall.run,
            (
                wallets[1],
                walletCalls[1],
                0 // value
            )
        );
        calls[2] = abi.encodeCall(
            Ethcall.run,
            (
                wallets[2],
                walletCalls[2],
                0 // value
            )
        );

        // set up the primary operation to execute the cross-wallet supply
        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            primary, multicall, abi.encodeWithSelector(Multicall.run.selector, targets, calls), ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, primary, op);

        // gas: meter execute
        vm.resumeGasMetering();

        primary.executeQuarkOperation(op, signature);
        // wallet A should still have 0.5 ether...
        assertEq(IERC20(WETH).balanceOf(address(walletA)), 0.5 ether);
        // wallet B should have 0 ether...
        assertEq(IERC20(WETH).balanceOf(address(walletB)), 0 ether);
        // wallet B should have a supply balance of 0.5 ether
        assertEq(IComet(cUSDCv3).collateralBalanceOf(address(walletB), WETH), 0.5 ether);
    }

    // It's a proof of concept that user can create and execute on new subwallet with the help of Multicall without needing to do in two transactions
    function testCreateSubWalletAndExecute() public {
        vm.pauseGasMetering();
        // User will borrow USDC from Comet in the primary wallet and supply to a subwallet
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));
        // Set up some funds for test
        deal(WETH, address(wallet), 100 ether);

        address subWallet1 = factory.walletAddressForSalt(alice, address(wallet), bytes32("1"));
        bytes32 nonce = new QuarkOperationHelper().semiRandomNonce(
            QuarkWallet(payable(factory.walletImplementation())).nonceManager(), QuarkWallet(payable(subWallet1))
        );

        // Steps: Wallet#1: Supply WETH to Comet -> Borrow USDC from Comet(USDC) to subwallet -> Create subwallet
        // -> Swap USDC to WETH on Uniswap -> Supply WETH to Comet(WETH)
        address[] memory callContracts = new address[](5);
        bytes[] memory callDatas = new bytes[](5);

        callContracts[0] = cometSupplyScriptAddress;
        callDatas[0] = abi.encodeCall(CometSupplyActions.supply, (cUSDCv3, WETH, 100 ether));
        callContracts[1] = cometWithdrawScriptAddress;
        callDatas[1] = abi.encodeCall(CometWithdrawActions.withdrawTo, (cUSDCv3, subWallet1, USDC, 10_000e6));

        callContracts[2] = ethcallAddress;
        callDatas[2] = abi.encodeWithSelector(
            Ethcall.run.selector,
            address(factory),
            abi.encodeWithSignature("create(address,address,bytes32)", alice, address(wallet), bytes32("1")),
            0 // value
        );

        callContracts[3] = ethcallAddress;
        callDatas[3] = abi.encodeWithSelector(
            Ethcall.run.selector,
            subWallet1,
            abi.encodeCall(
                QuarkWallet.executeScript,
                (
                    nonce,
                    uniswapSwapScriptAddress,
                    abi.encodeCall(
                        UniswapSwapActions.swapAssetExactIn,
                        (
                            UniswapSwapActions.SwapParamsExactIn({
                                uniswapRouter: uniswapRouter,
                                recipient: subWallet1,
                                tokenFrom: USDC,
                                amount: 5000e6,
                                amountOutMinimum: 2 ether,
                                path: abi.encodePacked(USDC, uint24(500), WETH) // Path: USDC - 0.05% -> WETH
                            })
                        )
                    ),
                    new bytes[](0)
                )
            ),
            0 // value
        );

        callContracts[4] = ethcallAddress;
        callDatas[4] = abi.encodeWithSelector(
            Ethcall.run.selector,
            subWallet1,
            abi.encodeCall(
                QuarkWallet.executeScript,
                (
                    new QuarkOperationHelper().incrementNonce(nonce),
                    cometSupplyScriptAddress,
                    abi.encodeCall(CometSupplyActions.supply, (cWETHv3, WETH, 2 ether)),
                    new bytes[](0)
                )
            ),
            0 // value
        );

        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            multicall,
            abi.encodeWithSelector(Multicall.run.selector, callContracts, callDatas),
            ScriptType.ScriptAddress
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        vm.resumeGasMetering();
        wallet.executeQuarkOperation(op, signature);
        assertEq(IComet(cUSDCv3).collateralBalanceOf(address(wallet), WETH), 100 ether);
        assertEq(IComet(cUSDCv3).borrowBalanceOf(address(wallet)), 10_000e6);
        assertApproxEqAbs(IComet(cWETHv3).balanceOf(address(subWallet1)), 2 ether, 1);
    }
}
