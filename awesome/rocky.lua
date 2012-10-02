-- volume widget based on: https://awesome.naquadah.org/wiki/Volume_control_and_display
-- by: Rocky Meza

local widget = widget
local awful = require('awful')
local timer = timer
local io = io
local string = string
local tonumber = tonumber
local naughty = naughty
local beautiful = beautiful
local os = os
module('rocky')
beautiful.init("/home/rocky/.config/awesome/rocky_theme.lua")

-- colors
colors = {}
colors.fg = {}
colors.bg = {}
colors.fg.normal = {0xDC, 0xDC, 0xCC}
colors.bg.normal = {0x3F, 0x3F, 0x3F}
colors.fg.focus  = {0xF0, 0xDF, 0xAF}
colors.bg.focus  = {0x1E, 0x23, 0x20}
colors.fg.urgent = {0xCC, 0x93, 0x93}
colors.bg.urgent  = {0x1E, 0x23, 0x20}

function gradient(text, percent, color_callback)
  -- starting color
  local sbr, sbg, sbb = color_callback('bs')
  local str, stg, stb = color_callback('fs')
  -- ending color
  local ebr, ebg, ebb = color_callback('be')
  local etr, etg, etb = color_callback('fe')

  local br = percent * (ebr - sbr) + sbr
  local bg = percent * (ebg - sbg) + sbg
  local bb = percent * (ebb - sbb) + sbb
  background_color = string.format("%.2x%.2x%.2x", br, bg, bb)

  local tr = percent * (etr - str) + str
  local tg = percent * (etg - stg) + stg
  local tb = percent * (etb - stb) + stb
  text_color = string.format("%.2x%.2x%.2x", tr, tg, tb)

  return "<span font='monospace' color='#" .. text_color .. "' background='#" .. background_color .. "'>" .. text .. "</span>"
end

-- volume, power stuff
volume = {}
power = {}
clock = {}
volume.widget = widget({ type = "textbox", name = "rocky_volume", align = "right" })
power.widget = widget({ type = "textbox", name = "rocky_power", align = "right" })
clock.widget = widget({ type = "textbox", name = "rocky_clock", align = "left" })

-- volume stuff
function volume.update(widget)
  local fd = io.popen("amixer sget Master")
  local status = fd:read("*all")
  fd:close()
  
  local v = tonumber(string.match(status, "(%d?%d?%d)%%"))
  if not v then return end

  local percent = v / 100

  if string.find(status, "[on]", 1, true) then
    text = string.format('%3d%%', v)
  else
    text = "M"
  end

  widget.text = gradient(text, percent, volume.colors)
end

function volume.colors(which)
  if which == 'bs' then
    c = colors.bg.focus
  elseif which == 'be' then
    c = colors.bg.normal
  elseif which == 'fs' then
    c = colors.fg.focus
  elseif which == 'fe' then
    c = colors.fg.normal
  end
  return c[1], c[2], c[3]
end

function volume.change(percent)
  awful.util.spawn("amixer set Master " .. percent, false)
  volume.update(volume.widget)
end

function volume.up(percent)
  if percent == nil then percent = 1 end
  volume.change(percent .. "%+")
end

function volume.down(percent)
  if percent == nil then percent = 1 end
  volume.change(percent .. "%-")
end

function volume.mute(percent)
  if percent == nil then percent = 1 end
  volume.change("toggle")
end

-- power stuff
function power.getStatus()
  local fd = io.popen("acpi -b")
  local status = fd:read("*all")
  fd:close()

  return status
end

function power.getPercent(status)
  local p = tonumber(string.match(status, "(%d?%d?%d)%%"))
  if not p then return end
  return p / 100
end

power.up = "&#8593;"
power.down = "&#8595;"
power.charged = "&#9889;"
function power.getText(status, percent)
  local hour, min = string.match(status, "([1-9]?[1-9]?):(%d%d):%d%d")
  if hour and min then
    if string.len(hour) > 0 then
      time = hour .. "小时" .. min .. "分钟"
    else
      time = min .. "分钟"
    end
  end

  if string.find(status, "Discharging", 1, true) then
    text = power.down .. "(" .. time .. ")"
  elseif string.find(status, "Charging", 1, true) then
    text = power.up .. "(" .. time .. ")"
  else
    text = power.charged
  end

  return text
end

power.notification = false
function power.notify(text, percent)
  local t = text:sub(1,7)

  if t == power.down and percent < .05 and not power.notification then
    power.notification = naughty.notify({
      title = "I'm dying!",
      text = "Please plug me in",
      timeout = 0,
      fg = '#FFFFFF',
      bg = '#FF0000'
    })
  elseif t == power.up and power.notification then
    power.notification.die()
    power.notification = false
  elseif t == power.charged then
    naughty.notify({
      title = "I'm full",
      text = "No need to charge me anymore"
    })
  end
end

function power.update(widget)
  local status = power.getStatus()
  local percent = power.getPercent(status)
  local text = power.getText(status, percent)
  power.notify(text, percent)

  widget.text = gradient(text, percent, power.colors)
end

function power.colors(which)
  if which == 'bs' then
    c = colors.bg.urgent
  elseif which == 'be' then
    c = colors.bg.normal
  elseif which == 'fs' then
    c = colors.fg.urgent
  elseif which == 'fe' then
    c = colors.fg.normal
  end
  return c[1], c[2], c[3]
end

function clock.time()
  return chinese(function() return os.date("%k点%M") end)
end

function clock.date()
  return chinese(function() return os.date("%Y年%m月%d号%A") end)
end

function clock.update(widget)
  widget.text = clock.time()
end

function chinese(callback)
  os.setlocale('zh_CN.utf8')
  local text = callback()
  os.setlocale('en_US.utf8')

  return text
end

volume.update(volume.widget)
clock.update(clock.widget)

volume.timer = timer({ timeout = 10 })
volume.timer:add_signal("timeout", function() volume.update(volume.widget) end)
volume.timer:start()
if string.len(power.getStatus()) > 0 then
  power.update(power.widget)
  power.timer = timer({ timeout = 60 })
  power.timer:add_signal("timeout", function() power.update(power.widget) end)
  power.timer:start()
end
clock.timer = timer({ timeout = 30 })
clock.timer:add_signal("timeout", function() clock.update(clock.widget) end)
clock.timer:start()
