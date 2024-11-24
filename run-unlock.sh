#!/bin/bash

# Check if .env exists, if not create from example
if [ ! -f .env ]; then
    echo "Creating .env file from .env.example..."
    cp .env.example .env
    echo "Please add your private key to .env"
    exit 1
fi

# Source the .env file
source .env

# Check if OWNER_PRIVATE_KEY is set
if [ -z "$OWNER_PRIVATE_KEY" ]; then
    echo "Error: OWNER_PRIVATE_KEY not set in .env"
    echo "Please add your private key to .env"
    exit 1
fi

# Execute the script
echo "Executing unlock transaction..."
forge script script/VoteEscrowUnlock.s.sol \
    --rpc-url https://rpc.blast.io \
    --broadcast \
    -vvv
