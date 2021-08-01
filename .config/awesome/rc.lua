-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

require("error")

-- Standard awesome library
local awful = require("awful")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating,
    awful.layout.suit.spiral,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
--screen.connect_signal("property::geometry", set_wallpaper)
awful.screen.connect_for_each_screen(
    function(s)
        -- Each screen has its own tag table.
        awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
    end
)

-- Theme handling library
local beautiful = require("beautiful")
beautiful.init(os.getenv("HOME").."/.config/awesome/theme.lua")

-- Bling Wallpaper Module
local bling = require("./external/bling")
local dotfiles_images = os.getenv("HOME").."/Git/dotfiles/images"

bling.module.wallpaper.setup {
    set_function = bling.module.wallpaper.setters.random,
    wallpaper = {
        dotfiles_images.."/wallpapers",
        dotfiles_images.."/wallpapers2"
    },
    change_timer = 631,  -- prime numbers are better for timers
    position = "fit",
    background = "#424242"
}

-- Enable focus follow mouse
require("awful.autofocus")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- My modules
require("wibar")
require("notifications")
require("keybinds")
require("rules")
require("signals")
require("autostart")
