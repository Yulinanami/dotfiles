-- This is the Hyprland 0.55+ Lua version of the repository's original config.
-- It preserves the original programs, behavior, appearance, and key bindings.

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

local terminal = "alacritty"
local fileManager = "dolphin"
local menu = "rofi -show drun"
local mainMod = "SUPER"

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("dunst")
end)

hl.env("XCURSOR_SIZE", "24")

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 1,
        repeat_rate = 40,
        repeat_delay = 300,
        touchpad = {
            natural_scroll = false,
        },
    },
    general = {
        gaps_in = 0,
        gaps_out = 2,
        border_size = 2,
        col = {
            active_border = {
                colors = { "rgba(66ccffaa)", "rgba(66ccffee)" },
                angle = 50,
            },
            inactive_border = "rgba(112233aa)",
        },
        layout = "dwindle",
    },
    decoration = {
        rounding = 3,
        active_opacity = 1,
        inactive_opacity = 0.95,
        shadow = {
            enabled = true,
            range = 10,
            render_power = 1,
            color = 0xee1a1a1a,
        },
        blur = {
            enabled = false,
        },
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
})

hl.curve("wind", {
    type = "bezier",
    points = { { 0.05, 0.9 }, { 0.1, 1.05 } },
})
hl.curve("winIn", {
    type = "bezier",
    points = { { 0.1, 1.1 }, { 0.1, 1.1 } },
})
hl.curve("winOut", {
    type = "bezier",
    points = { { 0.3, -0.3 }, { 0, 1 } },
})
hl.curve("liner", {
    type = "bezier",
    points = { { 1, 1 }, { 1, 1 } },
})

hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "wind" })

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.window_rule({
    match = { class = "^(showmethekey-gtk)$" },
    pin = true,
})

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | tee "$HOME/Pictures/$(date +%H:%M:%S@%m-%d).png" | cliphist store]]))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
