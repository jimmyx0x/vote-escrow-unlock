// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "forge-std/Script.sol";
import "forge-std/console.sol";

// script/Debug6551.s.sol
contract Debug6551 is Script {
    address constant ERC6551_WALLET = 0x9dBD5ddCc8BE91292B96D420cE462FF64f303C53;

    function run() public view {
        // Get implementation
        bytes4 implementationSelector = bytes4(keccak256("implementation()"));
        (bool success, bytes memory data) = ERC6551_WALLET.staticcall(abi.encodeWithSelector(implementationSelector));
        
        if (success) {
            address impl = abi.decode(data, (address));
            console.log("Implementation:", impl);
            
            // Get implementation code size
            uint256 size;
            assembly {
                size := extcodesize(impl)
            }
            console.log("Implementation code size:", size);
        } else {
            console.log("Failed to get implementation");
        }
    }
}