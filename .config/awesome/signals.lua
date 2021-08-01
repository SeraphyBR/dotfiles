-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")

-- Notification
local naughty = require("naughty")

-- Theme handling library
local beautiful = require("beautiful")

local shared = require("shared")

-- Signal function to execute when a new client appears.
client.connect_signal("manage",
    function (c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end
        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position
        then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end

        -- Rounded Corners
        c.shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,6)
        end
    end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars",
    function(c)
        -- buttons for the titlebar
        local buttons = gears.table.join(
            awful.button({ }, 1,
                function()
                    c:emit_signal("request::activate", "titlebar", {raise = true})
                    awful.mouse.client.move(c)
                end
            ),
            awful.button({ }, 3,
                function()
                    c:emit_signal("request::activate", "titlebar", {raise = true})
                awful.mouse.client.resize(c)
                end
            )
        )
        awful.titlebar(c) : setup {
            { -- Left
                -- awful.titlebar.widget.iconwidget(c),
                awful.titlebar.widget.stickybutton(c),
                layout  = wibox.layout.fixed.horizontal
            },
            { -- Middle
                { -- Title
                    align  = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout  = wibox.layout.flex.horizontal
            },
            { -- Right
                awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.floatingbutton(c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }
    end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter",
    function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = false})
    end
)

client.connect_signal("focus",
    function(c)
        c.border_color = beautiful.border_focus
    end
)
client.connect_signal("unfocus",
    function(c)
        c.border_color = beautiful.border_normal
    end
)