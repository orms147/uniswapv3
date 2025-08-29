// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/Math.sol";

/// @title Contains simplified math functions using OpenZeppelin Math
/// @notice Provides safe multiplication and division with rounding, prioritizing accuracy
library MulDivLib {
    function mulDiv(
        uint256 a,
        uint256 b,
        uint256 denominator
    ) internal pure returns (uint256 result) {
        require(denominator > 0, "Denominator cannot be zero");
        result = Math.mulDiv(a, b, denominator);
    }

    function mulDivRoundingUp(
        uint256 a,
        uint256 b,
        uint256 denominator
    ) internal pure returns (uint256 result) {
        require(denominator > 0, "Denominator cannot be zero");
        result = Math.mulDiv(a, b, denominator, Math.Rounding.Ceil);
    }
}