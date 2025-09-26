// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Script.sol";
import "../core/UniswapV3Factory.sol";

contract DeployFactory is Script {
    function run() external returns (UniswapV3Factory factory) {
        vm.startBroadcast();

        factory = new UniswapV3Factory();

        vm.stopBroadcast();
    }
}
