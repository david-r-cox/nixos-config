import qualified Codec.Binary.UTF8.String as UTF8
import qualified DBus as D
import qualified DBus.Client as D
import Data.Default
import Data.Maybe
import Data.Monoid
import Data.Ratio
import Data.Tree
import System.Exit
import XMonad
import XMonad.Actions.GridSelect
import XMonad.Actions.TreeSelect
import XMonad.Config
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, ppOutput)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.WorkspaceHistory (workspaceHistoryHook)
import XMonad.Layout.Grid
import XMonad.Layout.MultiColumns
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns
import XMonad.Prelude
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.NamedWindows (getName)
import XMonad.Util.Run
import XMonad.Util.Run (hPutStrLn)

xNormalColor = "#000000"

xFocusedColor = "#ffcf00"

xLayouts =
  spacingWithEdge 4 $
    smartBorders $
      ThreeCol 1 (3 / 100) (1 / 2)
        ||| ThreeColMid 1 (3 / 100) (1 / 2)
        ||| multiCol [1] 1 0.01 (-0.5)
        ||| Grid

workspaceNodes :: Forest String
workspaceNodes =
  [ Node
      "00"
      [ Node "00" [],
        Node "01" [],
        Node "02" [],
        Node "03" [],
        Node "04" [],
        Node "05" [],
        Node "06" [],
        Node "07" [],
        Node "08" [],
        Node "09" [],
        Node "0A" [],
        Node "0B" [],
        Node "0C" [],
        Node "0D" [],
        Node "0E" [],
        Node "0F" []
      ],
    Node "01" [],
    Node "02" [],
    Node "03" [],
    Node "04" [],
    Node "05" [],
    Node "06" [],
    Node "07" [],
    Node "08" [],
    Node "09" [],
    Node "0A" [],
    Node "0B" [],
    Node "0C" [],
    Node "0D" [],
    Node "0E" [],
    Node "0F" [],
    Node "10" [],
    Node "11" [],
    Node "12" [],
    Node "13" [],
    Node "14" [],
    Node "15" [],
    Node "16" [],
    Node "17" [],
    Node "18" [],
    Node "19" [],
    Node "1A" [],
    Node "1B" [],
    Node "1C" [],
    Node "1D" [],
    Node "1E" [],
    Node "1F" []
  ]

xWorkspaces :: Forest String
xWorkspaces =
  [ Node "R" workspaceNodes,
    Node "W" workspaceNodes,
    Node "E" workspaceNodes
  ]

-- "The Pixel Color format is in the form of 0xaarrggbb"
--     white       = 0xffffffff
--     black       = 0xff000000
--     red         = 0xffff0000
--     blue        = 0xff00ff00
--     green       = 0xff0000ff
--     transparent = 0x00000000
xTreeConf =
  TSConfig
    { ts_hidechildren = True,
      ts_background = 0xa0000000,
      ts_font = "xft:Berkley Mono:pixelsize=16",
      ts_node = (0xff000000, 0xff363636),
      ts_nodealt = (0xff000000, 0xff504d4d),
      ts_highlight = (0xffffffff, 0xffe53366),
      ts_extra = 0xffffdd33,
      ts_node_width = 40,
      ts_node_height = 30,
      ts_originX = 10,
      ts_originY = 10,
      ts_indent = 80,
      ts_navigate = XMonad.Actions.TreeSelect.defaultNavigation
    }

xColorizer =
  colorRangeFromClassName
    (0x00, 0x00, 0xFF) -- Beginning of color range
    (0xFF, 0x00, 0x00) -- End of color range
    (0xFF, 0xF0, 0x00) -- Background of active window
    (0xFF, 0xFF, 0xFF) -- Inactive text color
    (0x00, 0x00, 0x00) -- Active text color
    -- where black = minBound
    --      white = maxBound

xGSConfig =
  def
    { gs_cellheight = 50,
      gs_cellwidth = 250,
      gs_cellpadding = 10,
      gs_colorizer = xColorizer
    }

