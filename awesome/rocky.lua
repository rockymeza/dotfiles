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
volume.widget = widget({ type = "textbox", name = "tb_volume", align = "right" })
power.widget = widget({ type = "textbox", name = "tb_power", align = "right" })

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

  local hour, min = string.match(status, "([1-9]?[1-9]?):(%d%d):%d%d")
  if hour and min then
    if string.len(hour) > 0 then
      time = hour .. ":" .. min
    else
      time = min .. "m"
    end
  end

  if string.find(status, "Discharging", 1, true) then
    if percent < .05 then
      naughty.notify({
        title = "I'm dying!",
        text = "Please plug in my adaptor",
        timeout = 0,
        fg = '#DCDCCC',
        bg = '#CC9393'
      })
    end
    text = "↓(" .. time .. ")"
  elseif string.find(status, "Charging", 1, true) then
    text = "↑(" .. time .. ")"
  else
    text = "⚡"
  end

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

volume.update(volume.widget)
power.update(power.widget)

awful.hooks.timer.register(1, function () volume.update(volume.widget) end)
awful.hooks.timer.register(60, function () power.update(power.widget) end)
