// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../core/UniswapV3Factory.sol";
import "../periphery/SwapRouter.sol";
import "../periphery/NonfungiblePositionManager.sol";
import "../periphery/V3Migrator.sol";

/// @title Deploy All Contracts
/// @notice Script to deploy all UniswapV3 contracts in sequence
contract DeployAll is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        
        // Get WETH9 address from environment
        address WETH9 = vm.envOr("WETH9_ADDRESS", address(0));
        require(WETH9 != address(0), "WETH9_ADDRESS not set");
        
        console.log("Deploying all UniswapV3 contracts with account:", deployer);
        console.log("WETH9 address:", WETH9);
        
        vm.startBroadcast(deployerPrivateKey);
        
        // 1. Deploy Factory
        console.log("\n=== Deploying Factory ===");
        UniswapV3Factory factory = new UniswapV3Factory();
        console.log("Factory deployed at:", address(factory));
        
        // 2. Deploy SwapRouter
        console.log("\n=== Deploying SwapRouter ===");
        SwapRouter router = new SwapRouter(address(factory), WETH9);
        console.log("SwapRouter deployed at:", address(router));
        
        // 3. Deploy NonfungiblePositionManager
        console.log("\n=== Deploying NonfungiblePositionManager ===");
        NonfungiblePositionManager nftManager = new NonfungiblePositionManager(address(factory), WETH9);
        console.log("NonfungiblePositionManager deployed at:", address(nftManager));
        
        // 4. Deploy V3Migrator
        console.log("\n=== Deploying V3Migrator ===");
        V3Migrator migrator = new V3Migrator(address(factory), WETH9, address(nftManager));
        console.log("V3Migrator deployed at:", address(migrator));
        
        // Summary
        console.log("\n=== Deployment Summary ===");
        console.log("Factory:", address(factory));
        console.log("SwapRouter:", address(router));
        console.log("NonfungiblePositionManager:", address(nftManager));
        console.log("V3Migrator:", address(migrator));
        
        vm.stopBroadcast();
    }
}
