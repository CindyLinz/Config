{-# LANGUAGE ScopedTypeVariables #-}
import XMonad
import XMonad.StackSet (greedyView)
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders
import XMonad.Actions.CopyWindow
--import XMonad.Util.EZConfig (additionlKeys)
import qualified Data.Map as M
import qualified System.FSNotify as FSN
import System.Directory
import Control.Concurrent
import Control.Exception

main = xmonad $ def
  { borderWidth = 1
  , terminal = "terminator"
  , modMask = mod4Mask
  , keys = newKeys
  , handleEventHook = fullscreenEventHook
  , layoutHook = layout
  , startupHook = spawn "terminator"
  , manageHook = hooks
  }

hooks = composeAll
  [ className =? "MPlayer" --> doFloat
  , className =? "vlc" --> doFloat
  ]

newKeys conf@(XConfig {XMonad.modMask = modMask}) =
  M.union (keys defaultConfig conf) $ M.fromList $
    [ ((modMask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
    , ((modMask .|. shiftMask, xK_g), spawn "google-chrome-stable")
    , ((modMask .|. shiftMask, xK_f), spawn "firefox -P default")
    , ((modMask .|. shiftMask, xK_b), spawn "terminator -e 'bc -l'")
    , ((modMask, xK_c), do
        let
          tmpDir = "/home/cindy/Downloads"
          handleIgnored = handle (\(_ :: SomeException) -> return ())
        liftIO $ do
          handleIgnored $ removeFile $ tmpDir <> "/a.txt"
          handleIgnored $ removeFile $ tmpDir <> "/b.txt"
        spawn $ "terminator -e 'vim " <> tmpDir <> "/a.txt; mv " <> tmpDir <> "/a.txt " <> tmpDir <> "/b.txt'"
        liftIO $ do
          mgr <- FSN.startManager
          FSN.watchDir mgr tmpDir ((== (tmpDir <> "/b.txt")) . FSN.eventPath) $ const $ do
            spawn $ "xclip -r -se c -i " <> tmpDir <> "/b.txt"
            FSN.stopManager mgr
          return ()
      )
    , ((controlMask, xK_Print), spawn "sleep 0.2; xwd -root | convert xwd:- capture-$$.png")
    , ((0, xK_Print), spawn "xwd | convert xwd:- capture-$$.png")
    , ((modMask, xK_z), spawn "suspend_xwin.pl")
    , ((0, 0x1008ff03), spawn "/home/cindy/brightness down")
    , ((0, 0x1008ff02), spawn "/home/cindy/brightness up")
    , ((shiftMask, 0x1008ff03), spawn "/home/cindy/brightness down 5")
    , ((shiftMask, 0x1008ff02), spawn "/home/cindy/brightness up 5")
    , ((0, 0x1008ff12), spawn "/home/cindy/volume.pl toggle")
    , ((0, 0x1008ff11), spawn "/home/cindy/volume.pl down")
    , ((0, 0x1008ff13), spawn "/home/cindy/volume.pl up")
    , ((modMask .|. controlMask, xK_c), kill1)
    ] ++
    [((modMask .|. controlMask, k), windows $ greedyView i . copy i) | (i, k) <- zip (workspaces conf) [xK_1..]]

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
