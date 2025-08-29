// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./MulDivLib.sol";
import "lib/v3-core/contracts/libraries/FixedPoint96.sol";

/// @title Functions based on Q64.96 sqrt price and liquidity
/// @notice Contains the math that uses square root of price as a Q64.96 and liquidity to compute deltas
library SqrtPriceMath {
    function getNextSqrtPriceFromAmount0RoundingUp(
        uint160 sqrtPX96,
        uint128 liquidity,
        uint256 amount,
        bool add
    ) internal pure returns (uint160) {
        if (amount == 0) return sqrtPX96;
        uint256 numerator1 = uint256(liquidity) << FixedPoint96.RESOLUTION;

        if (add) {
            uint256 product = amount * sqrtPX96;
            if (product / amount == sqrtPX96) {
                uint256 denominator = numerator1 + product;
                if (denominator >= numerator1) {
                    return uint160(MulDivLib.mulDivRoundingUp(numerator1, sqrtPX96, denominator));
                }
            }
            return uint160((numerator1 + amount - 1) / ((numerator1 / sqrtPX96) + amount));
        } else {
            uint256 product = amount * sqrtPX96;
            require(product / amount == sqrtPX96 && numerator1 > product);
            uint256 denominator = numerator1 - product;
            return uint160(MulDivLib.mulDivRoundingUp(numerator1, sqrtPX96, denominator));
        }
    }

    function getNextSqrtPriceFromAmount1RoundingDown(
        uint160 sqrtPX96,
        uint128 liquidity,
        uint256 amount,
        bool add
    ) internal pure returns (uint160) {
        if (add) {
            uint256 quotient = amount <= type(uint160).max
                ? (amount << FixedPoint96.RESOLUTION) / liquidity
                : MulDivLib.mulDiv(amount, FixedPoint96.Q96, liquidity);
            return uint160(uint256(sqrtPX96) + quotient);
        } else {
            uint256 quotient = amount <= type(uint160).max
                ? (amount << FixedPoint96.RESOLUTION + liquidity - 1) / liquidity
                : MulDivLib.mulDivRoundingUp(amount, FixedPoint96.Q96, liquidity);
            require(sqrtPX96 > quotient);
            return uint160(sqrtPX96 - quotient);
        }
    }

    function getNextSqrtPriceFromInput(
        uint160 sqrtPX96,
        uint128 liquidity,
        uint256 amountIn,
        bool zeroForOne
    ) internal pure returns (uint160 sqrtQX96) {
        require(sqrtPX96 > 0);
        require(liquidity > 0);
        return zeroForOne
            ? getNextSqrtPriceFromAmount0RoundingUp(sqrtPX96, liquidity, amountIn, true)
            : getNextSqrtPriceFromAmount1RoundingDown(sqrtPX96, liquidity, amountIn, true);
    }

    function getNextSqrtPriceFromOutput(
        uint160 sqrtPX96,
        uint128 liquidity,
        uint256 amountOut,
        bool zeroForOne
    ) internal pure returns (uint160 sqrtQX96) {
        require(sqrtPX96 > 0);
        require(liquidity > 0);
        return zeroForOne
            ? getNextSqrtPriceFromAmount1RoundingDown(sqrtPX96, liquidity, amountOut, false)
            : getNextSqrtPriceFromAmount0RoundingUp(sqrtPX96, liquidity, amountOut, false);
    }

    function getAmount0Delta(
        uint160 sqrtRatioAX96,
        uint160 sqrtRatioBX96,
        uint128 liquidity,
        bool roundUp
    ) internal pure returns (uint256 amount0) {
        if (sqrtRatioAX96 > sqrtRatioBX96) (sqrtRatioAX96, sqrtRatioBX96) = (sqrtRatioBX96, sqrtRatioAX96);

        uint256 numerator1 = uint256(liquidity) << FixedPoint96.RESOLUTION;
        uint256 numerator2 = sqrtRatioBX96 - sqrtRatioAX96;

        require(sqrtRatioAX96 > 0);

        return roundUp
            ? (numerator1 * numerator2 + sqrtRatioBX96 - 1) / sqrtRatioBX96 / sqrtRatioAX96
            : numerator1 * numerator2 / sqrtRatioBX96 / sqrtRatioAX96;
    }

    function getAmount1Delta(
        uint160 sqrtRatioAX96,
        uint160 sqrtRatioBX96,
        uint128 liquidity,
        bool roundUp
    ) internal pure returns (uint256 amount1) {
        if (sqrtRatioAX96 > sqrtRatioBX96) (sqrtRatioAX96, sqrtRatioBX96) = (sqrtRatioBX96, sqrtRatioAX96);

        return roundUp
            ? (uint256(liquidity) * (sqrtRatioBX96 - sqrtRatioAX96) + FixedPoint96.Q96 - 1) / FixedPoint96.Q96
            : uint256(liquidity) * (sqrtRatioBX96 - sqrtRatioAX96) / FixedPoint96.Q96;
    }

    function getAmount0Delta(
        uint160 sqrtRatioAX96,
        uint160 sqrtRatioBX96,
        int128 liquidity
    ) internal pure returns (int256 amount0) {
        return liquidity < 0
            ? -int256(getAmount0Delta(sqrtRatioAX96, sqrtRatioBX96, uint128(-liquidity), false))
            : int256(getAmount0Delta(sqrtRatioAX96, sqrtRatioBX96, uint128(liquidity), true));
    }

    function getAmount1Delta(
        uint160 sqrtRatioAX96,
        uint160 sqrtRatioBX96,
        int128 liquidity
    ) internal pure returns (int256 amount1) {
        return liquidity < 0
            ? -int256(getAmount1Delta(sqrtRatioAX96, sqrtRatioBX96, uint128(-liquidity), false))
            : int256(getAmount1Delta(sqrtRatioAX96, sqrtRatioBX96, uint128(liquidity), true));
    }
}