// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.27;

import "forge-std/Test.sol";
import "forge-std/StdUtils.sol";

import {CodeJar} from "codejar/src/CodeJar.sol";

import {QuarkWallet} from "quark-core/src/QuarkWallet.sol";
import {QuarkNonceManager} from "quark-core/src/QuarkNonceManager.sol";

import {QuarkWalletProxyFactory} from "quark-proxy/src/QuarkWalletProxyFactory.sol";

import {YulHelper} from "test/lib/YulHelper.sol";
import {SignatureHelper} from "test/lib/SignatureHelper.sol";
import {QuarkOperationHelper, ScriptType} from "test/lib/QuarkOperationHelper.sol";

import {IERC20} from "src/DeFiScripts.sol";
import {QuotePay} from "src/QuotePay.sol";

contract QuotePayTest is Test {
    event PayQuote(
        address indexed payer, address indexed payee, address indexed paymentToken, uint256 amount, bytes32 quoteId
    );

    QuarkWalletProxyFactory public factory;
    uint256 alicePrivateKey = 0xa11ce;
    address alice = vm.addr(alicePrivateKey);
    address payee;
    CodeJar codeJar;

    // Token addresses on mainnet
    address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address constant USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address constant WBTC = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;

    bytes32 constant QUOTE_ID = keccak256("QUOTE_ID");

    bytes quotePay;
    address quotePayAddress;

    function setUp() public {
        vm.createSelectFork(
            vm.envString("MAINNET_RPC_URL"),
            18429607 // 2023-10-25 13:24:00 PST
        );
        factory = new QuarkWalletProxyFactory(address(new QuarkWallet(new CodeJar(), new QuarkNonceManager())));

        codeJar = QuarkWallet(payable(factory.walletImplementation())).codeJar();

        quotePay = abi.encodePacked(type(QuotePay).creationCode);
        quotePayAddress = codeJar.saveCode(quotePay);

        payee = address(this);
    }

    /* ===== general tests ===== */

    function testQuotePayWithUSDC() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));
        // Give wallet some USDC for payment
        deal(USDC, address(wallet), 1000e6);

        // Execute through quotecall
        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            quotePay,
            abi.encodeWithSelector(QuotePay.run.selector, payee, USDC, 10e6, QUOTE_ID),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        // gas: meter execute
        vm.resumeGasMetering();
        vm.expectEmit(true, true, true, true);
        emit PayQuote(address(wallet), payee, USDC, 10e6, QUOTE_ID);
        wallet.executeQuarkOperation(op, signature);

        assertEq(IERC20(USDC).balanceOf(address(wallet)), 990e6);
        assertEq(IERC20(USDC).balanceOf(payee), 10e6);
    }

    function testQuotePayWithUSDT() public {
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));

        // Deal some USDT and WETH
        deal(USDT, address(wallet), 1000e6);

        // Pay with USDT
        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            quotePay,
            abi.encodeWithSelector(QuotePay.run.selector, payee, USDT, 10e6, QUOTE_ID),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        vm.resumeGasMetering();
        vm.expectEmit(true, true, true, true);
        emit PayQuote(address(wallet), payee, USDT, 10e6, QUOTE_ID);
        wallet.executeQuarkOperation(op, signature);

        assertEq(IERC20(USDT).balanceOf(address(wallet)), 990e6);
        assertEq(IERC20(USDT).balanceOf(payee), 10e6);
    }

    function testQuotePayWithWBTC() public {
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));

        // Deal some WBTC and WETH
        deal(WBTC, address(wallet), 1e8);

        // Pay with WBTC
        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            quotePay,
            abi.encodeWithSelector(QuotePay.run.selector, payee, WBTC, 30e3, QUOTE_ID),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        vm.resumeGasMetering();
        vm.expectEmit(true, true, true, true);
        emit PayQuote(address(wallet), payee, WBTC, 30e3, QUOTE_ID);
        wallet.executeQuarkOperation(op, signature);

        assertEq(IERC20(WBTC).balanceOf(address(wallet)), 99_970_000);
        assertEq(IERC20(WBTC).balanceOf(address(payee)), 30e3);
    }

    function testRevertsWhenNotEnoughTokens() public {
        // gas: do not meter set-up
        vm.pauseGasMetering();
        QuarkWallet wallet = QuarkWallet(factory.create(alice, address(0)));

        // Execute through quotecall
        QuarkWallet.QuarkOperation memory op = new QuarkOperationHelper().newBasicOpWithCalldata(
            wallet,
            quotePay,
            abi.encodeWithSelector(QuotePay.run.selector, payee, USDC, 10e6, QUOTE_ID),
            ScriptType.ScriptSource
        );
        bytes memory signature = new SignatureHelper().signOp(alicePrivateKey, wallet, op);

        // gas: meter execute
        vm.resumeGasMetering();
        vm.expectRevert("ERC20: transfer amount exceeds balance");
        wallet.executeQuarkOperation(op, signature);
    }
}
