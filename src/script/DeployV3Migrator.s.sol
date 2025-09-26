// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.0;

// import "forge-std/Script.sol";
// import "../periphery/V3Migrator.sol";

// /// @title Deploy V3Migrator
// /// @notice Script to deploy the V3Migrator contract
// contract DeployV3Migrator is Script {
//     function run() external {
//         uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
//         address deployer = vm.addr(deployerPrivateKey);
        
//         // Get addresses from environment
//         address factory = vm.envOr("FACTORY_ADDRESS", address(0));
//         address WETH9 = vm.envOr("WETH9_ADDRESS", address(0));
//         address nftManager = vm.envOr("NFT_MANAGER_ADDRESS", address(0));
        
//         require(factory != address(0), "FACTORY_ADDRESS not set");
//         require(WETH9 != address(0), "WETH9_ADDRESS not set");
//         require(nftManager != address(0), "NFT_MANAGER_ADDRESS not set");
        
//         console.log("Deploying V3Migrator with account:", deployer);
//         console.log("Factory address:", factory);
//         console.log("WETH9 address:", WETH9);
//         console.log("NFT Manager address:", nftManager);
        
//         vm.startBroadcast(deployerPrivateKey);
        
//         // Deploy V3Migrator
//         V3Migrator migrator = new V3Migrator(factory, WETH9, nftManager);
        
//         console.log("V3Migrator deployed at:", address(migrator));
//         console.log("Migrator factory:", migrator.factory());
//         console.log("Migrator WETH9:", migrator.WETH9());
//         console.log("Migrator NFT Manager:", migrator.nonfungiblePositionManager());
        
//         vm.stopBroadcast();
//     }
// }
