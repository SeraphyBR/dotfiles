local wibox = require("wibox")
local awful = require("awful")
local theme = require("theme")
local helpers = require("helpers")
local gears = require("gears")
local shared = require("shared")

local power_supply = "/sys/class/power_supply/BAT0/capacity";
local battery = {};

if gears.filesystem.file_readable(power_supply) then

    battery.label = wibox.widget{
        markup = '<span fgcolor="' .. theme.battery .. '"></span>',
        align  = 'center',
        valign = 'center',
        font = "FontAwesome 14",
        widget = wibox.widget.textbox
    }

    -- Battery bar
    battery.bar = shared.rounded_bar(theme.battery)

    awful.widget.watch("cat " .. power_supply, 30,
        function(widget, stdout)
            local capacity = stdout:match("^%s*(.-)%s*$")
            widget.value = tonumber(capacity)
        end, battery.bar)

end


return battery