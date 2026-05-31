-- Main Hyprland Lua config loader
HOME = os.getenv("HOME") or "/home/thomas"
CONFIG_DIR = HOME .. "/.config/hypr"

terminal = "alacritty -e zsh"
fileManager = "nautilus"
menu = "rofi -show drun -theme ~/.config/rofi/configs/apps.rasi"
menu_trigger = "~/.config/rofi/menus/trigger.sh"
background_switcher = "~/.config/rofi/menus/wallpaper-selector.sh"
clipboard_menu = "~/.config/rofi/menus/clipboard.sh"
locker = "hyprlock"
menu_hyprshot = "~/.config/rofi/menus/hyprshot.sh"
color_picker = "hyprpicker --autocopy"
bar = "waybar"
barOptions = "-c ~/.config/waybar/topV1/config -s ~/.config/waybar/topV1/style.css"
cursor_theme = "WhiteSur-cursors 24"
mainMod = "SUPER"

LAND_DIR = CONFIG_DIR .. "/land.conf.d"

local function load_land(name)
    dofile(LAND_DIR .. "/" .. name)
end

load_land("monitors.lua")
dofile(CONFIG_DIR .. "/env.lua")
load_land("autostart.lua")
load_land("permissions.lua")
load_land("look.lua")
load_land("input.lua")
load_land("keybindings.lua")
load_land("windows-workspaces.lua")
