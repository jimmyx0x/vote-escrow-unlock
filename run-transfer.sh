#!/bin/bash

# Text colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored status
print_status() {
    echo -e "${GREEN}==>${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}Warning:${NC} $1"
}

print_error() {
    echo -e "${RED}Error:${NC} $1"
}

# Check if .env exists
if [ ! -f .env ]; then
    print_status "Creating .env file from example..."
    cp .env.example .env
    print_warning "Please add your private key to .env file"
    exit 1
fi

# Source .env file
source .env

# Check if OWNER_PRIVATE_KEY is set
if [ -z "$OWNER_PRIVATE_KEY" ]; then
    print_error "OWNER_PRIVATE_KEY not set in .env"
    print_warning "Please add your private key to .env file"
    exit 1
fi

# Main execution
print_status "Starting PTC token transfer process..."

print_status "Executing transaction..."
forge script script/TransferPTC.s.sol \
    --rpc-url https://rpc.blast.io \
    --broadcast \
    -vvv

if [ $? -eq 0 ]; then
    print_status "Transaction submitted successfully! 🎉"
    print_status "PTC tokens have been transferred to your wallet."
else
    print_error "Transaction failed. Please check the error message above."
fi
