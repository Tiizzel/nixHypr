-- -----------------------------------------------------
-- Window rules
-- -----------------------------------------------------

-- SwayNC Layer Rules
hl.layer_rule({ match = { namespace = "swaync-control-center" },    blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "nixHypr-shell" },            blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "qs-master" },                blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "quickshell" },               blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "qs-popups" },                blur = true, ignore_alpha = 0.5 })

-- Window Rules Helper Function
local function rule(class, title, props)
    local match = {}
    if class then match.class = class end
    if title then match.title = title end
    
    local spec = { match = match }
    for k, v in pairs(props) do spec[k] = v end
    hl.window_rule(spec)
end

-- Pavucontrol
rule(".*org.pulseaudio.pavucontrol.*", nil, { float = true, center = true, pin = true, size = "700 600" })

-- Waypaper
rule(".*waypaper.*", nil, { float = true, center = true, pin = true, size = "900 700" })

-- Newelle
rule("io.github.qwersyk.Newelle", nil, { float = true, center = true, pin = true, size = "1000 700" })

-- nixHypr Settings
rule("com.nixHypr.settings", nil, { float = true, move = "monitor_w*0.5-window_w*0.5 86", pin = true, size = "900 600" })
rule(nil, "nixHypr Dotfiles Settings", { float = true, move = "monitor_w*0.5-window_w*0.5 86", pin = true, size = "900 600" })

-- Blueman Manager
rule("blueman-manager", nil, { float = true, center = true, size = "800 600" })

-- nwg-look
rule("nwg-look", nil, { float = true, center = true, size = "700 600" })

-- nwg-displays
rule("nwg-displays", nil, { float = true, center = true, size = "900 600" })

-- System Mission Center
rule("io.missioncenter.MissionCenter", nil, { float = true, center = true, pin = true, size = "900 600" })

-- Gnome Calculator
rule("org.gnome.Calculator", nil, { float = true, center = true, size = "700 600" })

-- Hyprland Share Picker
rule("hyprland-share-picker", nil, { float = true, pin = true, center = true, size = "600 400" })

-- nm-connection-editor
rule("nm-connection-editor", nil, { float = true, center = true, size = "800 700" })

-- Picture-in-Picture
rule(nil, "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$", { float = true, pin = true, center = true })

-- General floating
rule("dotfiles-floating", nil, { float = true, center = true, size = "1000 700" })

-- TaterClient / DDNet fullscreen on launch
rule(".*[Dd][Dd][Nn]et.*", nil, { fullscreen = true })
rule(".*[Tt]ater[Cc]lient.*", nil, { fullscreen = true })


-- Browser Exclusions (opaque, no opacity adjustments, no blur) using class or tag matchers
hl.window_rule({ match = { class = "^(firefox|zen|zen-beta|chromium|google-chrome|brave-browser|librewolf|opera|vivaldi-stable|waterfox|Thorium-browser|zen-browser)$" }, tag = "browser" })

hl.window_rule({
    match = { tag = "browser" },
    opacity = "1.0 override 1.0 override",
    opaque = true,
    no_blur = true
})

-- Games Exclusions (disable blur, force fullscreen, allow tearing/immediate presentation)
hl.window_rule({ match = { class = "^(gamescope)$" }, tag = "games" })
hl.window_rule({ match = { class = "^(steam_app_\\d+)$" }, tag = "games" })

hl.window_rule({
    match = { tag = "games" },
    fullscreen = true,
    no_blur = true,
    immediate = true
})

-- Idle Inhibition for Fullscreen Windows
hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })

-- Startup Applications Workspace Assignments
rule("zen-beta", nil, { workspace = "1" })
rule("vesktop", nil, { workspace = "2" })
rule("spotify", nil, { workspace = "2" })
