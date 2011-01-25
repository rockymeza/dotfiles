-- based on: https://awesome.naquadah.org/wiki/Volume_control_and_display
-- modified by: Rocky Meza

local widget = widget
local awful = require('awful')
local io = io
local string = string
local tonumber = tonumber
module('volume')

volume_widget = widget({ type = "textbox", name = "tb_volume", align = "right" })

function update(widget)
    local fd = io.popen("amixer sget Master")
    local status = fd:read("*all")
    fd:close()
    
    local volume = tonumber(string.match(status, "(%d?%d?%d)%%"))
    if not volume then
      return
    end
    local volume_percent = volume / 100

    status = string.match(status, "%[(o[^%]]*)%]")

    -- starting colour
    local sr, sg, sb = 0x1E, 0x23, 0x20
    local str, stg, stb = 0xF0, 0xDF, 0xAF
    -- ending colour
    local er, eg, eb = 0x3F, 0x3F, 0x3F
    local etr, etg, etb = 0xDC, 0xDC, 0xCC

    local ir = volume_percent * (er - sr) + sr
    local ig = volume_percent * (eg - sg) + sg
    local ib = volume_percent * (eb - sb) + sb
    interpol_colour = string.format("%.2x%.2x%.2x", ir, ig, ib)

    local tr = volume_percent * (etr - str) + str
    local tg = volume_percent * (etg - stg) + stg
    local tb = volume_percent * (etb - stb) + stb
    text_colour = string.format("%.2x%.2x%.2x", tr, tg, tb)

    response_text = "   M"
    if string.find(status, "on", 1, true) then
        response_text = string.format('%3d%%', volume)
    end
    local response = "<span font='monospace' color='#" .. text_colour .. "' background='#" .. interpol_colour .. "'>" .. response_text .. "</span>"
    widget.text = response
end

function up(percent)
  if percent == nil then
    percent = 1
  end
  awful.util.spawn("amixer set Master " .. percent .. "%+")
  update_volume(volume_widget)
end

function down(percent)
  if percent == nil then
    percent = 1
  end
  awful.util.spawn("amixer set Master " .. percent .. "%-")
  update_volume(volume_widget)
end

function mute(percent)
  if percent == nil then
    percent = 1
  end
  awful.util.spawn("amixer sset Master toggle")
  update_volume(volume_widget)
end

update(volume_widget)
awful.hooks.timer.register(1, function () update(volume_widget) end)
