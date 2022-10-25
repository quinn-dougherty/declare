import           Control.Monad             (when)
import           System.Environment        (getArgs)
import           System.FilePath           ((</>))
import           System.Info               (arch, os)
import           System.IO
import           System.Posix.Process      (executeFile)
import           Text.Printf               (printf)
import           XMonad
import           XMonad.Config
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.FadeInactive
import           XMonad.Hooks.ManageDocks
import           XMonad.Util.EZConfig      (additionalKeys)
import           XMonad.Util.Run           (spawnPipe)

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
  xmproc <- spawnPipe "xmobar ~/Dropbox/dotfiles/framework/system/services/x/xmobarrc"

  xmonad (myConfig xmproc)
