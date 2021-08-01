local wibox = require("wibox")
local awful = require("awful")
local theme = require("theme")
local helpers = require("helpers")
local gears = require("gears")
local shared = require("shared")

local power_supply = "/sys/class/power_supply/BAT0/capacity";
local status = "/sys/class/power_supply/BAT0/status";

local normal_markup = '<span fgcolor="' .. theme.battery .. '"></span>';
local charging_markup = '<span fgcolor="' .. theme.battery .. '"></span>'

local battery = {};

if gears.filesystem.file_readable(power_supply) then

    battery.label = wibox.widget{
        markup = normal_markup,
        align  = 'center',
        valign = 'center',
        font = "FontAwesome 14",
        widget = wibox.widget.textbox
    }

    -- Battery bar
    battery.bar = shared.rounded_bar(theme.battery)

    awful.widget.watch("cat "..power_supply, 30,
        function(widget, stdout)
            local capacity = stdout:match("^%s*(.-)%s*$");
            widget.value = tonumber(capacity);
        end, battery.bar)

    awful.widget.watch("cat "..status, 45,
        function (widget, stdout)
            if stdout == "Charging\n" then
                widget.markup = charging_markup;
            else
                widget.markup = normal_markup;
            end
        end, battery.label)

end


return battery
