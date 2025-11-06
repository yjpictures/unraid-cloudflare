#!/bin/bash
echo "Uninstalling Cloudflared plugin..."

RC_SCRIPT="/etc/rc.d/rc.cloudflared"
BIN_PATH="/usr/local/bin/cloudflared"
PLUGIN_PATH="/boot/config/plugins/cloudflared"

# Stop service
if [ -x "$RC_SCRIPT" ]; then
    $RC_SCRIPT stop
fi

# Remove binary
[ -f "$BIN_PATH" ] && rm -f "$BIN_PATH"

# Remove rc script
[ -f "$RC_SCRIPT" ] && rm -f "$RC_SCRIPT"

# Remove plugin files
[ -d "$PLUGIN_PATH" ] && rm -rf "$PLUGIN_PATH"

# Remove go auto-start
sed -i '/rc.cloudflared start/d' /boot/config/go

echo "Cloudflared plugin uninstalled."
