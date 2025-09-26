// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Script.sol";
import "../periphery/NonfungiblePositionManager.sol";
import "../periphery/NonfungibleTokenPositionDescriptor.sol";

contract DeployNonfungiblePositionManager is Script {
    function run() external returns (NonfungiblePositionManager manager) {
        vm.startBroadcast();

        address factory = vm.envAddress("FACTORY_ADDRESS");
        address WETH9 = vm.envAddress("WETH9_ADDRESS");

        manager = new NonfungiblePositionManager(factory, WETH9);

        vm.stopBroadcast();
    }
}
