local gears = require("gears")
local wibox = require("wibox")
local theme = require("theme")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi


local shared = {}

function shared.rounded_bar(color)
    return wibox.widget {
        max_value = 100,
        value = 0,
        forced_height = dpi(20),
        forced_width = dpi(60),
        margins = {top = dpi(10), bottom = dpi(10)},
        shape = gears.shape.rounded_bar,
        border_width = 0,
        color = color,
        background_color = "#444444",
        border_color = theme.border_color,
        widget = wibox.widget.progressbar
    }
end


function shared.mk_separator (width)
    local value = width
    if not value == nil then
        value = dpi(width)
    end

    return wibox.widget {
        forced_width = value,
        opacity = 0,
        widget = wibox.widget.separator
    }
end

return shared
