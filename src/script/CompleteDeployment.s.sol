// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Script.sol";
import "./DeployFactory.s.sol";
import "./DeploySwapRouter.s.sol";
import "./DeployNonfungiblePositionManager.s.sol";
import "./DeployV3Migrator.s.sol";

contract CompleteDeployment is Script {
    function run() external {
        vm.startBroadcast();

        // Deploy Factory
        DeployFactory factoryDeployer = new DeployFactory();
        UniswapV3Factory factory = factoryDeployer.run();

        // Set environment for other deployments
        vm.setEnv("FACTORY_ADDRESS", vm.toString(address(factory)));

        // Deploy SwapRouter
        DeploySwapRouter routerDeployer = new DeploySwapRouter();
        SwapRouter router = routerDeployer.run();

        // Deploy NFT Manager
        DeployNonfungiblePositionManager nftDeployer = new DeployNonfungiblePositionManager();
        NonfungiblePositionManager nftManager = nftDeployer.run();

        // Deploy V3 Migrator
        DeployV3Migrator migratorDeployer = new DeployV3Migrator();
        V3Migrator migrator = migratorDeployer.run();

        vm.stopBroadcast();

        console.log("Factory:", address(factory));
        console.log("Router:", address(router));
        console.log("NFT Manager:", address(nftManager));
        console.log("Migrator:", address(migrator));
    }
}
