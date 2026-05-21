hl.window_rule({
    name = "keepassxc",
    match = { class = "^org%.keepassxc%.KeePassXC$" },
    float = true
})

hl.window_rule({
    name = "steam_proton",
    match = {
        class = "steam_app_*"
    },
    float = true
})

hl.window_rule({
    name = "nm-tray",
    match = { class = "^nm%-tray$" },
    float = true
})

hl.window_rule({
    name = "PIP",
    match = { title = "Picture%-in%-Picture" },
    float = true,
    keep_aspect_ratio = true
})

local floatAppsByTitle = {
    "SCB",
    "SCB_Playtest",
    "SCB_Demo"
}

for _, title in ipairs(floatAppsByTitle) do
    hl.window_rule({
        name = title,
        match = { title = "^" .. title .. "$" },
        float = true
    })
end
