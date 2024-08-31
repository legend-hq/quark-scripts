// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.23;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "forge-std/StdUtils.sol";
import "forge-std/StdMath.sol";

import {CodeJar} from "codejar/src/CodeJar.sol";
import {IERC4626} from "openzeppelin/interfaces/IERC4626.sol";
import {QuarkWallet} from "quark-core/src/QuarkWallet.sol";
import {QuarkStateManager} from "quark-core/src/QuarkStateManager.sol";

import {QuarkWalletProxyFactory} from "quark-proxy/src/QuarkWalletProxyFactory.sol";

import {YulHelper} from "./lib/YulHelper.sol";
import {SignatureHelper} from "./lib/SignatureHelper.sol";
import {QuarkOperationHelper, ScriptType} from "./lib/QuarkOperationHelper.sol";

import {DeFiScriptErrors} from "src/lib/DeFiScriptErrors.sol";

import "src/DeFiScripts.sol";
import "src/defi_integrations/MorphoScripts.sol";

/**
 * Tests for supplying assets to Morpho Vault
 */
contract MorphoVaultActionsTest is Test {
    QuarkWalletProxyFactory public factory;
    uint256 alicePrivateKey = 0xa11ce;
    address alice = vm.addr(alicePrivateKey);

    // Contracts address on mainnet
    address constant morphoVault = 0x8eB67A509616cd6A7c1B3c8C21D48FF57df3d458;
    address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    bytes morphoVaultActionsScripts = new YulHelper().getCode("MorphoScripts.sol/MorphoVaultActions.json");

    function setUp() public {
        // Fork setup
        vm.createSelectFork(
            string.concat(
                "https://node-provider.compound.finance/ethereum-mainnet/", vm.envString("NODE_PROVIDER_BYPASS_KEY")
            ),
            20564787 // 2024-08-19 12:34:00 PST
        );
        factory = new QuarkWalletProxyFactory(address(new QuarkWallet(new CodeJar(), new QuarkStateManager())));
    }

    function testDeposit() public {
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));

        deal(USDC, address(wallet), 10_000e6);

        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            morphoVaultActionsScripts,
            abi.encodeWithSelector(MorphoVaultActions.deposit.selector, morphoVault, USDC, 10_000e6),
            ScriptType.ScriptSource
        );
        (uint8 v, bytes32 r, bytes32 s) = new SignatureHelper().signOp(alicePrivateKey, wallet, op);
        assertEq(IERC20(USDC).balanceOf(address(wallet)), 10_000e6);
        assertEq(IERC4626(morphoVault).balanceOf(address(wallet)), 0);
        vm.resumeGasMetering();
        wallet.executeQuarkOperation(op, v, r, s);
        assertEq(IERC20(USDC).balanceOf(address(wallet)), 0);
        assertApproxEqAbs(IERC4626(morphoVault).balanceOf(address(wallet)), 9713.4779e18, 0.01e18);
    }

    function testMint() public {
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));

        deal(USDC, address(wallet), 10_000e6);

        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            morphoVaultActionsScripts,
            abi.encodeWithSelector(MorphoVaultActions.mint.selector, morphoVault, USDC, 9000e18),
            ScriptType.ScriptSource
        );
        (uint8 v, bytes32 r, bytes32 s) = new SignatureHelper().signOp(alicePrivateKey, wallet, op);
        assertEq(IERC20(USDC).balanceOf(address(wallet)), 10_000e6);
        assertEq(IERC4626(morphoVault).balanceOf(address(wallet)), 0);
        vm.resumeGasMetering();
        wallet.executeQuarkOperation(op, v, r, s);
        assertApproxEqAbs(IERC20(USDC).balanceOf(address(wallet)), 734.5e6, 1e6);
        assertEq(IERC4626(morphoVault).balanceOf(address(wallet)), 9000e18);
    }

    function testWithdraw() public {
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));

        // Deal vault shares to wallet, ERC4262 is ERC20 compatible
        deal(morphoVault, address(wallet), 10_000e18);

        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            morphoVaultActionsScripts,
            abi.encodeWithSelector(MorphoVaultActions.withdraw.selector, morphoVault, 10_000e6),
            ScriptType.ScriptSource
        );
        (uint8 v, bytes32 r, bytes32 s) = new SignatureHelper().signOp(alicePrivateKey, wallet, op);
        assertEq(IERC20(USDC).balanceOf(address(wallet)), 0e6);
        assertEq(IERC4626(morphoVault).balanceOf(address(wallet)), 10_000e18);
        vm.resumeGasMetering();
        wallet.executeQuarkOperation(op, v, r, s);
        assertEq(IERC20(USDC).balanceOf(address(wallet)), 10_000e6);
        assertApproxEqAbs(IERC4626(morphoVault).balanceOf(address(wallet)), 286.5e18, 1e18);
    }

    function testRedeem() public {
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));

        // Deal vault shares to wallet, ERC4262 is ERC20 compatible
        deal(morphoVault, address(wallet), 10_000e18);

        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            morphoVaultActionsScripts,
            abi.encodeWithSelector(MorphoVaultActions.redeem.selector, morphoVault, 10_000e18),
            ScriptType.ScriptSource
        );
        (uint8 v, bytes32 r, bytes32 s) = new SignatureHelper().signOp(alicePrivateKey, wallet, op);
        assertEq(IERC20(USDC).balanceOf(address(wallet)), 0e6);
        assertEq(IERC4626(morphoVault).balanceOf(address(wallet)), 10_000e18);
        vm.resumeGasMetering();
        wallet.executeQuarkOperation(op, v, r, s);
        assertApproxEqAbs(IERC20(USDC).balanceOf(address(wallet)), 10_294e6, 1e6);
        assertEq(IERC4626(morphoVault).balanceOf(address(wallet)), 0e18);
    }
}