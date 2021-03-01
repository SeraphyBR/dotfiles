---------------------------
-- SeraphyBR awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local helpers = require("helpers")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local layout_path = gfs.get_configuration_dir() .. "icons/layouts/"

local theme = {}

theme.font          = "Fira Code Medium 10"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#222222"
theme.bg_urgent     = "#FFA142"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(9)
theme.border_width  = dpi(5)
theme.border_normal = "#c9c9c9"
theme.border_focus  = "#5aae5f"
theme.border_marked = "#FF4500"

theme.user = "#7DF059"
theme.volume = "#8FF6FF"
theme.volume_mute = "#69656F"
theme.xbacklight = "#C8F059"
theme.nvidia = "#7FFF00"
theme.ram = "#D6AA3F"
theme.cpu = "#D6AA3F"
theme.temperature = "#DC143C"
theme.bluetooth = "#00BFFF"
theme.wifi = "#00BFFF"
theme.ethernet = "#27A2FF"
theme.ethernet_off = "#69656F"
theme.calendar = "#00FF7F"
theme.clock = "#00FF7F"
theme.battery = "#FFFF00"
theme.mpd_playing = "#53FF56"
theme.mpd_paused = "#FBA922"
theme.mpd_offline = "#69656F"
theme.spotify = "#1DB954"
theme.xwindow = "#FF4500"
theme.weather = "#00BFFF"
theme.uptime = "#9B78F1"
theme.powermenu = "#FFA707"
theme.powermenu_close = "#FF4500"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"
theme.hotkeys_modifiers_fg = "#5c6370"
theme.wibar_bg = theme.xbackground


-- Titlebars
-- theme.titlebar_size = dpi(4)
--theme.titlebar_bg_focus = theme.bg_focus
--theme.titlebar_bg_normal = theme.bg_normal
--theme.titlebar_fg_focus = theme.fg_focus
--theme.titlebar_fg_normal = theme.xcolor0

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.notification_padding = dpi(10)
theme.notification_spacing = theme.notification_padding
theme.notification_margin = dpi(10)
theme.notification_border_width = 0
theme.notification_border_radius = dpi(6)
theme.notification_critical_bg = theme.xcolor1
theme.notification_critical_fg = theme.xbackground
theme.notification_shape = helpers.rrect(theme.notification_border_radius)
theme.notification_icon_size = dpi(92)
theme.notification_max_width = dpi(450)

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(20)
theme.menu_width  = dpi(120)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"
theme.maximized_hide_border = true
theme.border_radius = dpi(6)
theme.wibar_height = dpi(30)
theme.wibar_margin = dpi(10)
theme.wibar_spacing = dpi(10)
theme.systray_icon_size = dpi(20)

-- Tasklist
theme.tasklist_disable_icon = false
theme.tasklist_fg_normal = "#5c6370"
theme.tasklist_fg_focus = theme.xforeground

-- Taglist
theme.taglist_fg_empty = "#5c6370"
theme.taglist_fg_focus = theme.xforeground

theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
-- default awful related
theme.layout_dwindle        = layout_path .. "dwindle.png"
theme.layout_fairh          = layout_path .. "fairh.png"
theme.layout_fairv          = layout_path .. "fairv.png"
theme.layout_floating       = layout_path .. "floating.png"
theme.layout_magnifier      = layout_path .. "magnifier.png"
theme.layout_max            = layout_path .. "max.png"
theme.layout_spiral         = layout_path .. "spiral.png"
theme.layout_tilebottom     = layout_path .. "tilebottom.png"
theme.layout_tileleft       = layout_path .. "tileleft.png"
theme.layout_tile           = layout_path .. "tile.png"
theme.layout_tiletop        = layout_path .. "tiletop.png"

theme.layout_fullscreen     = layout_path .. "fullscreen.png"
theme.layout_cornernw       = layout_path .. "cornernw.png"
theme.layout_cornerne       = layout_path .. "cornerne.png"
theme.layout_cornersw       = layout_path .. "cornersw.png"
theme.layout_cornerse       = layout_path .. "cornerse.png"

-- Define the image to load
--theme.wallpaper = "wallpaper.jpg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
