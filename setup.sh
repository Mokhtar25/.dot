#!/usr/bin/env bash
set -e

REPO="https://github.com/Mokhtar25/.dot.git"
NVIM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
BRANCH="${1:-remote}"

# Install neovim via appimage if missing or too old
NEED_NVIM=false
if ! command -v nvim &>/dev/null; then
    NEED_NVIM=true
elif [ "$(nvim --version | head -1 | grep -oP '\d+\.\d+' | head -1 | tr -d '.')" -lt 8 ] 2>/dev/null; then
    echo "Neovim version too old, upgrading..."
    NEED_NVIM=true
fi

if [ "$NEED_NVIM" = true ]; then
    echo "Installing Neovim v0.11.6..."
    wget -O /tmp/nvim.appimage https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-x86_64.appimage
    chmod +x /tmp/nvim.appimage
    # Try running directly, fall back to extracting if FUSE unavailable
    if /tmp/nvim.appimage --version &>/dev/null; then
        sudo mv /tmp/nvim.appimage /usr/local/bin/nvim
    else
        cd /tmp
        ./nvim.appimage --appimage-extract
        sudo mv squashfs-root /opt/nvim
        sudo ln -sf /opt/nvim/usr/bin/nvim /usr/local/bin/nvim
        rm -f /tmp/nvim.appimage
    fi
fi

# Backup existing config if present
if [ -d "$NVIM_DIR" ]; then
    BACKUP="$NVIM_DIR.bak.$(date +%s)"
    echo "Backing up existing config to $BACKUP"
    mv "$NVIM_DIR" "$BACKUP"
fi

# Clone config
echo "Cloning config from $REPO (branch: $BRANCH)..."
git clone --branch "$BRANCH" "$REPO" "$NVIM_DIR"

# First launch installs lazy.nvim + all plugins automatically
echo ""
echo "Done! Run 'nvim' to finish plugin installation."
