// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.0;

// import "forge-std/Script.sol";
// import "../core/UniswapV3Factory.sol";

// /// @title Create Pool
// /// @notice Script to create a new pool using the factory
// contract CreatePool is Script {
//     function run() external {
//         uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
//         address deployer = vm.addr(deployerPrivateKey);
        
//         // Get addresses from environment
//         address factoryAddress = vm.envOr("FACTORY_ADDRESS", address(0));
//         address tokenA = vm.envOr("TOKEN_A", address(0));
//         address tokenB = vm.envOr("TOKEN_B", address(0));
//         uint24 fee = uint24(vm.envOr("FEE", uint256(3000))); // Default to 0.3%
        
//         require(factoryAddress != address(0), "FACTORY_ADDRESS not set");
//         require(tokenA != address(0), "TOKEN_A not set");
//         require(tokenB != address(0), "TOKEN_B not set");
        
//         console.log("Creating pool with account:", deployer);
//         console.log("Factory address:", factoryAddress);
//         console.log("Token A:", tokenA);
//         console.log("Token B:", tokenB);
//         console.log("Fee:", fee);
        
//         vm.startBroadcast(deployerPrivateKey);
        
//         UniswapV3Factory factory = UniswapV3Factory(factoryAddress);
        
//         // Create the pool
//         address pool = factory.createPool(tokenA, tokenB, fee);
        
//         console.log("Pool created at:", pool);
//         console.log("Pool exists:", pool != address(0));
        
//         vm.stopBroadcast();
//     }
// }
