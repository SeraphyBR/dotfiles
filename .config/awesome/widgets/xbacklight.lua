local wibox = require("wibox")
local awful = require("awful")
local watch = require("awful.widget.watch")
local beautiful = require("beautiful")
local helpers = require("helpers")
local gears = require("gears")
local theme = require("theme")

local shared = require("shared")

local GET_BRIGHTNESS_CMD = "light -G"   -- "xbacklight -get"
local INC_BRIGHTNESS_CMD = "light -A 5" -- "xbacklight -inc 5"
local DEC_BRIGHTNESS_CMD = "light -U 5" -- "xbacklight -dec 5"

local xbacklight = {}

xbacklight.label = wibox.widget{
    markup = '<span fgcolor="' .. theme.xbacklight .. '">󰃠</span>',
    align  = 'center',
    valign = 'center',
    font = "Material Design Icons 16",
    widget = wibox.widget.textbox
}

xbacklight.bar = shared.rounded_bar(theme.xbacklight)

xbacklight.bar:connect_signal("button::press", 
    function(_, _, _, button)
        if (button == 4) then
            awful.spawn(INC_BRIGHTNESS_CMD, false)
        elseif (button == 5) then
            awful.spawn(DEC_BRIGHTNESS_CMD, false)
        end
    end
)

local update_widget = function(widget, stdout, _, _, _)
        local brightness_level = tonumber(string.format("%.0f", stdout))
        widget.value = brightness_level
    end


watch(GET_BRIGHTNESS_CMD, 1, update_widget, xbacklight.bar)

return xbacklight
