import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders
--import XMonad.Util.EZConfig (additionlKeys)
import qualified Data.Map as M

main = xmonad $ defaultConfig
  { borderWidth = 1
  , terminal = "terminator"
  , modMask = mod3Mask
  , keys = newKeys
  , handleEventHook = fullscreenEventHook
  , layoutHook = layout
  }

newKeys conf@(XConfig {XMonad.modMask = modMask}) =
  M.union (keys defaultConfig conf) $ M.fromList
    [ ((modMask .|. shiftMask, xK_z), spawn "xscreensaver & xscreensaver-command -lock")
    , ((controlMask, xK_Print), spawn "sleep 0.2; xwd -root | convert - capture.png")
    , ((0, xK_Print), spawn "xwd | convert - capture.png")
    ]

layout = smartBorders tiled ||| smartBorders (Mirror tiled) ||| noBorders Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
