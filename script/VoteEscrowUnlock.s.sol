// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {IERC6551Executable} from "@erc6551/examples/simple/ERC6551Account.sol";

interface IVoteEscrow {
    struct Escrow {
        uint256 principal;
        uint256 principalTimespan;
        uint256 checkpointTimestamp;
        uint256 unlockTime;
    }
    
    function escrows(address) external view returns (Escrow memory);
    function unlock() external;
}

contract VoteEscrowUnlock is Script {
    address constant VOTE_ESCROW = 0xF2892576A740aD8d302F8C1c9F05cb3472976C3F;
    address constant ERC6551_WALLET = 0x9dBD5ddCc8BE91292B96D420cE462FF64f303C53;
    
    function run() public {
        // Get owner's private key from .env
        uint256 ownerPrivateKey = vm.envUint("OWNER_PRIVATE_KEY");
        
        // Start broadcasting
        vm.startBroadcast(ownerPrivateKey);
        
        // Create unlock call
        bytes memory unlockCall = abi.encodeWithSignature("unlock()");
        
        // Execute via ERC-6551 wallet
        IERC6551Executable(ERC6551_WALLET).execute(
            VOTE_ESCROW,
            0,
            unlockCall,
            0
        );
        
        vm.stopBroadcast();
    }
}
