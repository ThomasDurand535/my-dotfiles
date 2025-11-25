#!/bin/bash

# Menu d'actions avec rofi et icônes FontAwesome

# Définir les options avec icônes Unicode FontAwesome
OPTIONS="󰖩  Wifi\n󰂯  Bluetooth\n󰡨  Docker\n󰄮  Btop\n󰂚  Notification Center\n󰐥  Power"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Actions" -theme "$HOME/.config/rofi/configs/trigger.rasi")

case "$CHOICE" in
    "󰖩  Wifi")
        # Ouvre le gestionnaire wifi (adapte selon ton environnement)
        alacritty -e gazelle &
        # Alternative: nmtui ou nmcli
        ;;
    "󰂯  Bluetooth")
        # Ouvre le gestionnaire bluetooth
        alacritty -e bluetui &
        # Alternative: bluetoothctl
        ;;
    "󰡨  Docker")
        # Ouvre un terminal avec docker stats ou lazydocker
        alacritty -e lazydocker &
        # Alternative: alacritty -e lazydocker
        ;;
    "󰄮  Btop")
        # Ouvre btop dans un terminal
        alacritty -e btop &
        # Alternative: alacritty -e btop
        ;;
    "󰂚  Notification Center")
        # Ouvre le centre de notifications (adapte selon ton environnement)
        swaync-client -t &
        # Alternative pour d'autres gestionnaires: dunstctl history-pop
        ;;
    "󰐥  Power")
        # Lance le sous-menu power
        ~/.config/rofi/menus/power.sh &
        ;;
    *)
        exit 0
        ;;
esac

