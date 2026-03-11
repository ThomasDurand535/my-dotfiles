#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
THUMB_DIR="$HOME/.cache/wallpaper-thumbs"
CURRENT_WALLPAPER_FILE="$HOME/.cache/current_wallpaper"

mkdir -p "$THUMB_DIR"
[[ -f "$CURRENT_WALLPAPER_FILE" ]] && CURRENT_WALLPAPER="$(cat "$CURRENT_WALLPAPER_FILE")"

generate_menu() {
    local index=0
    for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png}; do
        [[ -f "$img" ]] || continue

        thumb="$THUMB_DIR/$(basename "$img")"
        if [[ ! -f "$thumb" ]]; then
            convert "$img" -gravity Center -resize 320x180^ -extent 320x180 "$thumb"
        fi

        if [[ "$img" == "$CURRENT_WALLPAPER" ]]; then
            label="✓ $(basename "$img")"
        else
            label="  $(basename "$img")"
        fi

        echo -en "$label\0icon\x1f$thumb\x1finfo\x1f$index\n"
        ((index++))
    done
}

selected_index=$(generate_menu | rofi -dmenu \
    -i \
    -p "Select Wallpaper" \
    -show-icons \
    -theme "$HOME/.config/rofi/configs/wallpaper.rasi" \
    -format 'i' \
    -theme-str 'element-icon { size: 200px; }')

if [[ -n "$selected_index" ]]; then
    index=0
    for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png}; do
        [[ -f "$img" ]] || continue
        if [[ $index -eq $selected_index ]]; then
            original_path="$img"
            break
        fi
        ((index++))
    done

    if [[ -n "$original_path" && -f "$original_path" ]]; then
        hyprctl hyprpaper wallpaper ",$original_path"
        echo "$original_path" > "$CURRENT_WALLPAPER_FILE"
        notify-send "Hyprpaper" "Wallpaper applied: $(basename "$original_path")"
    else
        notify-send "Hyprpaper" "File not found" --urgency=critical
    fi
fi
