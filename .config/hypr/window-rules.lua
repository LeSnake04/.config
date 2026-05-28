--- @param name string
--- @param class string
--- @return nil
function FloatByClass(name, class)
    hl.window_rule({
        name = name,
        match = { class = class },
        float = true
    })
end

--- @param name string
--- @param title string
--- @return nil
function FloatByTitle(name, title)
    hl.window_rule({
        name = name,
        match = { title = title },
        float = true
    })
end

local floatAppsByClass = {
    keepassxc = "^org%.keepassxc%.KeePassXC$",
    steam_proton = "^steam_app_*",
    nm_tray = "^nm%-tray$"
}

for name, class in pairs(floatAppsByClass) do
    FloatByClass(name, class)
end

hl.window_rule({
    name = "PIP",
    match = { title = "Picture%-in%-Picture" },
    float = true,
    keep_aspect_ratio = true
})

local floatAppsByTitle = {
    scb = "^SCB$",
    scb_p = "^SCB_Playtest$",
    scb_d = "^SCB_Demo$"
}

for name, title in pairs(floatAppsByTitle) do
    FloatByTitle(name, title)
end
