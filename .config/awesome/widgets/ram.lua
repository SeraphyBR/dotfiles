local wibox = require("wibox")
local awful = require("awful")
local theme = require("theme")
local helpers = require("helpers")
local gears = require("gears")
local shared = require("shared")

local ram = {}

-- Ram bar
ram.bar = shared.rounded_bar(theme.ram)

awful.widget.watch("cat /proc/meminfo", 5,
    function(widget, stdout)
        local total = stdout:match("MemTotal:%s+(%d+)")
        local free = stdout:match("MemFree:%s+(%d+)")
        local buffers = stdout:match("Buffers:%s+(%d+)")
        local cached = stdout:match("Cached:%s+(%d+)")
        local srec = stdout:match("SReclaimable:%s+(%d+)")
        local used_kb = total - free - buffers - cached - srec
        widget.value = used_kb / total * 100
    end,
    ram.bar
    )

ram.label = wibox.widget{
    markup = '<span fgcolor="' .. theme.ram .. '"></span>',
    align  = 'center',
    valign = 'center',
    font = "FontAwesome 14",
    widget = wibox.widget.textbox
}

return ram