require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
require('scratch')
require('shifty')
require('rodentbane')
require("rocky")

--if true then return end
-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/rocky/.config/awesome/rocky_theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = os.getenv("TERMINAL") or "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
browser = os.getenv("BROWSER") or "sensible-browser"
dotfiles = os.getenv("DOTFILES") or "/home/rocky/dotfiles"

function dmenu_run()
  local f_reader = io.popen("echo | /home/rocky/.cabal/bin/yeganesh -- -b -nb '#3F3F3F' -nf '#DCDCCC' -sb '#1E2320' -sf '#F0DFAF'")
  local command = assert(f_reader:read('*a'))
  f_reader:close()
  if command == "" then return end
  awful.util.spawn(command)
end

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
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.max,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Naughty
naughty.config.presets.normal.timeout          = 5
naughty.config.presets.normal.screen           = 1
naughty.config.presets.normal.position         = "top_right"
naughty.config.presets.normal.margin           = 4
naughty.config.presets.normal.gap              = 1
naughty.config.presets.normal.ontop            = true
naughty.config.presets.normal.border_width     = 1
naughty.config.presets.normal.hover_timeout    = nil
-- }}}

-- {{{ Shifty
screen1 = 1
screen2 = screen.count()

shifty.config.tags = {
  ["octavio"] = {
    position = 1,
    persist = true,
    init = true,
    mwfact = 0.2,
    screen = screen1,
  },
  ["tulia"] = {
    position = 2,
    persist = true,
    init = screen1 ~= screen2,
    screen = screen1,
  },
  ["thaddeus"] = {
    position = 3,
    persist = true,
    init = screen1 ~= screen2,
    screen = screen2,
  },
  ["frida"] = {
    position = 4,
    persist = true,
    init = screen1 ~= screen2,
    screen = screen2,
  },
  ["facundo"] = {
    position = 5,
    persist = true,
    init = screen1 ~= screen2,
    screen = screen2,
  },
  ["simone"] = {
    position = 6,
    persist = true,
    init = screen1 ~= screen2,
    screen = screen2,
  },
  ["sybil"] = {
    position = 7,
    persist = true,
    init = screen1 ~= screen2,
    screen = screen2,
  },
  ["enoch"] = {
    position = 8,
    persist = true,
    init = screen1 ~= screen2,
    screen = screen2,
  },
  ["nicola"] = {
    position = 9,
    persist = true,
    init = screen1 ~= screen2,
    screen = screen2,
  },
}

shifty.config.apps = {
  {
    match = { "Buddy List", "Contact List", "Skype" },
    tag="octavio",
    screen = 1,
  },
  {
    match = { "^conversation$"  },
    tag="octavio",
    screen = 1,
  },
  {
    match = { "VIM"  },
    tag="thaddeus",
    screen = 1,
  },
  {
    match = { "Google Chrome", "Chromium", "Mozilla Firefox", "Pentadactyl" },
    tag="tulia",
    screen = 1,
  },
  {
    match = { "Mozilla Thunderbird", "Icedove" },
    tag="facundo",
    screen = 1,
  },
  {
    match = { "FileZilla" },
    tag="simone",
    screen = 1,
  },
  {
    match = { "VirtualBox Manager" },
    tag="simone",
    screen = 1,
  },
  {
    match = { "VM VirtualBox"},
    tag="frida",
    screen = 1,
  },
  {
    match = { "" },
    buttons = awful.util.table.join(
      awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
      awful.button({ modkey }, 1, function (c) awful.mouse.client.move() end),
      awful.button({ modkey }, 3, awful.mouse.client.resize )
    )
  },
}

shifty.config.defaults = {
  layout = awful.layout.suit.tile, 
}

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

    -- Master has a clock and stuff, other screens don't.
    if s == screen.count() then
      mywibox[s].widgets = {
          {
              rocky.clock.widget,
              mytaglist[s],
              layout = awful.widget.layout.horizontal.leftright,
          },
          mysystray,
          rocky.volume.widget,
          rocky.power.widget,
          mypromptbox[s],
          mytasklist[s],
          layout = awful.widget.layout.horizontal.rightleft
      }
    else
      mywibox[s].widgets = {
          {
              rocky.clock.widget,
              mytaglist[s],
              layout = awful.widget.layout.horizontal.leftright,
          },
          mypromptbox[s],
          mytasklist[s],
          layout = awful.widget.layout.horizontal.rightleft
      }
    end
end
-- }}}

shifty.taglist = mytaglist
shifty.init()

root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore ),
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
    awful.key({ modkey,           }, "e", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey,           }, "w", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "p",      function () awful.util.spawn_with_shell('xclip < ' .. dotfiles .. '/resources/lorem') end),
    awful.key({ modkey, "Shift"   }, "p",      function () awful.util.spawn_with_shell('xclip < ' .. dotfiles .. '/resources/lorem.html') end),
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "=",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "-",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey, "Control" }, "n",     awful.client.restore),
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

    awful.key({ },      "XF86AudioRaiseVolume", rocky.volume.up     ),
    awful.key({ },      "XF86AudioLowerVolume", rocky.volume.down   ),
    awful.key({ },      "XF86AudioMute",        rocky.volume.mute   ),
    awful.key({ },      "XF86Sleep",            function () awful.util.spawn_with_shell('zsh -ic rest') end),

    -- dmenu
    awful.key({ modkey }, "space", dmenu_run),
    
    -- cool time idea
    awful.key({ modkey }, "d", function () naughty.notify({text = rocky.clock.date()}) end),
    
    -- switch background
    awful.key({ modkey }, "b", function () awful.util.spawn_with_shell(theme.wallpaper_cmd[1]) end),
    
    -- lock screen
    awful.key({ "Control", altkey}, "l",     function () awful.util.spawn('slock') end),
    
    -- scratchpad
    awful.key({ modkey, "Shift"   }, "Return",
          function ()
                scratch.drop("tabbed urxvt -embed", "center", "center", 0.50, 0.50, true)
          end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "q",      function (c) c:kill() end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw() end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = true end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end),
    awful.key({ modkey, "Shift" }, "s", function (c) scratch.pad.set(c) end)
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
