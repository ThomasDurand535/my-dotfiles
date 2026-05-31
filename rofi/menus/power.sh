#!/bin/bash

OPTIONS="\n󰜉\n\n󰐥"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "" -theme "$HOME/.config/rofi/configs/power.rasi")

case "$CHOICE" in
    *""*)
        hyprlock &
        ;;
    *"󰜉"*)
        systemctl reboot
	;;
    *""*)
    	killall Hyprland
        ;;
    *"󰐥"*)
        systemctl poweroff
        ;;
    *)
        exit 0
        ;;
esac
