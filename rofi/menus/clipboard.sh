#!/bin/bash


cliphist list | rofi -dmenu -theme ~/.config/rofi/configs/clipboard.rasi | cliphist decode | wl-copy
