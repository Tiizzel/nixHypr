-- Autostart configuration

hl.on("hyprland.start", function()
    local home = os.getenv("HOME")

    -- Start Polkit
    hl.exec_cmd("systemctl --user start polkit-gnome-authentication-agent-1")

    -- Initialize Wallpaper
    hl.exec_cmd(home .. "/.config/hypr/scripts/wallpaper.sh $(cat " .. home .. "/.cache/quickshell/wallpaper/current_wallpaper 2>/dev/null || echo '" .. home .. "/Pictures/Wallpapers/default.jpg')")

    -- Start Quickshell Desktop Shell & Panels
    hl.exec_cmd("quickshell -c nixHypr-shell")
    hl.exec_cmd("quickshell -p " .. home .. "/.config/quickshell/overview")
    hl.exec_cmd("PROFILE=com.nixHypr.dotfiles quickshell -p " .. home .. "/.local/share/nixHypr-dotfiles-settings/quickshell")

    -- Load GTK settings
    hl.exec_cmd(home .. "/.config/hypr/scripts/gtk.sh")

    -- Using hypridle to start hyprlock
    hl.exec_cmd("hypridle")

    -- Load cliphist history
    hl.exec_cmd("wl-paste --watch cliphist store")

    -- Start User Applications on Startup
    hl.exec_cmd("zen-beta")
    hl.exec_cmd("vesktop")
    hl.exec_cmd("spotify")

    -- Start autostart cleanup
    hl.exec_cmd(home .. "/.config/hypr/scripts/cleanup.sh")
end)

-- Load configuration from nixHypr Hyprland Settings App (runs on every reload/start)
hl.exec_cmd(os.getenv("HOME") .. "/.config/com.nixHypr.hyprlandsettings/hyprctl.sh")
