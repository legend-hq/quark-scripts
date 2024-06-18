// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.23;

import {IQuarkWallet} from "quark-core/src/interfaces/IQuarkWallet.sol";

import {Actions} from "./Actions.sol";
import {Accounts} from "./Accounts.sol";
import {BridgeRoutes} from "./BridgeRoutes.sol";
import {EIP712Helper} from "./EIP712Helper.sol";
import {Strings} from "./Strings.sol";
import {PaycallWrapper} from "./PaycallWrapper.sol";
import {PaymentInfo} from "./PaymentInfo.sol";

contract QuarkBuilder {
    /* ===== Constants ===== */

    string constant VERSION = "1.0.0";
    uint256 constant MAX_BRIDGE_ACTION = 1;

    // Note: This is a default max cost for passing into paycall if PaymentMaxCost is missing for particular chainId
    uint256 constant DEFAULT_MAX_PAYCALL_COST = 40e6;

    /* ===== Custom Errors ===== */

    error AssetPositionNotFound();
    error FundsUnavailable();
    error InsufficientFunds();
    error InvalidInput();
    error MaxCostTooHigh();
    error TooManyBridgeOperations();

    /* ===== Input Types ===== */

    /* ===== Output Types ===== */

    struct BuilderResult {
        // version of the builder interface. (Same as VERSION, but attached to the output.)
        string version;
        // array of quark operations to execute to fulfill the client intent
        IQuarkWallet.QuarkOperation[] quarkOperations;
        // array of action context and other metadata corresponding 1:1 with quarkOperations
        Actions.Action[] actions;
        // EIP-712 digest to sign for a MultiQuarkOperation to fulfill the client intent.
        // Empty when quarkOperations.length == 0.
        bytes32 multiQuarkOperationDigest;
        // EIP-712 digest to sign for a single QuarkOperation to fulfill the client intent.
        // Empty when quarkOperations.length != 1.
        bytes32 quarkOperationDigest;
        // client-provided paymentCurrency string that was used to derive token addresses.
        // client may re-use this string to construct a request that simulates the transaction.
        string paymentCurrency;
    }

    /* ===== Helper Functions ===== */

    /* ===== Main Implementation ===== */

    struct TransferIntent {
        uint256 chainId;
        string assetSymbol;
        uint256 amount;
        address sender;
        address recipient;
        uint256 blockTimestamp;
    }

    // TODO: handle transfer max
    // TODO: support expiry
    function transfer(
        TransferIntent memory transferIntent,
        Accounts.ChainAccounts[] memory chainAccountsList,
        PaymentInfo.Payment memory payment
    ) external pure returns (BuilderResult memory) {
        assertSufficientFunds(transferIntent, chainAccountsList);
        assertFundsAvailable(transferIntent, chainAccountsList);
        assertPaymentAffordable(transferIntent, chainAccountsList, payment);

        /*
         * at most one bridge operation per non-destination chain,
         * and at most one transferIntent operation on the destination chain.
         *
         * therefore the upper bound is chainAccountsList.length.
         */
        uint256 actionIndex = 0;
        // TODO: actually allocate quark actions
        Actions.Action[] memory actions = new Actions.Action[](chainAccountsList.length);
        IQuarkWallet.QuarkOperation[] memory quarkOperations =
            new IQuarkWallet.QuarkOperation[](chainAccountsList.length);

        if (needsBridgedFunds(transferIntent, chainAccountsList)) {
            // Note: Assumes that the asset uses the same # of decimals on each chain
            uint256 balanceOnDstChain =
                Accounts.getBalanceOnChain(transferIntent.assetSymbol, transferIntent.chainId, chainAccountsList);
            uint256 amountLeftToBridge = transferIntent.amount - balanceOnDstChain;

            uint256 bridgeActionCount = 0;
            // TODO: bridge routing logic (which bridge to prioritize, how many bridges?)
            // Iterate chainAccountList and find upto 2 chains that can provide enough fund
            // Backend can provide optimal routes by adjust the order in chainAccountList.
            for (uint256 i = 0; i < chainAccountsList.length; ++i) {
                if (amountLeftToBridge == 0) {
                    break;
                }

                Accounts.ChainAccounts memory srcChainAccounts = chainAccountsList[i];
                if (srcChainAccounts.chainId == transferIntent.chainId) {
                    continue;
                }

                if (
                    !BridgeRoutes.canBridge(srcChainAccounts.chainId, transferIntent.chainId, transferIntent.assetSymbol)
                ) {
                    continue;
                }

                Accounts.AssetPositions memory srcAssetPositions =
                    Accounts.findAssetPositions(transferIntent.assetSymbol, srcChainAccounts.assetPositionsList);
                Accounts.AccountBalance[] memory srcAccountBalances = srcAssetPositions.accountBalances;
                // TODO: Make logic smarter. Currently, this uses a greedy algorithm.
                // e.g. Optimize by trying to bridge with the least amount of bridge operations
                for (uint256 j = 0; j < srcAccountBalances.length; ++j) {
                    if (bridgeActionCount >= MAX_BRIDGE_ACTION) {
                        revert TooManyBridgeOperations();
                    }

                    uint256 amountToBridge = srcAccountBalances[j].balance >= amountLeftToBridge
                        ? amountLeftToBridge
                        : srcAccountBalances[j].balance;
                    amountLeftToBridge -= amountToBridge;

                    (quarkOperations[actionIndex], actions[actionIndex]) = Actions.bridgeAsset(
                        Actions.BridgeAsset({
                            chainAccountsList: chainAccountsList,
                            assetSymbol: transferIntent.assetSymbol,
                            amount: amountToBridge,
                            // where it comes from
                            srcChainId: srcChainAccounts.chainId,
                            sender: srcAccountBalances[j].account,
                            // where it goes
                            destinationChainId: transferIntent.chainId,
                            recipient: transferIntent.sender,
                            blockTimestamp: transferIntent.blockTimestamp
                        }),
                        payment
                    );

                    actionIndex++;
                    bridgeActionCount++;
                }
            }

            if (amountLeftToBridge > 0) {
                revert FundsUnavailable();
            }
        }

        // Then, transferIntent `amount` of `assetSymbol` to `recipient`
        (quarkOperations[actionIndex], actions[actionIndex]) = Actions.transferAsset(
            Actions.TransferAsset({
                chainAccountsList: chainAccountsList,
                assetSymbol: transferIntent.assetSymbol,
                amount: transferIntent.amount,
                chainId: transferIntent.chainId,
                sender: transferIntent.sender,
                recipient: transferIntent.recipient,
                blockTimestamp: transferIntent.blockTimestamp
            }),
            payment
        );

        actionIndex++;

        // Construct EIP712 digests
        // We leave `multiQuarkOperationDigest` empty if there is only a single QuarkOperation
        // We leave `quarkOperationDigest` if there are more than one QuarkOperations
        actions = truncate(actions, actionIndex);
        quarkOperations = truncate(quarkOperations, actionIndex);
        bytes32 quarkOperationDigest;
        bytes32 multiQuarkOperationDigest;
        if (quarkOperations.length == 1) {
            quarkOperationDigest =
                EIP712Helper.getDigestForQuarkOperation(quarkOperations[0], actions[0].quarkAccount, actions[0].chainId);
        } else if (quarkOperations.length > 1) {
            multiQuarkOperationDigest = EIP712Helper.getDigestForMultiQuarkOperation(quarkOperations, actions);
        }

        return BuilderResult({
            version: VERSION,
            actions: actions,
            quarkOperations: quarkOperations,
            paymentCurrency: payment.currency,
            multiQuarkOperationDigest: multiQuarkOperationDigest,
            quarkOperationDigest: quarkOperationDigest
        });
    }

    function assertSufficientFunds(
        TransferIntent memory transferIntent,
        Accounts.ChainAccounts[] memory chainAccountsList
    ) internal pure {
        uint256 aggregateTransferAssetBalance;
        for (uint256 i = 0; i < chainAccountsList.length; ++i) {
            aggregateTransferAssetBalance += Accounts.sumBalances(
                Accounts.findAssetPositions(transferIntent.assetSymbol, chainAccountsList[i].assetPositionsList)
            );
        }
        // There are not enough aggregate funds on all chains to fulfill the transfer.
        if (aggregateTransferAssetBalance < transferIntent.amount) {
            revert InsufficientFunds();
        }
    }

    // For some reason, funds that may otherwise be bridgeable or held by the
    // user cannot be made available to fulfill the transaction. Funds cannot
    // be bridged, e.g. no bridge exists Funds cannot be withdrawn from comet,
    // e.g. no reserves In order to consider the availability here, we’d need
    // comet data to be passed in as an input. (So, if we were including
    // withdraw.)
    function assertFundsAvailable(
        TransferIntent memory transferIntent,
        Accounts.ChainAccounts[] memory chainAccountsList
    ) internal pure {
        if (needsBridgedFunds(transferIntent, chainAccountsList)) {
            uint256 aggregateTransferAssetAvailableBalance;
            for (uint256 i = 0; i < chainAccountsList.length; ++i) {
                Accounts.AssetPositions memory positions =
                    Accounts.findAssetPositions(transferIntent.assetSymbol, chainAccountsList[i].assetPositionsList);
                if (
                    chainAccountsList[i].chainId == transferIntent.chainId
                        || BridgeRoutes.canBridge(
                            chainAccountsList[i].chainId, transferIntent.chainId, transferIntent.assetSymbol
                        )
                ) {
                    aggregateTransferAssetAvailableBalance += Accounts.sumBalances(positions);
                }
            }
            if (aggregateTransferAssetAvailableBalance < transferIntent.amount) {
                revert FundsUnavailable();
            }
        }
    }

    function needsBridgedFunds(TransferIntent memory transferIntent, Accounts.ChainAccounts[] memory chainAccountsList)
        internal
        pure
        returns (bool)
    {
        return Accounts.getBalanceOnChain(transferIntent.assetSymbol, transferIntent.chainId, chainAccountsList)
            < transferIntent.amount;
    }

    // Assert that each chain has sufficient funds to cover the max cost for that chain.
    // NOTE: This check strategy is:
    // 1. Accrue available fund on each chain (chain balance - max cost)
    // 2. If total available fund > transferIntent then pass, otherwise MaxCostTooHigh()
    // 3. Make sure the transferIntent chain always has enough fund to cover max cost
    function assertPaymentAffordable(
        TransferIntent memory transferIntent,
        Accounts.ChainAccounts[] memory chainAccountsList,
        PaymentInfo.Payment memory payment
    ) internal pure {
        if (payment.isToken) {
            uint256 totalAvailableAsset = 0;
            for (uint256 i = 0; i < payment.maxCosts.length; ++i) {
                uint256 paymentAssetBalanceOnChain = Accounts.sumBalances(
                    Accounts.findAssetPositions(payment.currency, payment.maxCosts[i].chainId, chainAccountsList)
                );
                uint256 paymentAssetNeeded = payment.maxCosts[i].amount;
                if (paymentAssetBalanceOnChain > paymentAssetNeeded) {
                    totalAvailableAsset += paymentAssetBalanceOnChain - paymentAssetNeeded;
                }

                if (payment.maxCosts[i].chainId == transferIntent.chainId) {
                    if (paymentAssetBalanceOnChain < paymentAssetNeeded) {
                        revert MaxCostTooHigh();
                    }
                }
            }

            // If the payment token is the transfer token
            // we need to account for the transfer amount
            // when checking token balances
            if (Strings.stringEqIgnoreCase(payment.currency, transferIntent.assetSymbol)) {
                if (totalAvailableAsset < transferIntent.amount) {
                    revert MaxCostTooHigh();
                }
            }
        }
    }

    function truncate(Actions.Action[] memory actions, uint256 length)
        internal
        pure
        returns (Actions.Action[] memory)
    {
        Actions.Action[] memory result = new Actions.Action[](length);
        for (uint256 i = 0; i < length; ++i) {
            result[i] = actions[i];
        }
        return result;
    }

    function truncate(IQuarkWallet.QuarkOperation[] memory operations, uint256 length)
        internal
        pure
        returns (IQuarkWallet.QuarkOperation[] memory)
    {
        IQuarkWallet.QuarkOperation[] memory result = new IQuarkWallet.QuarkOperation[](length);
        for (uint256 i = 0; i < length; ++i) {
            result[i] = operations[i];
        }
        return result;
    }
}
