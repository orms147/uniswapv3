// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/// @title Minimal ERC20 interface
/// @notice Contains only the essential functions for ERC20 tokens
interface IERC20Minimal {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
}
