#!/bin/bash

# Tmux Configuration Setup Script
# This script copies .tmux.conf to ~/ and installs tmux plugin manager

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up tmux configuration..."

# Copy .tmux.conf to home directory
echo "Copying .tmux.conf to ~/.tmux.conf"
cp "$SCRIPT_DIR/.tmux.conf" ~/.tmux.conf

# Install TPM (Tmux Plugin Manager) if not already installed
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "Installing Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "TPM already installed, skipping..."
fi

echo ""
echo "Setup complete!"
echo ""
echo "Next steps:"
echo "1. Start tmux or reload config: tmux source ~/.tmux.conf"
echo "2. Install plugins: Press prefix + I (capital i) inside tmux"
echo "   (default prefix is Ctrl+b)"
echo ""
