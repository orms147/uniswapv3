// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.0;

// import "forge-std/Script.sol";
// import "../periphery/SwapRouter.sol";

// /// @title Deploy SwapRouter
// /// @notice Script to deploy the SwapRouter contract
// contract DeploySwapRouter is Script {
//     function run() external {
//         uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
//         address deployer = vm.addr(deployerPrivateKey);
        
//         // Get factory address from environment or use a default
//         address factory = vm.envOr("FACTORY_ADDRESS", address(0));
//         address WETH9 = vm.envOr("WETH9_ADDRESS", address(0));
        
//         require(factory != address(0), "FACTORY_ADDRESS not set");
//         require(WETH9 != address(0), "WETH9_ADDRESS not set");
        
//         console.log("Deploying SwapRouter with account:", deployer);
//         console.log("Factory address:", factory);
//         console.log("WETH9 address:", WETH9);
        
//         vm.startBroadcast(deployerPrivateKey);
        
//         // Deploy SwapRouter
//         SwapRouter router = new SwapRouter(factory, WETH9);
        
//         console.log("SwapRouter deployed at:", address(router));
//         console.log("Router factory:", router.factory());
//         console.log("Router WETH9:", router.WETH9());
        
//         vm.stopBroadcast();
//     }
// }
