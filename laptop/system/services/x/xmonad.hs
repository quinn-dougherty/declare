import           Control.Monad             (when)
import           System.Environment        (getArgs)
import           System.FilePath           ((</>))
import           System.Info               (arch, os)
import           System.IO
import           System.Posix.Process      (executeFile)
import           Text.Printf               (printf)
import           XMonad
import           XMonad.Actions.SpawnOn    (manageSpawn, spawnHere, spawnOn)
import           XMonad.Config
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.FadeInactive
import           XMonad.Hooks.ManageDocks
import           XMonad.Util.EZConfig      (additionalKeys)
import           XMonad.Util.Run           (spawnPipe)

terminalEmulator = "xfce4-terminal"
xmobarFGColor = "yellow"
unfocusedWindowOpacity = 0.7

modShift = mod4Mask .|. shiftMask
alt = mod1Mask

keybinds = [ ((modShift, xK_z), spawn "xscreensaver-command -lock")
    , ((mod4Mask, xK_q), restart "xmonad" True)
    , ((modShift, xK_w), spawnOn "1" "firefox") -- w is for www
    , ((modShift, xK_m), spawnOn "3" "thunderbird") -- m is for mail
    , ((modShift, xK_s), spawnHere "flameshot launcher") -- s is for screenshot
    , ((modShift, xK_z), spawnHere "slock") -- z is for zzz
    , ((modShift, xK_h), spawnHere "blueman-manager & pavucontrol") -- h is for headphones
    , ((modShift, xK_g), spawnHere "firefox --new-window \"chat.openai.com?model=gpt-4\"") -- g is for gpt
    , ((modShift, xK_t), spawnHere "firefox --new-window \"claude.ai/chats\"") -- t is for talk
    , ((modShift, xK_p), spawnOn "6" "bitwarden") -- p is for password
    , ((modShift, xK_b), spawnOn "9" "lutris battlenet & lutris trade-skill-master") -- b is for battlenet
    , ((modShift, xK_e), spawnOn "4" "emacs")
    , ((alt, xK_F1), spawn "wpctl set-mute @DEFAULT_SINK@ toggle")
    , ((alt, xK_F2), spawn "wpctl set-sink-volume @DEFAULT_SINK@ -10%")
    , ((alt, xK_F3), spawn "wpctl set-sink-volume @DEFAULT_SINK@ +10%")
    ]

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
    , manageHook = manageSpawn
    } `additionalKeys` keybinds


main = do
  xmproc <- spawnPipe "xmobar ~/projects/dotfiles/laptop/system/services/x/xmobarrc.hs"

  xmonad (myConfig xmproc)
