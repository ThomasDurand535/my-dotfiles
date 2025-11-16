#!/bin/bash

OPTIONS="  Lock\n󰜉  Reboot\n󰐥  Shutdown"

CHOICE=$(echo -e "$OPTIONS" | wofi --dmenu -i --prompt "Power Options" --width 300 --height 220 --hide-search)

case "$CHOICE" in
    "  Lock")
        hyprlock &
        ;;
    "󰜉  Reboot")
        CONFIRM=$(echo -e "Yes\nNo" | wofi --dmenu -i --prompt "Reboot?" --width 200 --height 150 --hide-search)
        if [ "$CONFIRM" = "Yes" ]; then
            systemctl reboot
        fi
        ;;
    "󰐥  Shutdown")
        # Confirmation avant extinction
        CONFIRM=$(echo -e "Yes\nNo" | wofi --dmenu -i --prompt "Shutdown?" --width 200 --height 150 --hide-search)
        if [ "$CONFIRM" = "Yes" ]; then
            systemctl poweroff
        fi
        ;;
    *)
        exit 0
        ;;
esac
