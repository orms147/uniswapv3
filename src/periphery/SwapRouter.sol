// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import 'src/core/libraries/TickMath.sol';
import 'lib/v3-core/contracts/interfaces/IUniswapV3Pool.sol';

import '../interfaces/ISwapRouter.sol';
import '../interfaces/IPeripheryImmutableState.sol';
import '../interfaces/IPeripheryPayments.sol';

/// @title Uniswap V3 Swap Router
/// @notice Router for stateless execution of swaps against Uniswap V3
contract SwapRouter is ISwapRouter, IPeripheryImmutableState, IPeripheryPayments {
    /// @inheritdoc IPeripheryImmutableState
    address public immutable override factory;
    /// @inheritdoc IPeripheryImmutableState
    address public immutable override WETH9;

    constructor(address _factory, address _WETH9) {
        factory = _factory;
        WETH9 = _WETH9;
    }

    /// @dev Returns the pool for the given token pair and fee. The pool contract may or may not exist.
    function getPool(
        address tokenA,
        address tokenB,
        uint24 fee
    ) private view returns (IUniswapV3Pool) {
        return IUniswapV3Pool(computeAddress(tokenA, tokenB, fee));
    }

    /// @dev Computes the address of a pool
    function computeAddress(
        address tokenA,
        address tokenB,
        uint24 fee
    ) private view returns (address) {
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        return address(uint160(uint256(keccak256(abi.encodePacked(
            hex'ff',
            factory,
            keccak256(abi.encode(token0, token1, fee)),
            hex'e34f199b19b2b4' // Pool init code hash
        )))));
    }

    /// @inheritdoc ISwapRouter
    function exactInputSingle(ExactInputSingleParams calldata params)
        external
        payable
        override
        returns (uint256 amountOut)
    {
        // Implementation placeholder - would need full implementation
        revert("Not implemented yet");
    }

    /// @inheritdoc ISwapRouter
    function exactInput(ExactInputParams calldata params)
        external
        payable
        override
        returns (uint256 amountOut)
    {
        // Implementation placeholder - would need full implementation
        revert("Not implemented yet");
    }

    /// @inheritdoc ISwapRouter
    function exactOutputSingle(ExactOutputSingleParams calldata params)
        external
        payable
        override
        returns (uint256 amountIn)
    {
        // Implementation placeholder - would need full implementation
        revert("Not implemented yet");
    }

    /// @inheritdoc ISwapRouter
    function exactOutput(ExactOutputParams calldata params)
        external
        payable
        override
        returns (uint256 amountIn)
    {
        // Implementation placeholder - would need full implementation
        revert("Not implemented yet");
    }

    /// @inheritdoc IPeripheryPayments
    function unwrapWETH9(uint256 amountMinimum, address recipient) external payable override {
        // Implementation placeholder
        revert("Not implemented yet");
    }

    /// @inheritdoc IPeripheryPayments
    function refundETH() external payable override {
        // Implementation placeholder
        revert("Not implemented yet");
    }

    /// @inheritdoc IPeripheryPayments
    function sweepToken(
        address token,
        uint256 amountMinimum,
        address recipient
    ) external payable override {
        // Implementation placeholder
        revert("Not implemented yet");
    }
}