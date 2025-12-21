#!/bin/bash

# Menu d'actions avec rofi et icônes FontAwesome

# Définir les options avec icônes Unicode FontAwesome
OPTIONS="󰖩   Wifi\n󰂯 Bluetooth\n󰡨  Docker\n  Git\n   Btop\n    Wiremix\n  Gdu\n󰐥  Power"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Actions" -theme "$HOME/.config/rofi/configs/trigger.rasi")

case "$CHOICE" in
    "󰖩   Wifi")
        alacritty -e gazelle &
        ;;
    "󰂯 Bluetooth")
        alacritty -e bluetui &
        ;;
    "󰡨  Docker")
        alacritty -e lazydocker &
        ;;
    "  Git")
    	alacritty -e bash -c "echo n | lazygit" &
        ;;
    "   Btop")
        alacritty -e btop &
        ;;
    "    Wiremix")
        alacritty -e wiremix &
        ;;
    "  Gdu")
    	alacritty -e gdu / &
     	;;
    "󰐥  Power")
        # Lance le sous-menu power
        ~/.config/rofi/menus/power.sh &
        ;;
    *)
        exit 0
        ;;
esac
