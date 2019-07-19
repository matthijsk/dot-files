import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import System.IO

main = do
  xmproc <- spawnPipe "xmobar" -- launch xmonad and pipe output to xmobar
  xmonad $ def
    {
      normalBorderColor = "#000000",
      focusedBorderColor = "#FFFFFF",

      modMask         = mod4Mask, -- rebind mod to the windows key

      manageHook      = manageDocks <+> manageHook def, --always display xmobar at top of screen
      layoutHook      = avoidStruts $ layoutHook def,
      handleEventHook = handleEventHook def <+> docksEventHook,
      logHook = dynamicLogWithPP xmobarPP
                {
                  ppOutput = hPutStrLn xmproc,
                  ppTitle = xmobarColor "green" "" . shorten 50
                }
    }
