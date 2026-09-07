---------------------
---- KEYBINDINGS ----
---------------------

local programs = require(os.getenv("HOME") .. "/.config/quickshell/hypr/core/programs.lua")

local mainMod = "SUPER"

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("/home/quirijn/.config/quickshell/reload.sh"))

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))

hl.bind(mainMod .. " + Space",
    hl.dsp.exec_cmd("qs ipc call luci openApplicationLauncher"))

hl.bind(mainMod .. " + P",
    hl.dsp.exec_cmd("qs ipc call luci openPowerMenu"))

hl.bind(mainMod .. " + W",
    hl.dsp.exec_cmd("qs ipc call luci openWallpaperSelector"))

hl.bind(mainMod .. " + V",
    hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + T",
    hl.dsp.exec_cmd("qs ipc call luci openThemeSelector"))

hl.bind(mainMod .. " + M",
    hl.dsp.exec_cmd("qs ipc call luci openMediaControls"))

hl.bind(mainMod .. " + B",
    hl.dsp.exec_cmd("mkdir /tmp/zen_lock 2>/dev/null && (zen-browser; rmdir /tmp/zen_lock)"))

hl.bind(mainMod .. " + S",
    hl.dsp.exec_cmd("hyprshot -m window"))

hl.bind(mainMod .. " + SHIFT + S",
    hl.dsp.exec_cmd("hyprshot -m region"))

hl.bind(mainMod .. " + L",
    hl.dsp.exec_cmd("hyprlock"))
    
hl.bind(mainMod .. " + F",
    hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + N",
    hl.dsp.exec_cmd("swaync-client -t"))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10

    hl.bind(mainMod .. " + " .. key,
        hl.dsp.focus({ workspace = i }))

    hl.bind(mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down",
    hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + mouse_up",
    hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true })

hl.bind(mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/quickshell/scripts/volume.sh up"), { locked = true, repeating = true })  -- FN + F1
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/quickshell/scripts/volume.sh down"), { locked = true, repeating = true })  -- FN + F2
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/quickshell/scripts/volume.sh mute"), { locked = true })  -- FN + F3
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))  -- FN + F4

hl.bind("XF86Launch1", hl.dsp.exec_cmd("~/.config/hypr/scripts/power_profiles_cycle.sh"), { locked = true, repeating = false }) -- FN + F5
hl.bind("XF86ScreenSaver", function()
    hl.timer(function()
        hl.dispatch(hl.dsp.dpms({ action = "disable", monitor = "eDP-1" }))
    end, { timeout = 500, type = "oneshot" })
end, { locked = true, repeating = false })  -- FN + F6   
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.config/quickshell/scripts/brightness.sh +5%"), { locked = true, repeating = true })  -- FN + F7
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/quickshell/scripts/brightness.sh 5%-"), { locked = true, repeating = true })  -- FN + F8

hl.bind("XF86Display", hl.dsp.exec_cmd("~/.config/hypr/scripts/monitor.sh")) -- FN + F9
local touchpadEnabled = false
hl.bind("XF86TouchpadToggle", function()
    touchpadEnabled = not touchpadEnabled
    hl.device({ name = "elan1203:00-04f3:307a-touchpad", enabled = touchpadEnabled }) -- FN + F10
end)
hl.bind("XF86Sleep", hl.dsp.exec_cmd("systemctl suspend"))  -- FN + F11
hl.bind("XF86WLAN", hl.dsp.exec_cmd("nmcli radio wifi toggle"))  -- FN + F12

hl.config({
    binds = {
        drag_threshold = 10 -- Correctly placed inside the binds category
    }
})

-- Move floating windows with mainMod + Left Click drag
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- Resize floating windows with mainMod + Right Click drag (from corners/edges)
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
    
hl.bind(mainMod .. " + CTRL + left",
    hl.dsp.window.resize({
        x = -40,
        y = 0,
        relative = true,
    }))

hl.bind(mainMod .. " + CTRL + right",
    hl.dsp.window.resize({
        x = 40,
        y = 0,
        relative = true,
    }))

hl.bind(mainMod .. " + CTRL + up",
    hl.dsp.window.resize({
        x = 0,
        y = -40,
        relative = true,
    }))

hl.bind(mainMod .. " + CTRL + down",
    hl.dsp.window.resize({
        x = 0,
        y = 40,
        relative = true,
    }))
