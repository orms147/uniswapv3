// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Script.sol";
import "../periphery/SwapRouter.sol";

contract DeploySwapRouter is Script {
    function run() external returns (SwapRouter router) {
        vm.startBroadcast();

        address factory = vm.envAddress("FACTORY_ADDRESS");
        address WETH9 = vm.envAddress("WETH9_ADDRESS");

        router = new SwapRouter(factory, WETH9);

        vm.stopBroadcast();
    }
}
