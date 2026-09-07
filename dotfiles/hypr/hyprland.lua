-- Hyprland Lua Configuration
-- Transferred from hyprland.conf

------------------
---- MONITORS ----
------------------

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

------------------
---- CURSOR ----
------------------

hl.config({
    cursor = {
        no_hardware_cursors = false,
    },
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "ghostty"
local fileManager = "thunar"
local menu = "rofi -show drun"
local zen = "flatpak run app.zen_browser.zen"
local firefox = "firefox"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start awww && sleep 1 && awww img /persist/etc/nixos/wallpapers/wallpaper.png --transition-type wipe --transition-angle 45 --transition-step 90")
    hl.exec_cmd("waybar & nm-applet & hyprsunset --temperature 2000")
    hl.exec_cmd("systemctl --user start hyprpolkitagent && blueman-applet")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("wl-clip-persist --clipboard both")
    hl.exec_cmd("sleep 5 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 0")
    hl.exec_cmd("fcitx5 -d -r")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Catppuccin Mocha Glow
hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 2,
        col = {
            -- Mauve -> Sapphire -> Lavender
            active_border = { colors = { "rgba(cba6f7ee)", "rgba(89b4faee)", "rgba(b4befeee)" }, angle = 45 },
            inactive_border = "rgba(31324488)", -- Muted Catppuccin Surface
        },
        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
        shadow = {
            enabled = true,
            range = 15,
            render_power = 3,
            color = "rgba(18182588)", -- Deep dark shadow
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Curves
hl.curve("snappy", { type = "bezier", points = { {0.05, 0.95},  {0.1, 1.05}   } })
hl.curve("silky",  { type = "bezier", points = { {0.16, 1.0},   {0.3, 1.0}    } })
hl.curve("winIn",  { type = "bezier", points = { {0.2, 1.3},    {0.4, 1.0}    } })
hl.curve("winOut", { type = "bezier", points = { {0.3, -0.3},   {0.0, 1.0}    } })
hl.curve("linear", { type = "bezier", points = { {1.0, 1.0},    {1.0, 1.0}    } })

-- Faster Assignments
hl.animation({ leaf = "windows",     enabled = true, speed = 2.5, bezier = "snappy", style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 2.5, bezier = "winIn",  style = "popin 90%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 2,   bezier = "winOut", style = "popin 90%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 2.5, bezier = "snappy", style = "slide" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 3,   bezier = "silky",  style = "slide" })
hl.animation({ leaf = "fade",        enabled = true, speed = 2,   bezier = "silky" })
hl.animation({ leaf = "borderangle", enabled = false })

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        sensitivity = 0.5,
        kb_layout = "us",
        follow_mouse = 1,
        kb_options = "caps:swapescape",
        touchpad = {
            natural_scroll = false,
        },
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(zen))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(firefox))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("firefox -P persistent"))

hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind("Print", hl.dsp.exec_cmd('mkdir -p ~/Pictures && grim -g "$(slurp)" - | satty --filename - --fullscreen --output-filename ~/Pictures/$(date +%s).png --copy-command wl-copy --auto-copy --save-after-copy'))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd('mkdir -p ~/Pictures && grim -g "$(slurp)" - | satty --filename - --fullscreen --output-filename ~/Pictures/$(date +%s).png --copy-command wl-copy --early-exit --actions-on-enter save-to-clipboard,save-to-file,exit'))
hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- Move focus with mainMod + HJKL
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move active window within layout with mainMod + SHIFT + HJKL
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Workspaces
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i,     hl.dsp.window.move({ workspace = i }))
end

-- Workspaces 11 - 20 (SUPER + ALT + 1..0)
for i = 1, 9 do
    hl.bind(mainMod .. " + ALT + " .. i,       hl.dsp.focus({ workspace = i + 10 }))
    hl.bind(mainMod .. " + ALT + SHIFT + " .. i, hl.dsp.window.move({ workspace = i + 10 }))
end
hl.bind(mainMod .. " + ALT + 0",               hl.dsp.focus({ workspace = 20 }))
hl.bind(mainMod .. " + ALT + SHIFT + 0",       hl.dsp.window.move({ workspace = 20 }))

-- Multimedia keys (volume and brightness)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Mouse bindings
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

----------------------
---- WINDOW RULES ----
----------------------

hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Force the typing candidate box to render correctly as a floating window
hl.window_rule({
    match = { class = "fcitx" },
    pseudo = true,
})
