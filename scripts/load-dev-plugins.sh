#!/bin/bash
#
# load-dev-plugins.sh
#
# Generates tmux commands to load local dev plugins or fall back to TPM
# Usage in tmux.conf: run-shell '~/.config/tmux/scripts/load-dev-plugins.sh'
#

# Define plugins that support local dev
# Format: "plugin_dir github_repo entry_script"
declare -a plugins=(
    "dracula-tmux mrowling/dracula-tmux dracula.tmux"
    "tmux-carelink-go mrowling/tmux-carelink-go carelink.tmux"
    "tmux-hints-plugin mrowling/tmux-hints-plugin tmux-hints-plugin.tmux"
)

for plugin_info in "${plugins[@]}"; do
    read -r plugin_dir github_repo entry_script <<< "$plugin_info"
    
    local_path="$HOME/code/$plugin_dir"
    
    # Check if we should use local dev version
    if [ -n "$TMUX_LOCAL_DEV" ] && [ -d "$local_path" ]; then
        # Run local copy
        tmux run "$local_path/$entry_script"
    else
        # Use TPM plugin
        tmux set-option -gqa @plugin "$github_repo"
    fi
done
