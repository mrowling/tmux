#!/bin/bash
#
# toggle-hints.sh - Toggle tmux-hints pane (global single instance)
#
# Usage: Called by tmux keybinding with pane_id argument
#   toggle-hints.sh "#{pane_id}"
#
# Ensures only ONE hints pane exists globally at any time.
# The hints pane follows your focus across all windows.
#

HINTS_SCRIPT="/home/mrowling/code/tmux-hints/tmux-hints.sh"
HINTS_DIR="/home/mrowling/code/tmux-hints"
HINTS_WIDTH="30"

# Get current pane ID (passed as argument)
CURRENT_PANE="$1"

# Global registration key - stores the one and only hints sidebar
GLOBAL_HINTS_PANE="@global-hints-pane"

# Get the global hints pane ID
get_global_hints_pane() {
    tmux show-option -gqv "$GLOBAL_HINTS_PANE"
}

# Check if hints pane still exists
hints_pane_exists() {
    local pane_id="$1"
    tmux list-panes -a -F "#{pane_id}" 2>/dev/null | grep -q "^${pane_id}$"
}

# Register the global hints pane
register_hints_pane() {
    local pane_id="$1"
    tmux set-option -gq "$GLOBAL_HINTS_PANE" "$pane_id"
}

# Unregister the global hints pane
unregister_hints_pane() {
    tmux set-option -gu "$GLOBAL_HINTS_PANE"
}

# Kill any existing hints panes (cleanup)
kill_all_hints_panes() {
    # Find all panes running tmux-hints.sh and kill them
    tmux list-panes -a -F "#{pane_id} #{pane_start_command}" 2>/dev/null | \
        grep "tmux-hints.sh" | \
        awk '{print $1}' | \
        while read pane_id; do
            tmux kill-pane -t "$pane_id" 2>/dev/null
        done
}

# Main toggle logic
HINTS_PANE_ID=$(get_global_hints_pane)

# Check if we have a registered hints pane
if [ -n "$HINTS_PANE_ID" ]; then
    if hints_pane_exists "$HINTS_PANE_ID"; then
        # Hints pane exists and is registered - toggle it off
        tmux kill-pane -t "$HINTS_PANE_ID"
        unregister_hints_pane
    else
        # Stale registration - clean it up
        unregister_hints_pane
        # Also clean up any orphaned hints panes
        kill_all_hints_panes
        # Now create a new one on the far right
        RIGHTMOST_PANE=$(tmux list-panes -F "#{pane_id} #{pane_right}" | sort -k2 -n -r | head -1 | cut -d' ' -f1)
        # Get the current pane's command to pass to hints script
        CURRENT_CMD=$(tmux display-message -p -t "$CURRENT_PANE" "#{pane_current_command}")
        NEW_HINTS_ID=$(tmux split-window -h -d -t "$RIGHTMOST_PANE" -p "$HINTS_WIDTH" -c "$HINTS_DIR" -P -F "#{pane_id}" "$HINTS_SCRIPT -i '$CURRENT_CMD'")
        # Return focus to original pane
        tmux select-pane -t "$CURRENT_PANE"
        register_hints_pane "$NEW_HINTS_ID"
    fi
else
    # No hints pane registered - clean up any orphans and create new one
    kill_all_hints_panes
    
    # Create new hints pane on the far right:
    # First, find the rightmost pane by repeatedly going right until we can't
    # -h: horizontal split
    # -d: don't switch focus to new pane
    # -p: percentage width
    # -c: start directory
    # -P -F: print the new pane_id
    RIGHTMOST_PANE=$(tmux list-panes -F "#{pane_id} #{pane_right}" | sort -k2 -n -r | head -1 | cut -d' ' -f1)
    # Get the current pane's command to pass to hints script
    CURRENT_CMD=$(tmux display-message -p -t "$CURRENT_PANE" "#{pane_current_command}")
    NEW_HINTS_ID=$(tmux split-window -h -d -t "$RIGHTMOST_PANE" -p "$HINTS_WIDTH" -c "$HINTS_DIR" -P -F "#{pane_id}" "$HINTS_SCRIPT -i '$CURRENT_CMD'")
    # Return focus to original pane
    tmux select-pane -t "$CURRENT_PANE"
    register_hints_pane "$NEW_HINTS_ID"
fi
