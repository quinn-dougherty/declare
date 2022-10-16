import XMonad
import XMonad.Config
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.FadeInactive
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import Control.Monad (when)
import Text.Printf (printf)
import System.IO
import System.Posix.Process (executeFile)
import System.Info (arch,os)
import System.Environment (getArgs)
import System.FilePath ((</>))

terminalEmulator = "st"
xmobarFGColor = "yellow"
unfocusedWindowOpacity = 0.825

compiledConfig = printf "xmonad-%s-%s" arch os

compileRestart resume = do
    dirs  <- asks directories
    whenX (recompile dirs True) $ do
      when resume writeStateToFile
      catchIO
          ( do
              args <- getArgs
              executeFile (cacheDir dirs </> compiledConfig) False args Nothing
          )

myConfig xmproc = docks def
    { terminal = terminalEmulator
    , layoutHook = avoidStruts $ layoutHook def
    , logHook = fadeInactiveLogHook unfocusedWindowOpacity
      <+> dynamicLogWithPP xmobarPP
                  { ppOutput = hPutStrLn xmproc
                  , ppTitle = xmobarColor xmobarFGColor "" . shorten 50
                  }
    , modMask = mod4Mask -- rebind Mod to the Windows key
    , borderWidth = 2
    } `additionalKeys`
    [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
    , ((mod4Mask, xK_q), restart "xmonad" True)
    , ((mod4Mask,xK_r), compileRestart True)
    ]

main = do
  xmproc <- spawnPipe "xmobar ./xmobarrc"

  xmonad (myConfig xmproc)
