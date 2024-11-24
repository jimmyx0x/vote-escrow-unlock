// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";

interface IBlastContract {
    // Add interface functions for the contract you're interacting with
    function someFunction() external;
}

contract BlastScript is Script {
    // Contract addresses on Blast mainnet
    address constant TARGET_CONTRACT = 0x...;
    
    function setUp() public {}

    function run() public {
        // Get private key from environment
        uint256 userPrivateKey = vm.envUint("USER_PRIVATE_KEY");
        
        // Start broadcasting with the user's private key
        vm.startBroadcast(userPrivateKey);

        // Interact with contract
        IBlastContract target = IBlastContract(TARGET_CONTRACT);
        target.someFunction();

        vm.stopBroadcast();
    }
}
