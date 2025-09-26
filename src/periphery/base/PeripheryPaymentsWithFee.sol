// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./PeripheryPayments.sol";
import 'lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

/// @title PeripheryPaymentsWithFee
abstract contract PeripheryPaymentsWithFee is PeripheryPayments {
    using SafeERC20 for IERC20;

    constructor(address _factory, address _WETH9) PeripheryPayments(_factory, _WETH9) {}

    function sweepTokenWithFee(
        address token,
        uint256 amount,
        address recipient,
        uint256 feeBips,
        address feeRecipient
    ) public {
        require(feeBips <= 10000, "Fee too high");
        uint256 feeAmount = (amount * feeBips) / 10000;
        if (feeAmount > 0) {
            IERC20(token).safeTransfer(feeRecipient, feeAmount);
        }
        IERC20(token).safeTransfer(recipient, amount - feeAmount);
    }
}
