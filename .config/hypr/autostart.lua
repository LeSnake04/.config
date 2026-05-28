hl.env("XDG_MENU_PREFIX", "plasma-")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

---@param command string
function Cmd(command)
    hl.exec_cmd(command)
end

---@param command string
function UwsmCmd(command)
    Cmd("uwsm app -- " .. command)
end

--- @type table<string>
local uwmsApps = {
    -- Daemons
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
    "gnome-keyring-daemon --start --components=secrets",
    "swaync",
    "wpaperd",
    "rbw-agent",
    "elephant",
    "walker --gapplication-service",
    "hypridle",
    -- Apps
    "nextcloud",
    "bitwarden-desktop",
    "kdeconnect-indicator"
}

hl.on("hyprland.start", function()
    Cmd("source ~/.profile")
    Cmd("LC_TIME=de_DE.utf8 uwsm app -- ironbar")
    for _, app in ipairs(uwmsApps) do
        UwsmCmd(app)
    end
end)
