// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./MulDivLib.sol";
import "lib/v3-core/contracts/libraries/FixedPoint128.sol";
import "lib/v3-core/contracts/libraries/LiquidityMath.sol";

library Position {
    struct Info {
        uint128 liquidity;
        uint256 feeGrowthInside0LastX128;
        uint256 feeGrowthInside1LastX128;
        uint128 tokensOwed0;
        uint128 tokensOwed1;
    }

    error NoPosition(); // NP

    /// @notice Get storage slot for position (owner + range)
    function get(
        mapping(bytes32 => Info) storage self,
        address owner,
        int24 tickLower,
        int24 tickUpper
    ) internal view returns (Info storage position) {
        position = self[keccak256(abi.encodePacked(owner, tickLower, tickUpper))];
    }

    /// @notice Accrue fees and optionally change liquidity for a position
    /// @param self position storage
    /// @param liquidityDelta signed change to liquidity (can be 0 for poke)
    /// @param feeGrowthInside0X128 global fee growth inside the range (token0) at "now"
    /// @param feeGrowthInside1X128 global fee growth inside the range (token1) at "now"
    function update(
        Info storage self,
        int128 liquidityDelta,
        uint256 feeGrowthInside0X128,
        uint256 feeGrowthInside1X128
    ) internal {
        // cache to memory (cheaper reads)
        Info memory _self = self;

        // 1) compute next liquidity (or poke guard)
        uint128 liquidityNext;
        if (liquidityDelta == 0) {
            if (_self.liquidity == 0) revert NoPosition(); // disallow pokes on empty position
            liquidityNext = _self.liquidity;
        } else {
            liquidityNext = LiquidityMath.addDelta(_self.liquidity, liquidityDelta);
        }

        // 2) accrue fees since last update:
        // Δfees = (feeGrowthInsideNow - feeGrowthInsideLast) * L / Q128
        uint128 tokensOwed0 = uint128(
            MulDivLib.mulDiv(
                (feeGrowthInside0X128 - _self.feeGrowthInside0LastX128),
                _self.liquidity,
                FixedPoint128.Q128
            )
        );
        uint128 tokensOwed1 = uint128(
            MulDivLib.mulDiv(
                (feeGrowthInside1X128 - _self.feeGrowthInside1LastX128),
                _self.liquidity,
                FixedPoint128.Q128
            )
        );

        // 3) write-back storage
        if (liquidityDelta != 0) self.liquidity = liquidityNext;

        self.feeGrowthInside0LastX128 = feeGrowthInside0X128;
        self.feeGrowthInside1LastX128 = feeGrowthInside1X128;

        if (tokensOwed0 > 0 || tokensOwed1 > 0) {
            // same semantics as v3: may overflow if never collected; LP must collect before uint128 max
            self.tokensOwed0 += tokensOwed0;
            self.tokensOwed1 += tokensOwed1;
        }
    }
}
