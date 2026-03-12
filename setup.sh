#!/bin/bash

# Tmux Configuration Setup Script

set -e

# Install TPM (Tmux Plugin Manager) if not already installed
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "Installing Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm plugins/tpm
else
    echo "TPM already installed, skipping..."
fi

echo ""
echo "Setup complete!"
echo ""
echo "Next steps:"
echo "1. Start tmux"
echo "2. Install plugins: Press prefix + I (capital i) inside tmux"
echo "   (default prefix is Ctrl+b)"
echo ""
