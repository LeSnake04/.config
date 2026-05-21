hl.env("XDG_MENU_PREFIX", "plasma-")

---@param command string
function Cmd(command)
    hl.exec_cmd(command)
end

---@param command string
function UwsmCmd(command)
    Cmd("uwsm app -- " .. command)
end

hl.on("hyprland.start", function()
    Cmd("source ~/.profile")
    UwsmCmd("wl-paste --watch cliphist store")
    UwsmCmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    UwsmCmd("gnome-keyring-daemon --start --components=secrets")
    UwsmCmd("hypridle")
    UwsmCmd("elephant")
    UwsmCmd("wpaperd ")
    UwsmCmd("nextcloud")
    Cmd("LC_TIME=de_DE.utf8 uwsm app -- ironbar")
    UwsmCmd("bitwarden-desktop")
    UwsmCmd("kdeconnect-indicator")
end)
