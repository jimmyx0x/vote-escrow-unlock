// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "./VoteEscrowReader.s.sol";
import "@interfaces/IERC6551Account.sol";

contract VoteEscrowSimulator is VoteEscrowReader {
    function simulateUnlock() public {
        // 1. Get current state
        IVoteEscrow voteEscrow = IVoteEscrow(VOTE_ESCROW);
        IVoteEscrow.Escrow memory escrow = voteEscrow.escrows(ERC6551_WALLET);
        
        // 2. Check unlock conditions
        require(escrow.principal > 0, "No tokens to unlock");
        console.log("Principal Amount:", escrow.principal);
        
        require(block.timestamp >= escrow.unlockTime, "Unlock time not reached");
        console.log("Can unlock: true");
        
        // 3. Create unlock call
        bytes memory unlockCall = abi.encodeWithSignature("unlock()");
        console.log("Unlock call data created");
        
        // 4. Print expected gas usage
        uint256 gas = gasleft();
        vm.prank(WALLET_OWNER);
        IERC6551Account(ERC6551_WALLET).execute(
            VOTE_ESCROW,
            0,
            unlockCall
        );
        gas = gas - gasleft();
        
        console.log("Estimated gas usage:", gas);
    }
}
