// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.27;

import "./vendor/chainlink/AggregatorV3Interface.sol";
import "openzeppelin/token/ERC20/utils/SafeERC20.sol";
import "openzeppelin/token/ERC20/extensions/IERC20Metadata.sol";

/**
 * @title Quotecall Core Script
 * @notice Core script that executes an action via delegatecall and then pays for the gas using an ERC20 token.
 * @author Compound Labs, Inc.
 */
contract Quotecall {
    using SafeERC20 for IERC20;

    event PayForGas(address indexed payer, address indexed payee, address indexed paymentToken, uint256 amount);

    error InvalidCallContext();

    /// @notice This contract's address
    address internal immutable scriptAddress;

    /**
     * @notice Constructor
     */
    constructor() {
        scriptAddress = address(this);
    }

    /**
     * @notice Execute delegatecall on a contract and pay tx.origin the quoted amount of the payment token
     * @param callContract Contract to call
     * @param callData Encoded calldata for call
     * @param paymentToken The token used to pay for this transaction
     * @param quotedAmount The quoted network fee for this transaction, in units of the payment token
     * @return Return data from call
     */
    function run(address callContract, bytes calldata callData, address paymentToken, uint256 quotedAmount)
        external
        returns (bytes memory)
    {
        // Ensures that this script cannot be called directly and self-destructed
        if (address(this) == scriptAddress) {
            revert InvalidCallContext();
        }

        IERC20(paymentToken).safeTransfer(tx.origin, quotedAmount);
        emit PayForGas(address(this), tx.origin, paymentToken, quotedAmount);

        // Return early if no address and calldata is provided
        if (callContract == address(0) && callData.length == 0) {
            return "";
        }

        (bool success, bytes memory returnData) = callContract.delegatecall(callData);
        if (!success) {
            assembly {
                revert(add(returnData, 32), mload(returnData))
            }
        }

        return returnData;
    }
}
