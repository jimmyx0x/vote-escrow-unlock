// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "@interfaces/IERC6551Account.sol";

contract DebugUnlock is Script {
    address constant VOTE_ESCROW = 0xF2892576A740aD8d302F8C1c9F05cb3472976C3F;
    address constant ERC6551_WALLET = 0x9dBD5ddCc8BE91292B96D420cE462FF64f303C53;
    address constant WALLET_OWNER = 0x8b7a53c4Ecca2343C05f4c57533017F8e5b12Ac5;

    function run() public {
        // 1. Check owner
        address currentOwner = IERC6551Account(ERC6551_WALLET).owner();
        console.log("Current owner:", currentOwner);
        console.log("Expected owner:", WALLET_OWNER);
        console.log("Owner match:", currentOwner == WALLET_OWNER);

        // 2. Check if we're calling from owner
        console.log("msg.sender:", msg.sender);
        
        // 3. Create and log the call data
        bytes memory unlockCall = abi.encodeWithSignature("unlock()");
        console.logBytes(unlockCall);
        
        // 4. Try the call with different approaches
        
        // 4.1 Direct call with prank
        console.log("\nTrying direct call with prank...");
        vm.prank(WALLET_OWNER);
        try IERC6551Account(ERC6551_WALLET).execute(
            VOTE_ESCROW,
            0,
            unlockCall
        ) returns (bytes memory result) {
            console.log("Success!");
            console.logBytes(result);
        } catch Error(string memory reason) {
            console.log("Revert with reason:", reason);
        } catch (bytes memory rawRevert) {
            console.log("Raw revert:");
            console.logBytes(rawRevert);
        }

        // 4.2 Try low-level call
        console.log("\nTrying low-level call...");
        vm.prank(WALLET_OWNER);
        (bool success, bytes memory result) = ERC6551_WALLET.call(
            abi.encodeWithSignature(
                "execute(address,uint256,bytes)",
                VOTE_ESCROW,
                0,
                unlockCall
            )
        );
        console.log("Success:", success);
        if (!success) {
            console.log("Raw result:");
            console.logBytes(result);
        }

        // 4.3 Try direct unlock call to VoteEscrow
        console.log("\nTrying direct unlock call...");
        vm.prank(ERC6551_WALLET);
        (success, result) = VOTE_ESCROW.call(unlockCall);
        console.log("Direct unlock success:", success);
        if (!success) {
            console.log("Direct unlock result:");
            console.logBytes(result);
        }
    }
}
