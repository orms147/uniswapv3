// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import 'src/core/libraries/TickMath.sol';
import 'src/core/libraries/SqrtPriceMath.sol';
import 'src/core/libraries/TransferHelper.sol';
import 'src/interfaces/IUniswapV3Pool.sol';
import 'src/interfaces/IERC20Minimal.sol';

import '../interfaces/ISwapRouter.sol';
import '../interfaces/IPeripheryImmutableState.sol';
import '../interfaces/IPeripheryPayments.sol';
import '../interfaces/external/IWETH9.sol';

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
        require(block.timestamp <= params.deadline, 'Transaction too old');
        
        IUniswapV3Pool pool = getPool(params.tokenIn, params.tokenOut, params.fee);
        
        bool zeroForOne = params.tokenIn < params.tokenOut;
        
        (int256 amount0, int256 amount1) = pool.swap(
            params.recipient,
            zeroForOne,
            int256(params.amountIn),
            params.sqrtPriceLimitX96 == 0
                ? (zeroForOne ? TickMath.MIN_SQRT_RATIO + 1 : TickMath.MAX_SQRT_RATIO - 1)
                : params.sqrtPriceLimitX96,
            abi.encode(params.tokenIn, params.tokenOut, params.fee)
        );
        
        amountOut = uint256(-(zeroForOne ? amount1 : amount0));
        require(amountOut >= params.amountOutMinimum, 'Insufficient output amount');
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
        require(block.timestamp <= params.deadline, 'Transaction too old');
        
        IUniswapV3Pool pool = getPool(params.tokenIn, params.tokenOut, params.fee);
        
        bool zeroForOne = params.tokenIn < params.tokenOut;
        
        (int256 amount0, int256 amount1) = pool.swap(
            params.recipient,
            zeroForOne,
            -int256(params.amountOut),
            params.sqrtPriceLimitX96 == 0
                ? (zeroForOne ? TickMath.MIN_SQRT_RATIO + 1 : TickMath.MAX_SQRT_RATIO - 1)
                : params.sqrtPriceLimitX96,
            abi.encode(params.tokenIn, params.tokenOut, params.fee)
        );
        
        amountIn = uint256(zeroForOne ? amount0 : amount1);
        require(amountIn <= params.amountInMaximum, 'Excessive input amount');
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
        uint256 balanceWETH9 = IERC20Minimal(WETH9).balanceOf(address(this));
        require(balanceWETH9 >= amountMinimum, 'Insufficient WETH9');
        
        if (balanceWETH9 > 0) {
            // Unwrap WETH9 to ETH
            IWETH9(WETH9).withdraw(balanceWETH9);
            TransferHelper.safeTransferETH(recipient, balanceWETH9);
        }
    }

    /// @inheritdoc IPeripheryPayments
    function refundETH() external payable override {
        if (address(this).balance > 0) TransferHelper.safeTransferETH(msg.sender, address(this).balance);
    }

    /// @inheritdoc IPeripheryPayments
    function sweepToken(
        address token,
        uint256 amountMinimum,
        address recipient
    ) external payable override {
        uint256 balanceToken = IERC20Minimal(token).balanceOf(address(this));
        require(balanceToken >= amountMinimum, 'Insufficient token');
        
        if (balanceToken > 0) {
            TransferHelper.safeTransfer(token, recipient, balanceToken);
        }
    }
}