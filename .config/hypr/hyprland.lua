require("keybinds")
require("autostart")
require("window-rules")
require("custom")

hl.on("hyprland.start", function()
    hl.exec_cmd("source ~/.profile")
end)

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 0,
    },
    input = {
        kb_layout = "de",
        follow_mouse = false,
        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            tap_to_click = false,
            clickfinger_behavior = true
        }
    },
    decoration = {
        rounding = 5,
        blur = {
            enabled = false
        }
    },
    animations = {
        enabled = false,
    },
    debug = {
        disable_logs = false,
        enable_stdout_logs = true,
    },
    misc = {
        enable_anr_dialog = false,
    },
    xwayland = {
        force_zero_scaling = true
    }
})
