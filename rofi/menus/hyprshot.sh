#!/bin/bash

# Hyprshot Rofi Menu Script
# Two-step workflow: Select capture mode, then select save destination

# Define default save directory (modify as needed)
SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

# Step 1: Select capture mode
mode_options="󱂬\n󱣴\n󰍹"
selected_mode=$(echo -e "$mode_options" | rofi -dmenu -i -p "" -theme "$HOME/.config/rofi/configs/hyprshot-mode.rasi")

# Exit if cancelled
if [ -z "$selected_mode" ]; then
    exit 0
fi

# Step 2: Select save destination
save_options="󰆓\n󰆒"
selected_save=$(echo -e "$save_options" | rofi -dmenu -i -p "" -theme "$HOME/.config/rofi/configs/hyprshot-destination.rasi")

# Exit if cancelled
if [ -z "$selected_save" ]; then
    exit 0
fi

# Determine hyprshot mode flag
case "$selected_mode" in
    *"󱣴"*)
        MODE_FLAG="-m region"
        MODE_NAME="Region"
        ;;
    *"󱂬"*)
        MODE_FLAG="-m window"
        MODE_NAME="Window"
        ;;
    *"󰍹"*)
        MODE_FLAG="-m output"
        MODE_NAME="Monitor"
        ;;
esac

# Execute based on save destination
case "$selected_save" in
    *"󰆓"*)
        hyprshot $MODE_FLAG -o "$SAVE_DIR"
        ;;

    *"󰆒"*)
        hyprshot $MODE_FLAG --clipboard-only
        ;;
esac
