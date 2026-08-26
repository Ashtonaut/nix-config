hl.monitor({
  output = "eDP-1",
  mode = "1920x1080@60",
  position = "0x0",
  scale = 1,
})

hl.config({
  input = {
    kb_layout = "gb",
  }
})

local mod = "SUPER"

-- Launch applications
hl.bind(mod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + D", hl.dsp.exec_cmd("rofi -show drun"))

-- Window management
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())

-- Focus / move by direction
for key, dir in pairs({ Left = "left", Right = "right", Up = "up", Down = "down" }) do
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = dir }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }))
end

-- Focus / move by workspace
for i = 1, 9 do
  hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Screenshots
-- Fn + F11 registers as BOTH:
--   SUPER + SHIFT + XF86SelectiveScreenshot
--   SUPER + SHIFT + S
-- Therefore send second one to no_op()
hl.bind("SUPER + SHIFT + XF86SelectiveScreenshot", hl.dsp.exec_cmd("screenshot region"))
hl.bind("SUPER + SHIFT + S", hl.dsp.no_op())
hl.bind("Print", hl.dsp.exec_cmd("screenshot full"))

-- Media
local lrFlags = { locked = true, repeating = true }

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), lrFlags)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), lrFlags)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"), lrFlags)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"), lrFlags)

