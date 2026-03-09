#!/usr/bin/env bash
set -e

REPO="https://github.com/Mokhtar25/.dot.git"
NVIM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
BRANCH="${1:-main}"

# Install neovim if missing
if ! command -v nvim &>/dev/null; then
    echo "Neovim not found. Installing..."
    if command -v apt-get &>/dev/null; then
        sudo apt-get update && sudo apt-get install -y neovim git
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y neovim git
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm neovim git
    elif command -v apk &>/dev/null; then
        sudo apk add neovim git
    else
        echo "Cannot detect package manager. Install neovim and git manually."
        exit 1
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
