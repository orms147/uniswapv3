// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import 'lib/v3-core/contracts/interfaces/pool/IUniswapV3PoolImmutables.sol';
import 'lib/v3-core/contracts/interfaces/pool/IUniswapV3PoolState.sol';
import 'lib/v3-core/contracts/interfaces/pool/IUniswapV3PoolDerivedState.sol';
import 'lib/v3-core/contracts/interfaces/pool/IUniswapV3PoolActions.sol';
import 'lib/v3-core/contracts/interfaces/pool/IUniswapV3PoolOwnerActions.sol';
import 'lib/v3-core/contracts/interfaces/pool/IUniswapV3PoolEvents.sol';

/// @title The interface for a Uniswap V3 Pool
/// @notice A Uniswap pool facilitates swapping and automated market making between any two assets that strictly conform
/// to the ERC20 specification
/// @dev The pool interface is broken up into many smaller pieces
interface IUniswapV3Pool is
    IUniswapV3PoolImmutables,
    IUniswapV3PoolState,
    IUniswapV3PoolDerivedState,
    IUniswapV3PoolActions,
    IUniswapV3PoolOwnerActions,
    IUniswapV3PoolEvents
{

}