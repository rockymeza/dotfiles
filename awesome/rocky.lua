-- volume widget based on: https://awesome.naquadah.org/wiki/Volume_control_and_display
-- by: Rocky Meza

local widget = widget
local awful = require('awful')
local io = io
local string = string
local tonumber = tonumber
local naughty = require('naughty')
local beautiful = require('beautiful')
module('rocky')

volume = {}
power = {}
volume.widget = widget({ type = "textbox", name = "tb_volume", align = "right" })
power.widget = widget({ type = "textbox", name = "tb_power", align = "right" })

function gradient(text, percent)
  -- starting color
  local sbr, sbg, sbb = 0x1E, 0x23, 0x20
  local str, stg, stb = 0xF0, 0xDF, 0xAF
  -- ending color
  local ebr, ebg, ebb = 0x3F, 0x3F, 0x3F
  local etr, etg, etb = 0xDC, 0xDC, 0xCC

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

-- volume stuff
function volume.update(widget)
  local fd = io.popen("amixer sget Master")
  local status = fd:read("*all")
  fd:close()
  
  local v = tonumber(string.match(status, "(%d?%d?%d)%%"))
  if not v then return end

  local percent = v / 100

  if string.find(status, "on", 1, true) then
    text = string.format('%3d%%', v)
  else
    text = "   M"
  end

  widget.text = gradient(text, percent)
end

function volume.change(percent)
  awful.util.spawn("amixer set Master " .. percent)
  volume.update(volume_widget)
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
function power.update(widget)
  local fd = io.popen("acpi -b")
  local status = fd:read("*all")
  fd:close()

  local p = tonumber(string.match(status, "(%d?%d?%d)%%"))
  if not p then return end
  local percent = p / 100

  local time = string.match(status, "(%d%d:%d%d):%d%d")
  if string.find(status, "Discharging", 1, true) then
    text = "⚡↓" .. time
  else
    text = "⚡↑" .. time
  end

  widget.text = gradient(text, percent)
end

volume.update(volume.widget)
power.update(power.widget)

awful.hooks.timer.register(1, function () volume.update(volume.widget) end)
awful.hooks.timer.register(1, function () power.update(power.widget) end)
