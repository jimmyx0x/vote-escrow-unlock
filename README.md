# VoteEscrow Token Unlock Script 🔓

Simple script to unlock your VoteEscrow tokens from your ERC-6551 wallet on Blast network.

## Important Information

This script will unlock tokens from:
- VoteEscrow Contract: `0xF2892576A740aD8d302F8C1c9F05cb3472976C3F`
- Your ERC-6551 Wallet: `0x9dBD5ddCc8BE91292B96D420cE462FF64f303C53`

⚠️ **IMPORTANT**: You must be the owner of the ERC-6551 wallet to use this script.

## Prerequisites

Install these tools:

1. Git: [Download here](https://git-scm.com/downloads)
2. Foundry: 
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

## Setup Instructions

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

5. Make script executable:
```bash
chmod +x run-unlock.sh
```

## Running the Script

1. Execute:
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

## Troubleshooting

### Error: "Cannot find .env file"
```bash
cp .env.example .env
# Then add your private key to .env
```

### Error: "Permission denied: ./run-unlock.sh"
```bash
chmod +x run-unlock.sh
```

### Error: "Invalid private key"
- Check no '0x' prefix
- No spaces or newlines
- Private key is correct for your wallet

### Error: "Transaction failed"
Common causes:
- Tokens not yet unlockable
- Wrong private key
- Not the wallet owner

## Support

Contact the repository owner for support.
