// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../core/UniswapV3Factory.sol";

/// @title Deploy UniswapV3Factory
/// @notice Script to deploy the UniswapV3Factory contract
contract DeployFactory is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        
        console.log("Deploying UniswapV3Factory with account:", deployer);
        console.log("Account balance:", deployer.balance);
        
        vm.startBroadcast(deployerPrivateKey);
        
        // Deploy UniswapV3Factory
        UniswapV3Factory factory = new UniswapV3Factory();
        
        console.log("UniswapV3Factory deployed at:", address(factory));
        console.log("Factory owner:", factory.owner());
        
        // Check default fee amounts
        console.log("Fee 500 tick spacing:", factory.feeAmountTickSpacing(500));
        console.log("Fee 3000 tick spacing:", factory.feeAmountTickSpacing(3000));
        console.log("Fee 10000 tick spacing:", factory.feeAmountTickSpacing(10000));
        
        vm.stopBroadcast();
    }
}
