-- Workspace rules
hl.workspace_rule({ workspace = 1, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 2, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 3, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 4, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 5, monitor = "HDMI-A-1" })

-- Window and workspace rules
hl.layer_rule({ match = { namespace = "rofi" }, blur = true })
hl.layer_rule({ match = { namespace = "wofi" }, blur = true })

hl.window_rule({
    float = true,
    workspace = "1",
    move = "40 80",
    size = "1200 960",
    match = { class = "^(?i);*spotify.*$" },
})

hl.window_rule({
    float = true,
    workspace = "1",
    move = "1280 80",
    size = "600 680",
    match = { title = "^(?i);*cava.*$" },
})

hl.window_rule({
    float = true,
    workspace = "1",
    move = "1280 800",
    size = "600 240",
    match = { title = "^(?i);*tty-clock.*$" },
})

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})
