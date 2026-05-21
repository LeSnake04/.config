-- Define modifiers
local mainMod = "SUPER + "
local altMod = "SUPER + SHIFT + "
local appMod = "ALT + SUPER + "

---@param command string
local function cmd(command)
    return function()
        hl.dispatch(hl.dsp.exec_cmd(command))
    end
end

---@param command string
local function uwsmCmd(command)
    return cmd("uwsm app -- " .. command)
end

-- Basic keybinds
hl.bind(mainMod .. "C", hl.dsp.window.kill())
hl.bind(altMod .. "Q", cmd("hyprshutdown"), { locked = true })
hl.bind(mainMod .. "F", hl.dsp.window.float())
hl.bind("CTRL + SUPER +" .. "F", hl.dsp.workspace.toggle_special({ allfloat = true }))
hl.bind(altMod .. "F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. "P", hl.dsp.window.pseudo())
-- hl.bind(alt .. " + J", hl.dsp.())

-- Focus movement
for _, dir in ipairs({ { "H", "l" }, { "L", "r" }, { "K", "u" }, { "J", "d" } }) do
    hl.bind(mainMod .. " + " .. dir[1], hl.dsp.focus({ direction = dir[2] }))
end

-- Workspace switching (1-10)
for i = 0, 10 do
    local key = i == 10 and "0" or tostring(i)
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(altMod .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Workspace scrolling
hl.bind(mainMod .. "LEFT", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. "RIGHT", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(altMod .. "LEFT", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(altMod .. "RIGHT", hl.dsp.window.move({ workspace = "e+1" }))

-- Mouse bind
hl.bind(mainMod .. " mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media keys
hl.bind("XF86AudioMute", cmd("pamixer -t"))
hl.bind("XF86AudioRaiseVolume", cmd("pamixer -i 5"))
hl.bind("XF86AudioLowerVolume", cmd("pamixer -d 5"))
hl.bind("XF86AudioMicMute", cmd("pamixer --default-source -t"))
hl.bind("ALT + " .. "XF86AudioMute", cmd("pamixer --default-source -t"))
hl.bind("ALT + " .. "XF86AudioRaiseVolume", cmd("pamixer --default-source -i 5"))
hl.bind("ALT + " .. "XF86AudioLowerVolume", cmd("pamixer --default-source -d 5"))
hl.bind("XF86AudioPlay", cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", cmd("playerctl play-pause"))
hl.bind("CTRL +" .. "XF86AudioMute", cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", cmd("playerctl position %+5"))
hl.bind("XF86AudioNext", cmd("playerctl next"), { long_press = true })
hl.bind("CTRL +" .. "XF86AudioRaiseVolume", cmd("playerctl position %+5"))
hl.bind("CTRL +" .. "XF86AudioRaiseVolume", cmd("playerctl next"), { long_press = true })
hl.bind("XF86AudioPrev", cmd("playerctl previous"))
hl.bind("CTRL +" .. "XF86AudioLowerVolume", cmd("playerctl previous"))

-- Brightness
hl.bind("XF86MonBrightnessUp", cmd("brightnessctl set 5%+"))
hl.bind("XF86MonBrightnessDown", cmd("brightnessctl set 5%-"))

-- Debug
hl.bind(mainMod .. "B", cmd("ironbar reload"))
hl.bind(altMod .. "B", cmd("killall -6 ironbar; sleep 2;uwsm app -- ironbar"))

-- System
hl.bind(altMod .. "L", cmd("loginctl lock-session"))

-- Screenshot
hl.bind("CTRL + " .. "Print", cmd("dhyprshot"))

-- Apps
hl.bind(mainMod .. "R", cmd("walker"))
hl.bind(altMod .. "R", uwsmCmd("$(wofi --show run)"))
hl.bind(altMod .. "P", uwsmCmd("nwg-displays"))
hl.bind(altMod .. "A", uwsmCmd("pavucontrol"))
hl.bind(mainMod .. "V",
    uwsmCmd("cliphist list | wofi --dmenu | { read -r item && echo \"$item\" | cliphist decode | wl-copy; }"))
hl.bind(mainMod .. "RETURN", cmd("alacritty"))
hl.bind(appMod .. "E", uwsmCmd("nemo"))
hl.bind(appMod .. "S", uwsmCmd("steam"))
hl.bind(appMod .. "B", uwsmCmd("floorp"))
hl.bind(appMod .. "K", uwsmCmd("bitwarden"))
