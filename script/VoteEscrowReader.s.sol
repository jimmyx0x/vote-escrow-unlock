// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "@interfaces/IERC6551Account.sol";

interface IVoteEscrow {
    struct Escrow {
        uint256 principal;
        uint256 principalTimespan;
        uint256 checkpointTimestamp;
        uint256 unlockTime;
    }
    
    function escrows(address) external view returns (Escrow memory);
    function TOKEN() external view returns (address);
}

interface IERC20 {
    function balanceOf(address) external view returns (uint256);
    function symbol() external view returns (string memory);
}

contract VoteEscrowReader is Script {
    address constant WALLET_OWNER = 0x8b7a53c4Ecca2343C05f4c57533017F8e5b12Ac5;
    address constant VOTE_ESCROW = 0xF2892576A740aD8d302F8C1c9F05cb3472976C3F;
    address constant ERC6551_WALLET = 0x9dBD5ddCc8BE91292B96D420cE462FF64f303C53;
    
    function run() public view {
        IVoteEscrow voteEscrow = IVoteEscrow(VOTE_ESCROW);
        IVoteEscrow.Escrow memory escrow = voteEscrow.escrows(ERC6551_WALLET);
        
        // Get token info
        address tokenAddr = voteEscrow.TOKEN();
        IERC20 token = IERC20(tokenAddr);
        
        console.log("Token Address:", tokenAddr);
        console.log("Token Symbol:", token.symbol());
        console.log("Token Balance:", token.balanceOf(ERC6551_WALLET));
        console.log("Principal:", escrow.principal);
        console.log("Unlock Time:", escrow.unlockTime);
        console.log("Current Time:", block.timestamp);

        // Check ERC-6551 wallet
        IERC6551Account tokenBoundAccount = IERC6551Account(ERC6551_WALLET);
        address currentOwner = tokenBoundAccount.owner();
        
        console.log("ERC-6551 Owner:", currentOwner);
        console.log("Expected Owner:", WALLET_OWNER);
        console.log("Owner Match:", currentOwner == WALLET_OWNER);
    }
}
