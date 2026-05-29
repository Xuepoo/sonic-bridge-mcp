#!/bin/bash
set -e

# Colored output utilities
INFO="\033[1;36m[*]\033[0m"
SUCCESS="\033[1;32m[+]\033[0m"
STEP="\033[1;34m[*]\033[0m"

echo -e "\033[1;35mSonicBridge MCP - High-Performance Installer\033[0m"
echo -e "========================================================="

# 1. Compiling release binary
echo -e "${STEP} Step 1: Compiling Rust MCP Server in release mode..."
cargo build --release

# 2. Local installation path (~/.local/bin)
BIN_DIR="$HOME/.local/bin"
echo -e "${STEP} Step 2: Installing binary to user-local PATH (${BIN_DIR})..."
mkdir -p "$BIN_DIR"
cp target/release/sonic-bridge-mcp "$BIN_DIR/"
chmod +x "$BIN_DIR/sonic-bridge-mcp"
echo -e "${SUCCESS} Binary successfully installed to: ${BIN_DIR}/sonic-bridge-mcp"

echo -e "========================================================="
echo -e "\033[1;32m[+] Installation Succeeded!\033[0m"
echo -e "\033[1;33m[!] Note: Please refer to README.md to configure 'sonic-bridge-mcp' in your preferred AI tools (e.g., Claude Desktop, Cursor).\033[0m"
