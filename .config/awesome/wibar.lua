local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local theme = require("theme")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local net_widgets = require("external/net_widgets")

local helpers = require("helpers")

local mpd = require("widgets/mpd")
local volume = require("widgets/volume")
local xbacklight = require("widgets/xbacklight")
local ram = require("widgets/ram")
local cpu = require("widgets/cpu")
local battery = require("widgets/battery")
local calendar = require("widgets/calendar")
local shared = require("shared")

local systray_margin = (theme.wibar_height - theme.systray_icon_size) / 2

local clock_calendar = wibox.widget.textclock();
local cal_widget = calendar();

clock_calendar:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then
            cal_widget.toggle()
        end
    end
)

local wireless = wibox.widget {
    net_widgets.wireless({
        interface = "wlp7s0",
        onclick = "kitty -e nmtui",
        popup_signal = true,
        signal_color = theme.wifi,
        signal_width = dpi(20)
    }),
    layout = wibox.container.margin(wireless, 0, 0, 6)
}


-- Create systray widget
local mysystray = wibox.widget.systray()
mysystray:set_base_size(theme.systray_icon_size)

local mysystray_container = {
    mysystray,
    top = systray_margin,
    bottom = systray_margin,
    widget = wibox.container.margin
}

local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({modkey}, 1,
        function(t)
            if client.focus
                then client.focus:move_to_tag(t)
            end
        end
        ),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({modkey}, 3,
        function(t)
            if client.focus
                then client.focus:toggle_tag(t)
            end
        end
        ),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
    )

awful.screen.connect_for_each_screen(
    function(s)
        -- Create a promptbox for each screen
        s.mypromptbox = awful.widget.prompt()

        -- Create the wibox
        s.mywibox_top = awful.wibar({position = "top", screen = s, ontop = false})
        s.mywibox_bottom = awful.wibar({position = "bottom", screen = s, ontop = false})

        -- Create a taglist widget
        s.mytaglist = awful.widget.taglist {
            screen = s,
            filter = awful.widget.taglist.filter.all,
            buttons = taglist_buttons
        }

        -- Create a tasklist widget
        s.mytasklist = awful.widget.tasklist {
            screen = s,
            filter = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons
        }

        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(gears.table.join(
                               awful.button({ }, 1, function () awful.layout.inc( 1) end),
                               awful.button({ }, 3, function () awful.layout.inc(-1) end),
                               awful.button({ }, 4, function () awful.layout.inc( 1) end),
                               awful.button({ }, 5, function () awful.layout.inc(-1) end)))


        -- Add widgets to the wibox
        s.mywibox_top:setup{
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                spacing = theme.wibar_spacing,

                s.mytaglist,
                s.mypromptbox,
            },
            { -- Middle widgets
                layout = wibox.layout.fixed.horizontal,
                spacing = theme.wibar_spacing,
                shared.mk_separator(s.mywibox_top.width / 2 - 260),
                clock_calendar,
            },
            {
                { -- Right widgets
                    layout = wibox.layout.fixed.horizontal,
                    spacing = theme.wibar_spacing,
                    ethernet,
                    wireless,
                    shared.mk_separator(5),
                    volume.label,
                    volume.bar,
                    xbacklight.label,
                    xbacklight.bar,
                    ram.label,
                    ram.bar,
                    cpu.label,
                    cpu.bar,
                    battery.label,
                    battery.bar
                },
                left = theme.wibar_margin,
                right = theme.wibar_margin,
                widget = wibox.container.margin
            }
        }

        s.mywibox_bottom:setup {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = theme.wibar_spacing,
                    mysystray_container,
                    shared.mk_separator(20),
                    mpd.icon,
                    mpd.label
                },
                left = theme.wibar_margin,
                right = theme.wibar_margin,
                widget = wibox.container.margin
            },
            nil, -- Middle widget
            {
                { -- Right widgets
                    layout = wibox.layout.fixed.horizontal,
                    spacing = theme.wibar_spacing,
                    s.mylayoutbox
                },
                left = theme.wibar_margin,
                right = theme.wibar_margin,
                widget = wibox.container.margin
            }
        }
    end
    )
