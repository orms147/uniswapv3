// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.0;

// import "forge-std/Script.sol";
// import "../periphery/NonfungiblePositionManager.sol";

// /// @title Deploy NonfungiblePositionManager
// /// @notice Script to deploy the NonfungiblePositionManager contract
// contract DeployNonfungiblePositionManager is Script {
//     function run() external {
//         uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
//         address deployer = vm.addr(deployerPrivateKey);
        
//         // Get addresses from environment
//         address factory = vm.envOr("FACTORY_ADDRESS", address(0));
//         address WETH9 = vm.envOr("WETH9_ADDRESS", address(0));
        
//         require(factory != address(0), "FACTORY_ADDRESS not set");
//         require(WETH9 != address(0), "WETH9_ADDRESS not set");
        
//         console.log("Deploying NonfungiblePositionManager with account:", deployer);
//         console.log("Factory address:", factory);
//         console.log("WETH9 address:", WETH9);
        
//         vm.startBroadcast(deployerPrivateKey);
        
//         // Deploy NonfungiblePositionManager
//         NonfungiblePositionManager nftManager = new NonfungiblePositionManager(factory, WETH9);
        
//         console.log("NonfungiblePositionManager deployed at:", address(nftManager));
//         console.log("NFT Manager factory:", nftManager.factory());
//         console.log("NFT Manager WETH9:", nftManager.WETH9());
        
//         vm.stopBroadcast();
//     }
// }
