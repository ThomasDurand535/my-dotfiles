#!/usr/bin/env bash
# ==========================
#     CONFIGURATION
# ==========================
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
CURRENT_WALLPAPER_FILE="$HOME/.cache/current_wallpaper"
[[ -f "$CURRENT_WALLPAPER_FILE" ]] && CURRENT_WALLPAPER="$(cat "$CURRENT_WALLPAPER_FILE")"

# ==========================
#     BUILD ROFI MENU
# ==========================
generate_menu() {
    local index=0
    for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png}; do
        [[ -f "$img" ]] || continue

        # Marquer le fond actif avec une coche
        if [[ "$img" == "$CURRENT_WALLPAPER" ]]; then
            label="✓ $(basename "$img")"
        else
            label="  $(basename "$img")"
        fi

        # Format Rofi: label\0icon\x1fimage_path\x1finfo\x1findex
        echo -en "$label\0icon\x1f$img\x1finfo\x1f$index\n"
        ((index++))
    done
}

# ==========================
#   RUN ROFI SELECTION
# ==========================
# Utiliser -format 'i' pour retourner l'index sélectionné
selected_index=$(generate_menu | rofi -dmenu \
    -i \
    -p "Select Wallpaper" \
    -show-icons \
    -theme "$HOME/.config/rofi/configs/wallpaper.rasi" \
    -format 'i' \
    -theme-str 'element-icon { size: 200px; }')

# ==========================
#   APPLY WALLPAPER
# ==========================
if [[ -n "$selected_index" ]]; then
    # Récupérer le chemin de l'image via l'index
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
        # Décharger tous les anciens wallpapers
        hyprctl hyprpaper unload all >/dev/null 2>&1

        # Précharger le nouveau wallpaper
        hyprctl hyprpaper preload "$original_path"

        # Appliquer sur tous les moniteurs
        for monitor in $(hyprctl monitors -j | jq -r '.[].name'); do
            hyprctl hyprpaper wallpaper "$monitor,$original_path"
        done

        # Sauvegarder le choix
        echo "$original_path" > "$CURRENT_WALLPAPER_FILE"

        notify-send "Hyprpaper" "Wallpaper applied: $(basename "$original_path")"
    else
        notify-send "Hyprpaper" "File not found" --urgency=critical
    fi
fi
