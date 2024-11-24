// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {IERC6551Executable} from "@erc6551/examples/simple/ERC6551Account.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";

contract TransferPTC is Script {
    address constant PTC = 0xa027a3A04b44f79560153234E999b17C88e22DB9;
    address constant ERC6551_WALLET = 0x9dBD5ddCc8BE91292B96D420cE462FF64f303C53;
    
    function run() public {
        // Get private key and derive address
        uint256 ownerPrivateKey = vm.envUint("OWNER_PRIVATE_KEY");
        address owner = vm.addr(ownerPrivateKey);
        
        // Check PTC balance before transfer
        uint256 balance = IERC20(PTC).balanceOf(ERC6551_WALLET);
        require(balance > 0, "No PTC tokens in wallet");
        console.log("Found PTC balance:", balance);
        
        // Create transfer calldata
        bytes memory transferCall = abi.encodeCall(
            IERC20.transfer,
            (owner, balance)
        );
        
        // Start broadcast with owner's key
        vm.startBroadcast(ownerPrivateKey);
        
        // Execute transfer via ERC6551
        IERC6551Executable(ERC6551_WALLET).execute(
            PTC,           // token contract
            0,            // no ETH value
            transferCall, // transfer call
            0            // operation type
        );
        
        vm.stopBroadcast();
        
        // Verify final balances
        uint256 finalWalletBalance = IERC20(PTC).balanceOf(ERC6551_WALLET);
        uint256 finalOwnerBalance = IERC20(PTC).balanceOf(owner);
        console.log("Final wallet balance:", finalWalletBalance);
        console.log("Final owner balance:", finalOwnerBalance);
    }
}
