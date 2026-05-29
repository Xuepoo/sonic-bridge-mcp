#!/bin/bash
set -e

# Colored output utilities
INFO="\033[1;36m[*]\033[0m"
SUCCESS="\033[1;32m[+]\033[0m"
WARN="\033[1;33m[!]\033[0m"
STEP="\033[1;34m[*]\033[0m"

echo -e "\033[1;35mSonicBridge MCP - Pure-Rust High-Performance Installer\033[0m"
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

# 3. Configure Claude Desktop automatically
echo -e "${STEP} Step 3: Configuring Claude Desktop MCP JSON settings..."
CLAUDE_CONFIG_DIR="$HOME/.config/Claude"
CLAUDE_CONFIG_FILE="$CLAUDE_CONFIG_DIR/claude_desktop_config.json"

mkdir -p "$CLAUDE_CONFIG_DIR"

if [ -f "$CLAUDE_CONFIG_FILE" ]; then
    if grep -q "sonic-bridge-mcp" "$CLAUDE_CONFIG_FILE"; then
        echo -e "${SUCCESS} Configuration already exists in $CLAUDE_CONFIG_FILE. Skipping rewrite."
    else
        echo -e "${WARN} $CLAUDE_CONFIG_FILE already exists but lacks sonic-bridge. Please manually merge the following block into your config:"
        echo -e '
{
  "mcpServers": {
    "sonic-bridge": {
      "command": "sonic-bridge-mcp",
      "args": []
    }
  }
}'
    fi
else
    cat << 'EOF' > "$CLAUDE_CONFIG_FILE"
{
  "mcpServers": {
    "sonic-bridge": {
      "command": "sonic-bridge-mcp",
      "args": []
    }
  }
}
EOF
    echo -e "${SUCCESS} Successfully created and configured $CLAUDE_CONFIG_FILE!"
fi

echo -e "========================================================="
echo -e "\033[1;32m[+] All Installation Steps Succeeded! Please restart your Claude Desktop or Cursor client to activate the tools.\033[0m"
