// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

/**
 * @title IERC6551Account
 * @notice Minimal interface for ERC6551 token bound accounts
 * @dev See: https://eips.ethereum.org/EIPS/eip-6551
 */
interface IERC6551Account {
    /// @notice Returns the owner of the account
    /// @return The address of the owner
    function owner() external view returns (address);

    /// @notice Returns the token contract and token ID this account is bound to
    function token() external view returns (uint256 chainId, address tokenContract, uint256 tokenId);

    /// @notice Generic execution function
    /// @dev Should execute a transaction from this account
    /// @param to The target address for the transaction
    /// @param value The native token value to send
    /// @param data The calldata for the transaction
    /// @return The bytes returned from the transaction
    function execute(
        address to,
        uint256 value,
        bytes calldata data
    ) external payable returns (bytes memory);

    /// @notice Returns the implementation address for this account
    function implementation() external view returns (address);
}
