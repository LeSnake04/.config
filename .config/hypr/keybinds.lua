-- Define modifiers
local mod = "SUPER + "
local ctrlMod = "CTRL + SUPER + "
local shiftCtrlMod = "SHIFT + CTRL + SUPER + "
local shiftMod = "SUPER + SHIFT + "
local altMod = "ALT + SUPER + "

---@param command string
function Cmd(command)
    return function()
        hl.dispatch(hl.dsp.exec_cmd(command))
    end
end

---@param command string
function UwsmCmd(command)
    return Cmd("uwsm app -- " .. command)
end

-- WM keybinds
hl.bind(mod .. "C", hl.dsp.window.close())
hl.bind(shiftMod .. "C", hl.dsp.window.kill(), { long_press = true })
hl.bind(shiftMod .. "Q", Cmd("hyprshutdown"), { locked = true })
hl.bind(mod .. "F", hl.dsp.window.float())
hl.bind(ctrlMod .. "F", hl.dsp.workspace.toggle_special({ allfloat = true }))
hl.bind(shiftMod .. "F", hl.dsp.window.fullscreen())
hl.bind(mod .. "P", hl.dsp.window.pseudo())
-- hl.bind(alt .. " + J", hl.dsp.())

-- Workspace Binds
local focusBinds = {
    H = "l",
    LEFT = "l",
    L = "r",
    RIGHT = "r",
    K = "u",
    UP = "u",
    J = "d",
    DOWN = "d"
}

for key, dir in pairs(focusBinds) do
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = dir }))
end

-- Workspace Binds
for i = 0, 10 do
    local key = i == 10 and "0" or tostring(i)
    hl.bind(ctrlMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(shiftCtrlMod .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

local wspaceBinds = {
    LEFT = "-1",
    UP = "-1",
    H = "-1",
    J = "-1",
    RIGHT = "+1",
    DOWN = "+1",
    K = "+1",
    L = "+1",
}

for key, dir in pairs(wspaceBinds) do
    hl.bind(ctrlMod .. key, hl.dsp.focus({ workspace = "e" .. dir }))
    hl.bind(shiftCtrlMod .. key, hl.dsp.window.move({ workspace = "r" .. dir }))
end

-- Mouse bind
hl.bind(mod .. " mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media keys
hl.bind("XF86AudioMute", Cmd("pamixer -t"))
hl.bind("XF86AudioRaiseVolume", Cmd("pamixer -i 5"))
hl.bind("XF86AudioLowerVolume", Cmd("pamixer -d 5"))
hl.bind("XF86AudioMicMute", Cmd("pamixer --default-source -t"))
hl.bind("ALT + " .. "XF86AudioMute", Cmd("pamixer --default-source -t"))
hl.bind("ALT + " .. "XF86AudioRaiseVolume", Cmd("pamixer --default-source -i 5"))
hl.bind("ALT + " .. "XF86AudioLowerVolume", Cmd("pamixer --default-source -d 5"))
hl.bind("XF86AudioPlay", Cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", Cmd("playerctl play-pause"))
hl.bind("CTRL +" .. "XF86AudioMute", Cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", Cmd("playerctl position %+5"))
hl.bind("XF86AudioNext", Cmd("playerctl next"), { long_press = true })
hl.bind("CTRL +" .. "XF86AudioRaiseVolume", Cmd("playerctl position %+5"))
hl.bind("CTRL +" .. "XF86AudioRaiseVolume", Cmd("playerctl next"), { long_press = true })
hl.bind("XF86AudioPrev", Cmd("playerctl previous"))
hl.bind("CTRL +" .. "XF86AudioLowerVolume", Cmd("playerctl previous"))

-- Brightness
hl.bind("XF86MonBrightnessUp", Cmd("brightnessctl set 5%+"))
hl.bind("XF86MonBrightnessDown", Cmd("brightnessctl set 5%-"))

-- Utils
hl.bind(mod .. "B", Cmd("ironbar reload"))
hl.bind(shiftMod .. "B", Cmd("killall -6 ironbar; sleep 2;uwsm app -- ironbar"))

-- System
hl.bind(shiftMod .. "L", Cmd("loginctl lock-session"))
hl.bind("CTRL + " .. "Print", Cmd("dhyprshot"))

-- Utils
hl.bind(mod .. "R", Cmd("walker -k"))
hl.bind(shiftMod .. "R", UwsmCmd("$(wofi --show run)"))
hl.bind(mod .. "V", UwsmCmd("walker -km clipboard"))
hl.bind(shiftMod .. "A", UwsmCmd("pavucontrol"))
hl.bind(shiftMod .. "P", UwsmCmd("nwg-displays"))

-- Apps
hl.bind(mod .. "RETURN", Cmd("alacritty"))
hl.bind(altMod .. "E", UwsmCmd("nemo"))
hl.bind(altMod .. "S", UwsmCmd("steam"))
hl.bind(altMod .. "B", UwsmCmd("floorp"))
hl.bind(altMod .. "K", UwsmCmd("bitwarden"))
