// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import '../IERC20Minimal.sol';

/// @title Interface for WETH9
interface IWETH9 is IERC20Minimal {
    /// @notice Deposit ether to get wrapped ether
    function deposit() external payable;

    /// @notice Withdraw wrapped ether to get ether
    function withdraw(uint256) external;
}