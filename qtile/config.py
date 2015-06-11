# coding:utf-8
from __future__ import unicode_literals

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget

mod = "mod4"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),

    # Move windows up or down in current stack
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn("urxvt256c-ml")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),

    # yeganesh
    Key([mod], "p", lazy.spawn('/home/rocky/projects/dotfiles/bin/yeganeshwrapper')),

    # Screen movement
    Key([mod], "w", lazy.prev_screen()),
    Key([mod], "e", lazy.next_screen()),

    # Volume
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('amixer set Master 1%+')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('amixer set Master 1%-')),
    Key([], 'XF86AudioMute', lazy.spawn('amixer set Master toggle')),

    # qtile control
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
]

groups = [Group(name) for name in 'asdfzxcv']

for group in groups:
    key = group.name
    # mod1 + letter of group = switch to group
    keys.append(
        Key([mod], key, lazy.group[group.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([mod, "shift"], key, lazy.window.togroup(group.name))
    )

layouts = [
    layout.MonadTall(),
    layout.Max(),
]

widget_defaults = dict(
    font='Terminus',
    fontsize=14,
    padding=0,
)

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(),
                widget.CurrentLayout(),
                widget.Sep(),
                widget.Prompt(),
                widget.WindowTabs(selected=('[', ']')),
                widget.Systray(),
                widget.Volume(),
                widget.Sep(),
                widget.Battery(format='{char} {percent:2.0%} ({hour:d}:{min:02d} remaining)', charge_char='↑', discharge_char='↓'),
                widget.Sep(),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
            ],
            14,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
