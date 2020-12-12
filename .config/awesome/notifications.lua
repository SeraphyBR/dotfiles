local naughty = require("naughty")
local beautiful = require("beautiful")

naughty.config.padding = beautiful.notification_padding
naughty.config.spacing = beautiful.notification_spacing
naughty.config.defaults.margin = beautiful.notification_margin

naughty.config.presets.normal = {
    border_width = beautiful.notification_border_width
}

naughty.config.presets.critical = {
    bg = beautiful.notification_critical_bg,
    fg = beautiful.notification_critical_fg,
    timeout = 0,
    border_width = beautiful.notification_border_width
}