xGSConfig' =
  def
    { gs_cellheight = 50,
      gs_cellwidth = 250,
      gs_cellpadding = 10
    }

visibleWindows :: X WindowSet
visibleWindows = do
  ws <- gets windowset
  let currentScreen = W.current ws
      visibleScreens = W.visible ws
  return
    ws
      { W.current = currentScreen,
        W.visible = visibleScreens,
        W.hidden = []
      }

visibleWindowsOnActiveMonitor :: X WindowSet
visibleWindowsOnActiveMonitor = do
  ws <- gets windowset
  let currentScreen = W.current ws
  return
    ws
      { W.current = currentScreen,
        W.visible = [],
        W.hidden = []
      }

allWindows :: X WindowSet
allWindows = gets windowset

decorateName' :: Window -> X String
decorateName' w = do
  show <$> getName w

xWindowMap :: X WindowSet -> X [(String, Window)]
xWindowMap windowSubset = do
  ws <- windowSubset
  mapM keyValuePair (W.allWindows ws)
  where
    keyValuePair w = (,w) <$> decorateName' w

xGridselectWindow :: X WindowSet -> GSConfig Window -> X (Maybe Window)
xGridselectWindow windowSubset gsconf = (xWindowMap windowSubset) >>= gridselect gsconf

xWithSelectedWindow :: X WindowSet -> (Window -> X ()) -> GSConfig Window -> X ()
xWithSelectedWindow windowSubset callback conf = do
  mbWindow <- xGridselectWindow windowSubset conf
  for_ mbWindow callback

xGoToSelected :: X WindowSet -> GSConfig Window -> X ()
xGoToSelected windowSubset = xWithSelectedWindow windowSubset $ windows . W.focusWindow

xLogHook :: D.Client -> PP
xLogHook dbus = def {ppOutput = dbusOutput dbus}

dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
  let signal =
        (D.signal objectPath interfaceName memberName)
          { D.signalBody = [D.toVariant $ UTF8.decodeString str]
          }
  D.emit dbus signal
  where
    objectPath = D.objectPath_ "/org/xmonad/Log"
    interfaceName = D.interfaceName_ "org.xmonad.Log"
    memberName = D.memberName_ "Update"

main = do
  dbus <- D.connectSession
  D.requestName
    dbus
    (D.busName_ "org.xmonad.Log")
    [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
  xmonad $
    docks $
      def
        { terminal = "alacritty",
          manageHook = manageDocks <+> manageHook def,
          layoutHook = avoidStruts $ xLayouts,
          borderWidth = 2,
          focusedBorderColor = xFocusedColor,
          normalBorderColor = xNormalColor,
          modMask = mod4Mask,
          workspaces = toWorkspaces xWorkspaces,
          logHook = workspaceHistoryHook <+> dynamicLogWithPP (xLogHook dbus)
        }
        `additionalKeys` [ ((mod4Mask, xK_g), (xGoToSelected visibleWindows) xGSConfig'),
                           ((mod4Mask, xK_u), (xGoToSelected visibleWindowsOnActiveMonitor) xGSConfig),
                           ((mod4Mask .|. shiftMask, xK_g), (xGoToSelected allWindows) xGSConfig'),
                           ((mod4Mask .|. shiftMask, xK_u), gridselectWorkspace def W.view),
                           ((mod4Mask, xK_n), spawnSelected def ["neovide", "firefox", "chromium"]),
                           ((mod4Mask, xK_f), treeselectWorkspace xTreeConf xWorkspaces W.view),
                           ((mod4Mask .|. shiftMask, xK_f), treeselectWorkspace xTreeConf xWorkspaces W.shift),
                           ((mod4Mask, xK_p), spawn "rofi -show combi -modes combi -combi-modes 'window,drun,run'"),
                           ((mod4Mask, xK_c), spawn "rofi -show calc -modi calc -no-show-match -no-sort")
                         ]
