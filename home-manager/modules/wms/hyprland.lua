local mainMod = "SUPER"
local exec = hl.dsp.exec_cmd

hl.monitor({
    output   = "",
    mode     = "1920x1080@90",
    position = "auto",
    scale    = 1,
})

hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("XDG_SCREENSHOTS_DIR", os.getenv("HOME") .. "/screens")

hl.on("hyprland.start", function()
    hl.exec_cmd("awww-daemon; awww img ~/.wp.jpg")
    hl.exec_cmd("waybar")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

hl.config({
    input = {
        kb_layout  = "pl,ru",
        kb_options = "grp:ctrl_space_toggle",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = { natural_scroll = false },
    },

    general = {
        gaps_in     = 5,
        gaps_out    = 20,
        border_size = 3,
        col = {
            active_border   = { colors = { "rgba(88c0d0ff)", "rgba(81a1c1ff)" }, angle = 45 },
            inactive_border = "rgba(4c566aff)",
        },
        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
        blur = {
            enabled = true,
            size    = 8,
            passes  = 2,
        },
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
    },

    animations = { enabled = true },

    dwindle = { preserve_split = true },
    master  = { new_status = "master" },

    gestures = {
        workspace_swipe_distance = 200,
        workspace_swipe_invert   = false,
        workspace_swipe_forever  = true,
    },

    misc = {
        animate_manual_resizes       = true,
        animate_mouse_windowdragging = true,
        enable_swallow               = true,
        disable_hyprland_logo        = true,
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

hl.window_rule({
    name  = "float-media",
    match = { class = "^(imv|mpv)$" },
    float = true,
})

hl.bind(mainMod .. " + Return", exec("alacritty"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", exec("dolphin"))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", exec("fuzzel"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + V", exec("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))

local dirs = { left = "left", right = "right", up = "up", down = "down" }
local resize = {
    left  = { x = -60, y = 0 },
    right = { x = 60,  y = 0 },
    up    = { x = 0,   y = -60 },
    down  = { x = 0,   y = 60 },
}

for key, dir in pairs(dirs) do
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = dir }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.swap({ direction = dir }))
    hl.bind(mainMod .. " + CTRL + " .. key,
        hl.dsp.window.resize({ x = resize[key].x, y = resize[key].y, relative = true }))
end

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + F3", exec("brightnessctl -d '*::kbd_backlight' set +33%"))
hl.bind(mainMod .. " + F2", exec("brightnessctl -d '*::kbd_backlight' set 33%-"))

local media = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume",  exec("pamixer -i 5"), media)
hl.bind("XF86AudioLowerVolume",  exec("pamixer -d 5"), media)
hl.bind("XF86AudioMute",         exec("pamixer -t"), { locked = true })
hl.bind("XF86AudioMicMute",      exec("pamixer --default-source -m"), { locked = true })
hl.bind("XF86MonBrightnessDown", exec("brightnessctl set 5%-"), media)
hl.bind("XF86MonBrightnessUp",   exec("brightnessctl set +5%"), media)

hl.bind(mainMod .. " + SHIFT + N", exec("alacritty -e rb"))
hl.bind(mainMod .. " + SHIFT + C", exec("alacritty -e conf"))
hl.bind(mainMod .. " + SHIFT + H", exec("alacritty -e nvim ~/nix/home-manager/modules/wms/hyprland.nix"))
hl.bind(mainMod .. " + SHIFT + W", exec("alacritty -e nvim ~/nix/home-manager/modules/wms/waybar.nix"))
hl.bind(mainMod .. " + SHIFT + S", exec("grimblast --freeze copysave area"))

hl.bind(mainMod .. " + B", exec("pkill -SIGUSR1 waybar"))
hl.bind(mainMod .. " + W", exec("pkill -SIGUSR2 waybar"))
hl.bind(mainMod .. " + SHIFT + G", exec("~/.config/hypr/gamemode.sh"))
