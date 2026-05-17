-- Autostart configuration

hl.on("hyprland.start", function()
    -- Start Listeners
    hl.exec_cmd("/home/tiizzel/.config/nixHypr/listeners.sh --startall")

    -- Start Polkit
    hl.exec_cmd("systemctl --user start polkit-gnome-authentication-agent-1")

    -- Restore Wallpaper
    hl.exec_cmd("/home/tiizzel/nixHypr/scripts/nixHypr-wallpaper-app --restore")

    -- Autostart script
    hl.exec_cmd("/home/tiizzel/nixHypr/scripts/nixHypr-autostart")

    -- Load GTK settings
    hl.exec_cmd("/home/tiizzel/.config/hypr/scripts/gtk.sh")

    -- Load Notification Daemon
    hl.exec_cmd("swaync")

    -- Using hypridle to start hyprlock
    hl.exec_cmd("hypridle")

    -- Load cliphist history
    hl.exec_cmd("wl-paste --watch cliphist store")


    -- Start autostart cleanup
    hl.exec_cmd("/home/tiizzel/.config/hypr/scripts/cleanup.sh")
end)

-- Load configuration from nixHypr Hyprland Settings App (runs on every reload/start)
hl.exec_cmd("/home/tiizzel/.config/com.nixHypr.hyprlandsettings/hyprctl.sh")
