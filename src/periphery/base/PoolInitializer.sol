// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "src/interfaces/IUniswapV3Factory.sol";
import "src/interfaces/IUniswapV3Pool.sol";

/// @title PoolInitializer
abstract contract PoolInitializer {
    function createAndInitializePoolIfNecessary(
        address factory,
        address token0,
        address token1,
        uint24 fee,
        uint160 sqrtPriceX96
    ) internal returns (address pool) {
        pool = IUniswapV3Factory(factory).getPool(token0, token1, fee);
        if (pool == address(0)) {
            pool = IUniswapV3Factory(factory).createPool(token0, token1, fee);
            IUniswapV3Pool(pool).initialize(sqrtPriceX96);
        }
    }
}
