#!/bin/bash

# Check if .env exists
if [ ! -f .env ]; then
    echo "Creating .env file from example..."
    cp .env.example .env
    echo "Please edit .env and add your private key"
    exit 1
fi

# Source .env file
source .env

# Check if USER_PRIVATE_KEY is set
if [ -z "$USER_PRIVATE_KEY" ]; then
    echo "Error: USER_PRIVATE_KEY not set in .env"
    echo "Please add your private key to .env"
    exit 1
fi

# Run simulation first
echo "Running simulation..."
forge script script/BlastScript.s.sol --rpc-url $BLAST_RPC_URL -vvv --sig "run()" --dry-run

# Ask for confirmation
read -p "Simulation complete. Would you like to execute the transaction? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Execute actual transaction
    forge script script/BlastScript.s.sol --rpc-url $BLAST_RPC_URL --broadcast -vvv
fi
