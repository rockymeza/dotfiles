import System.Exit

import XMonad
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run(safeSpawnProg, safeSpawn)
import XMonad.Util.EZConfig

import Graphics.X11.ExtraTypes.XF86

import qualified XMonad.StackSet as W
import qualified Data.Map as M

main = xmonad =<< xmobar myConfig

myConfig = defaultConfig
    { modMask = mod4Mask
    , terminal = "urxvt256c-ml"
    , manageHook = manageDocks <+> myManageHook
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , keys = myKeys
    , logHook = updatePointer (Relative 0.5 0.5)
    }

-- put new windows at the bottom
-- https://wiki.haskell.org/Xmonad/Frequently_asked_questions#Force_all_new_windows_down
myManageHook = isDialog --> doF W.shiftMaster <+> doF W.swapDown

amixerMaster arg = safeSpawn "amixer" ["set", "Master", arg]

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask,                 xK_Return), safeSpawnProg $ XMonad.terminal conf) -- %! Launch terminal
    , ((modMask,                 xK_p     ), safeSpawnProg "/home/rocky/projects/dotfiles/bin/yeganeshwrapper") -- %! Launch yeganesh
    , ((modMask,                 xK_q     ), kill) -- %! Close the focused window

    , ((modMask,                 xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((modMask .|. shiftMask,   xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

    -- move focus up or down the window stack
    , ((modMask,                 xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask,                 xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,                 xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

    -- modifying the window order
    , ((modMask .|. shiftMask,   xK_m     ), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modMask .|. shiftMask,   xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((modMask .|. shiftMask,   xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
    , ((modMask,                 xK_h     ), sendMessage Shrink) -- %! Shrink the master area
    , ((modMask,                 xK_l     ), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
    , ((modMask,                 xK_f     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- quit, or restart
    , ((modMask .|. controlMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    , ((modMask .|. controlMask, xK_r     ), safeSpawnProg "/home/rocky/projects/dotfiles/bin/restart_xmonad") -- %! Restart xmonad

    -- volume
    , ((0, xF86XK_AudioLowerVolume), amixerMaster "2%-")
    , ((0, xF86XK_AudioRaiseVolume), amixerMaster "2%+")
    , ((0, xF86XK_AudioMute       ), amixerMaster "toggle")

    -- miscellaneous
    , ((modMask,                 xK_b     ), safeSpawnProg "/home/rocky/projects/dotfiles/bin/set_wallpaper") -- %! Change the wallpaper

    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
