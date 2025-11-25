#!/bin/bash

OPTIONS="  Lock\n󰜉  Reboot\n󰐥  Shutdown"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Power Options" -theme "$HOME/.config/rofi/configs/power.rasi")

case "$CHOICE" in
    "  Lock")
        hyprlock &
        ;;
    "󰜉  Reboot")
        CONFIRM=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "Reboot?" -theme "$HOME/.config/rofi/configs/power.rasi")
        if [ "$CONFIRM" = "Yes" ]; then
            systemctl reboot
        fi
        ;;
    "󰐥  Shutdown")
        # Confirmation avant extinction
        CONFIRM=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "Shutdown?" -theme "$HOME/.config/rofi/configs/power.rasi")
        if [ "$CONFIRM" = "Yes" ]; then
            systemctl poweroff
        fi
        ;;
    *)
        exit 0
        ;;
esac

