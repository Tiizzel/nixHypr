-- -----------------------------------------------------
-- Key bindings
-- -----------------------------------------------------

local mainMod = "SUPER"
local home = os.getenv("HOME")
local HYPRSCRIPTS = home .. "/.config/hypr/scripts"
local editor = "antigravity"
local browser = "zen-beta"
local filemanager = "thunar"
local terminal = "kitty"

-- ============= APPLICATIONS =============
hl.bind(mainMod .. " + T",       hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B",       hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + F",       hl.dsp.exec_cmd(filemanager))
hl.bind(mainMod .. " + Z",       hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("vesktop"))
hl.bind(mainMod .. " + Y",       hl.dsp.exec_cmd("kitty -e yazi"))
hl.bind(mainMod .. " + E",       hl.dsp.exec_cmd("emopicker9000"))
hl.bind(mainMod .. " + O",       hl.dsp.exec_cmd("obs"))
hl.bind(mainMod .. " + G",       hl.dsp.exec_cmd("gimp"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("pypr toggle term"))
hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd("pavucontrol"))

-- ============= DISPLAY ZOOM =============
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(awk \"BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') + 0.5}\")"))
hl.bind(mainMod .. " + SHIFT + mouse_up",   hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(awk \"BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') - 0.5}\")"))
hl.bind(mainMod .. " + SHIFT + Z",          hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 1"))

-- ============= WINDOW MANAGEMENT =============
hl.bind(mainMod .. " + Q",         hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"))
hl.bind(mainMod .. " + P",         hl.dsp.layout("pseudo"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + CTRL + F",  hl.dsp.window.fullscreen({ state = 0 }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + ALT + F",   hl.dsp.exec_cmd(HYPRSCRIPTS .. "/toggleallfloat.sh"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.exit()'"))

-- ============= WINDOW NAVIGATION & FOCUS (ARROW KEYS) =============
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- ============= WINDOW NAVIGATION & FOCUS (VI-STYLE) =============
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- ============= WINDOW SWAPPING (ARROW KEYS) =============
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.swap({ direction = "down" }))

-- ============= WINDOW SWAPPING (VI-STYLE) =============
hl.bind(mainMod .. " + ALT + h", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.swap({ direction = "down" }))

-- ============= WINDOW MOVEMENT (ARROW KEYS) =============
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- ============= WINDOW MOVEMENT (VI-STYLE) =============
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- ============= nixHypr-shell / Noctalia Bindings =============
hl.bind(mainMod .. " + SPACE",          hl.dsp.exec_cmd("quickshell ipc -c nixHypr-shell call main handleCommand toggle applauncher ''"))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("quickshell ipc -c nixHypr-shell call main handleCommand toggle applauncher ''"))
hl.bind(mainMod .. " + SHIFT + W",      hl.dsp.exec_cmd("quickshell ipc -c nixHypr-shell call main handleCommand toggle wallpaper ''"))
hl.bind(mainMod .. " + Tab",            hl.dsp.exec_cmd("quickshell ipc -c overview call overview toggle"))
hl.bind(mainMod .. " + X",              hl.dsp.exec_cmd("quickshell ipc -c nixHypr-shell call main handleCommand toggle session ''"))
hl.bind(mainMod .. " + K",              hl.dsp.exec_cmd("quickshell ipc -c nixHypr-shell call main handleCommand toggle keybinds ''"))
hl.bind(mainMod .. " + C",              hl.dsp.exec_cmd("quickshell ipc -c nixHypr-shell call main handleCommand toggle network ''"))
hl.bind(mainMod .. " + V",              hl.dsp.exec_cmd("quickshell ipc -c nixHypr-shell call main handleCommand toggle clipboard ''"))
hl.bind(mainMod .. " + M",              hl.dsp.exec_cmd("quickshell ipc -c nixHypr-shell call main handleCommand toggle calendar ''"))
hl.bind(mainMod .. " + ALT + P",        hl.dsp.exec_cmd("quickshell ipc -c nixHypr-shell call main handleCommand toggle settings ''"))
hl.bind(mainMod .. " + SHIFT + comma",  hl.dsp.exec_cmd("quickshell ipc -c nixHypr-shell call main handleCommand toggle settings ''"))
hl.bind(mainMod .. " + CTRL + R",       hl.dsp.exec_cmd("quickshell ipc -c nixHypr-shell call main handleCommand toggle focustime ''"))

-- ============= ACTIONS & SCRIPTS =============
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/toggle-animations.sh"))
hl.bind(mainMod .. " + S",         hl.dsp.exec_cmd(HYPRSCRIPTS .. "/screenshot.sh"))
hl.bind(mainMod .. " + CTRL + S",  hl.dsp.exec_cmd(HYPRSCRIPTS .. "/screenshot.sh --full"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/screenshot.sh --edit"))
hl.bind(mainMod .. " + ALT + S",   hl.dsp.exec_cmd(HYPRSCRIPTS .. "/screenshot.sh --edit"))
hl.bind(mainMod .. " + ALT + A",   hl.dsp.exec_cmd(HYPRSCRIPTS .. "/text-extractor.sh"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + ALT + G",   hl.dsp.exec_cmd(HYPRSCRIPTS .. "/gamemode.sh"))
hl.bind(mainMod .. " + CTRL + L",  hl.dsp.exec_cmd(HYPRSCRIPTS .. "/lock.sh"))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("pgrep -x hyprsunset && pkill -x hyprsunset || hyprsunset"))

-- ============= WORKSPACES (1-10) =============
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. key,  hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh " .. i))
end

-- ============= SPECIAL WORKSPACE =============
hl.bind(mainMod .. " + N",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.move({ workspace = "special:magic" }))

-- ============= MOUSE WORKSPACE CYCLING =============
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- ============= MOUSE DRAG & RESIZE =============
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ============= HARDWARE & MEDIA KEYS =============
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl pause"),      { locked = true })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86ScreenSaver",       hl.dsp.exec_cmd(HYPRSCRIPTS .. "/lock.sh"), { locked = true })

-- ============= REPEATING KEYS =============
hl.bind("ALT + Tab", hl.dsp.window.cycle_next(), { repeating = true })
hl.bind("ALT + Tab", hl.dsp.window.bring_to_top(), { repeating = true })
