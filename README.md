# VoteEscrow Token Scripts 🔓

Scripts to help you:

1. Unlock your tokens from VoteEscrow contract
2. Transfer unlocked PTC tokens to your wallet

## Important Information

These scripts interact with:

- VoteEscrow Contract: `0xF2892576A740aD8d302F8C1c9F05cb3472976C3F`
- PTC Token: `0xa027a3A04b44f79560153234E999b17C88e22DB9`
- Your ERC-6551 Wallet: `0x9dBD5ddCc8BE91292B96D420cE462FF64f303C53`

⚠️ **IMPORTANT**: You must be the owner of the ERC-6551 wallet to use these scripts.

## Prerequisites

Install these tools:

1. Git: [Download here](https://git-scm.com/downloads)
2. Foundry:

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

## Initial Setup

1. Clone this repository:

```bash
git clone [repository-url]
cd vote-escrow-unlock
```

2. Install Foundry dependencies:

```bash
forge install
```

3. Create environment file:

```bash
cp .env.example .env
```

4. Edit `.env` and add your private key:

```
OWNER_PRIVATE_KEY=your_private_key_here
```

⚠️ **CRITICAL**: Never share your private key with anyone

- Remove '0x' prefix if present
- Make sure there are no extra spaces

5. Make scripts executable:

```bash
chmod +x run-unlock.sh
chmod +x run-transfer.sh
```

## Step 1: Unlocking Tokens

1. Execute unlock script:

```bash
./run-unlock.sh
```

2. Expected output:

```
==> Starting unlock process...
==> Executing transaction...
[... transaction details ...]
==> Transaction submitted successfully! 🎉
```

3. Wait for transaction to be confirmed before proceeding to Step 2.

## Step 2: Transferring PTC Tokens

After successful unlock and confirmation:

1. Run transfer script:

```bash
./run-transfer.sh
```

2. Expected output:

```
==> Starting PTC token transfer process...
==> Found PTC balance: [your balance]
==> Transaction submitted successfully! 🎉
==> PTC tokens have been transferred to your wallet
```

## Troubleshooting

### General Issues

Error: "Cannot find .env file"

```bash
cp .env.example .env
# Then add your private key to .env
```

Error: "Permission denied: ./run-[script].sh"

```bash
chmod +x run-unlock.sh
chmod +x run-transfer.sh
```

Error: "Invalid private key"

- Check no '0x' prefix
- No spaces or newlines
- Private key is correct for your wallet

### Unlock Script Issues

Error: "Transaction failed" during unlock
Common causes:

- Tokens not yet unlockable
- Wrong private key
- Not the wallet owner

### Transfer Script Issues

Error: "No PTC tokens in wallet"

- Ensure unlock script completed successfully
- Wait for unlock transaction confirmation
- Check ERC-6551 wallet balance

Error: "Transaction failed" during transfer
Common causes:

- Unlock not completed
- Wrong private key
- Not the wallet owner
- Insufficient gas

## Expected Workflow

1. Run unlock script
2. Wait for confirmation (check your wallet/block explorer)
3. Run transfer script
4. Verify PTC tokens in your wallet

## Support

Contact the repository owner for support.

## Security Notes

- Never share your private key
- Always verify transaction details before confirming
- Keep your .env file secure
- Delete your private key from .env after use
