local awful = require("awful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local theme = require("theme")
local beautiful = require("beautiful")
local gears = require("gears")
local shared = require("shared")

local cpu = {}
cpu.bar = shared.rounded_bar(theme.cpu)
cpu.label = wibox.widget{
    markup = '<span fgcolor="' .. theme.ram .. '"></span>',
    align  = 'center',
    valign = 'center',
    font = "FontAwesome 14",
    widget = wibox.widget.textbox
}

-- Checks if a string starts with a another string
local function starts_with(str, start)
    return str:sub(1, #start) == start
end


local function worker()
    local cpus = {}
    watch([[sh -c "grep '^cpu.' /proc/stat; ps -eo '%p|%c|%C|' -o "%mem" -o '|%a' --sort=-%cpu | head -11 | tail -n +2"]], 1,
            function(widget, stdout)
                local i = 1
                for line in stdout:gmatch("[^\r\n]+") do
                    if starts_with(line, 'cpu') then

                        if cpus[i] == nil then cpus[i] = {} end

                        local name, user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice =
                            line:match('(%w+)%s+(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)')

                        local total = user + nice + system + idle + iowait + irq + softirq + steal

                        local diff_idle = idle - tonumber(cpus[i]['idle_prev'] == nil and 0 or cpus[i]['idle_prev'])
                        local diff_total = total - tonumber(cpus[i]['total_prev'] == nil and 0 or cpus[i]['total_prev'])
                        local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

                        cpus[i]['total_prev'] = total
                        cpus[i]['idle_prev'] = idle

                        if i == 1 then
                            widget.value = diff_usage
                        end

                        i = i + 1
                    end
                end
            end,
            cpu.bar
    )
end

worker()


return cpu
