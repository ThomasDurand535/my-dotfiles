#!/bin/bash

OPTIONS="\n󰜉\n󰐥"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "" -theme "$HOME/.config/rofi/configs/power.rasi")

case "$CHOICE" in
    *""*)
        hyprlock &
        ;;
    *"󰜉"*)
        systemctl reboot
        ;;
    *"󰐥"*)
        systemctl poweroff
        ;;
    *)
        exit 0
        ;;
esac
