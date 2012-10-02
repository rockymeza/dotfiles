-- --stolen from http://www.markurashi.de/dotfiles/awesome/rc.lua
--          via  https://github.com/williamscales/dotfiles/blob/master/awesome/rc.lua

-- failsafe mode
-- if the current config fail, load the default rc.lua

require("awful")
require("naughty")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

confdir = awful.util.getdir("config")
local rc, err = loadfile(confdir .. "/config.lua");
if rc then
    rc, err = pcall(rc);
    if rc then
        return;
    end
end

dofile(confdir .. "/backup.lua");

naughty.notify{text="Awesome crashed during startup on " ..
                os.date("%d%/%m/%Y %T:\n\n")
                .. err .. "\n", timeout = 0}
