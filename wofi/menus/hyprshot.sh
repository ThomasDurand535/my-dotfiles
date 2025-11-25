#!/bin/bash

# Hyprshot Wofi Menu Script
# Two-step workflow: Select capture mode, then select save destination

# Define default save directory (modify as needed)
SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

# Step 1: Select capture mode
mode_options="󱂬 Region (Freeze)\n󱣴 Window\n󰍹 Monitor"
selected_mode=$(echo -e "$mode_options" | wofi --dmenu --prompt "Screenshot Mode" --width 350 --height 220 --hide-search)

# Exit if cancelled
if [ -z "$selected_mode" ]; then
    exit 0
fi

# Step 2: Select save destination
save_options="󰆓 Save to Default Path\n󰆒 Copy to Clipboard\n󰉋 Save to Custom Path"
selected_save=$(echo -e "$save_options" | wofi --dmenu --prompt "Save Destination" --width 350 --height 220 --hide-search)

# Exit if cancelled
if [ -z "$selected_save" ]; then
    exit 0
fi

# Determine hyprshot mode flag
case "$selected_mode" in
    "󱂬 Region (Freeze)")
        MODE_FLAG="-m region --freeze"
        MODE_NAME="Region (Frozen)"
        ;;
    "󱣴 Window")
        MODE_FLAG="-m window"
        MODE_NAME="Window"
        ;;
    "󰍹 Monitor")
        MODE_FLAG="-m output"
        MODE_NAME="Monitor"
        ;;
esac

# Execute based on save destination
case "$selected_save" in
    "󰆓 Save to Default Path")
        hyprshot $MODE_FLAG -o "$SAVE_DIR"
        ;;

    "󰆒 Copy to Clipboard")
        hyprshot $MODE_FLAG --clipboard-only
        ;;

    "󰉋 Save to Custom Path")
        custom_path=$(echo "" | wofi --dmenu --prompt "Enter save path (e.g., ~/screenshot.png)" --width 500 --height 100)
        if [ -n "$custom_path" ]; then
            # Expand tilde to home directory
            custom_path="${custom_path/#\~/$HOME}"
            custom_dir="$(dirname "$custom_path")"
            custom_file="$(basename "$custom_path")"

            # Create directory if it doesn't exist
            mkdir -p "$custom_dir"

            # Take screenshot
            hyprshot $MODE_FLAG -o "$custom_dir" -f "$custom_file"
        fi
        ;;
esac
