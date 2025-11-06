#!/bin/bash
PLUGIN_PATH="/boot/config/plugins/cloudflared"
BIN_PATH="/usr/local/bin/cloudflared"
RC_SCRIPT="/etc/rc.d/rc.cloudflared"

echo "Installing Cloudflared plugin..."
mkdir -p "$PLUGIN_PATH"

# Copy rc script
cp src/rc.cloudflared "$RC_SCRIPT"
chmod +x "$RC_SCRIPT"

# Download cloudflared binary
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then
    curl -L -o "$BIN_PATH" "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64"
elif [[ "$ARCH" == "aarch64" ]]; then
    curl -L -o "$BIN_PATH" "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64"
fi
chmod +x "$BIN_PATH"

# Enable auto-start
grep -q "rc.cloudflared start" /boot/config/go || echo "/etc/rc.d/rc.cloudflared start" >> /boot/config/go

echo "Installation complete."
