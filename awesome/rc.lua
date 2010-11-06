-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Scratchpad
require('scratch')
-- Shifty
require('shifty')

--if true then return end
-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/rocky/.config/awesome/rocky_theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "gedit"
editor_cmd = terminal .. " -e " .. editor
browser = "chromium-browser"
dmenu_cmd = "exe=`cat /home/rocky/projects/dotfiles/resources/dmenu | dmenu -b -nf '#DCDCCC' -nb '#3F3F3F' -sf '#F0DFAF' -sb '#1E2320'` && exec $exe"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.top,
    awful.layout.suit.max
}
-- }}}

-- {{{ Naughty
naughty.config.timeout          = 5
naughty.config.screen           = 1
naughty.config.position         = "top_right"
naughty.config.margin           = 4
naughty.config.height           = 16
naughty.config.width            = 500
naughty.config.gap              = 1
naughty.config.ontop            = true
naughty.config.border_width     = 1
naughty.config.hover_timeout    = nil
-- }}}

-- {{{ Shifty
shifty.config.tags = {
   ["octavio"] = { position = 1, persist = true                            },
     ["tulia"] = { position = 2, init = true                            },
  ["thaddeus"] = { position = 3, init = true, layout = layouts[5]                            },
     ["frida"] = { position = 4, init = true                            },
   ["facundo"] = { position = 5, init = true                            },
    ["simone"] = { position = 6, persist = true                            },
     ["sybil"] = { position = 7, persist = true                            }
}

shifty.config.apps = {
  { match = { "Buddy List", "Contact List"      }, tag="octavio",                screen = 1, },
  { match = { "^conversation$"  }, tag="octavio", slave = true,  screen = 1, },
  { match = { "VIM"  }, tag="thaddeus",  screen = 1, },
  { match = { "Google Chrome", "Chromium", "Mozilla Firefox"   }, tag="frida",               screen = 1, },
  { match = { "Mozilla Thunderbird"           }, tag="facundo",             screen = 1, },

  { match = { "" }, buttons = {
                       button({ }, 1, function (c) client.focus = c; c:raise() end),
                       button({ modkey }, 1, function (c) awful.mouse.client.move() end),
                       button({ modkey }, 3, awful.mouse.client.resize ), }, },
}

shifty.config.defaults = {
  layout = awful.layout.suit.tile, 
  run = function(tag) naughty.notify({ text = tag.name }) end,
}

shifty.init()
-- }}}

-- {{{ Wibox
-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mytaglist[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mypromptbox[s],
        mysystray,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
in_scratchpad = false
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey, "Control" }, "Left",   shifty.shift_prev        ),
    awful.key({ modkey, "Control" }, "Right",  shifty.shift_next        ),
    awful.key({ modkey,           }, "t",      function() shifty.add({ rel_index = 1 }) end),
    awful.key({ modkey, "Control" }, "t",      function() shifty.add({ rel_index = 1, nopopup = true }) end),
    awful.key({ modkey, "Shift"   }, "t",      shifty.del               ),
    awful.key({ modkey,           }, "r",      shifty.rename            ),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "h",  awful.tag.viewprev       ),
    awful.key({ modkey,           }, "l",   awful.tag.viewnext       ),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "p",      function () awful.util.spawn_with_shell('cat ~/projects/dotfiles/resources/lorem | xclip -i') end),
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "b",      function () awful.util.spawn(browser)  end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "=",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "-",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "`",
        function ()
            awful.layout.inc(layouts,  1)
            naughty.notify({text = awful.layout.getname(awful.layout.get(1))}) 
        end),
    awful.key({ modkey, "Shift"   }, "`",
        function ()
            awful.layout.inc(layouts, -1)
            naughty.notify({text = awful.layout.getname(awful.layout.get(1))}) 
        end),

    -- dmenu
    awful.key({ modkey }, "space", function() awful.util.spawn_with_shell( dmenu_cmd )   end),
    
    -- cool time idea
    awful.key({ modkey }, "d",
        function ()
            naughty.notify({text = os.date('%a, %d %b %Y, %H.%M')})
        end),
    
    -- switch background
    awful.key({ modkey }, "w", function () awful.util.spawn_with_shell(theme.wallpaper_cmd[1]) end),
    
    -- lock screen
    awful.key({ "Control", altkey}, "l",     function () awful.util.spawn_with_shell('slock') end),
    
    -- scratchpad
    awful.key({ modkey            }, "s",
          function ()
                scratch.pad.toggle()
                local notify_text = (in_scratchpad) and "exiting scratchpad mode" or "entering scratchpad mode"
                naughty.notify({text = notify_text})
                in_scratchpad = not in_scratchpad
          end),
    awful.key({ modkey, "Shift"   }, "b",
          function ()
                scratch.drop(browser, "center", "center", 0.50, 0.50, true)
          end),
    awful.key({ modkey, "Shift"   }, "Return",
          function ()
                scratch.drop(terminal, "center", "center", 0.50, 0.50, true)
          end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
--[[
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end
]]
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i=1, ( shifty.config.maxtags or 9 ) do
  
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey }, i,
  function ()
    local t = awful.tag.viewonly(shifty.getpos(i))
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control" }, i,
  function ()
    local t = shifty.getpos(i)
    t.selected = not t.selected
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control", "Shift" }, i,
  function ()
    if client.focus then
      awful.client.toggletag(shifty.getpos(i))
    end
  end))
  -- move clients to other tags
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Shift" }, i,
    function ()
      if client.focus then
        local t = shifty.getpos(i)
        awful.client.movetotag(t)
        awful.tag.viewonly(t)
      end
    end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys
-- }}}


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}







