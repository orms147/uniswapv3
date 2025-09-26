// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Script.sol";
import "../periphery/V3Migrator.sol";

contract DeployV3Migrator is Script {
    function run() external returns (V3Migrator migrator) {
        vm.startBroadcast();

        address factory = vm.envAddress("FACTORY_ADDRESS");
        address WETH9 = vm.envAddress("WETH9_ADDRESS");

        migrator = new V3Migrator(factory, WETH9, address(0));

        vm.stopBroadcast();
    }
}
