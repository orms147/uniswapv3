// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import 'src/interfaces/IPeripheryImmutableState.sol';

/// @title Immutable state used by periphery contracts
abstract contract PeripheryImmutableState is IPeripheryImmutableState {
    address public immutable factory;
    address public immutable WETH9;

    constructor(address _factory, address _WETH9) {
        require(_factory != address(0), "Invalid factory");
        require(_WETH9 != address(0), "Invalid WETH");
        factory = _factory;
        WETH9 = _WETH9;
    }
}
