local awful = require("awful")
local beautiful = require("beautiful")
local default = require("programs").default


local powermenu = awful.menu({
    items = {
        { "Shutdown", "poweroff" },
        { "Reboot", "reboot" }
    }
})


local menu = awful.menu({
    items = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        { "Applications", default.rofi },
        { "Open terminal", default.terminal },
        { "Power menu", powermenu }
    }
})

return menu
