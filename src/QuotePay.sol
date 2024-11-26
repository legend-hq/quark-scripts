// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.27;

import "openzeppelin/token/ERC20/utils/SafeERC20.sol";
import "openzeppelin/token/ERC20/extensions/IERC20Metadata.sol";

/**
 * @title QuotePay Script
 * @notice Quark script that pays a quote to the payee
 * @author Legend Labs, Inc.
 */
contract QuotePay {
    using SafeERC20 for IERC20;

    event PayQuote(
        address indexed payer, address indexed payee, address indexed paymentToken, uint256 amount, bytes32 quoteId
    );

    /**
     * @notice Pay the payee the quoted amount of the payment token
     * @param payee The token used to pay for this transaction
     * @param paymentToken The token used to pay for this transaction
     * @param quotedAmount The quoted network fee for this transaction, in units of the payment token
     * @param quoteId The identifier of the quote that is being paid
     */
    function run(address payee, address paymentToken, uint256 quotedAmount, bytes32 quoteId) external {
        IERC20(paymentToken).safeTransfer(payee, quotedAmount);
        emit PayQuote(address(this), payee, paymentToken, quotedAmount, quoteId);
    }
}
