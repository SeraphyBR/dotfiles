local mpc = require("../external/mpc")
local gears = require("gears")
local wibox = require("wibox")
local textbox = require("wibox.widget.textbox")
local timer = require("gears.timer")
local awful = require("awful")
local theme = require("theme")

local state, title, artist, file = "stop", "", "", ""

local mpd_markup_playing = '<span fgcolor="' .. theme.mpd_playing .. '">󰎇</span>'
local mpd_markup_paused = '<span fgcolor="'  .. theme.mpd_paused  .. '">󰎇</span>'
local mpd_markup_offline = '<span fgcolor="' .. theme.mpd_offline .. '">󰎇</span>'

local mpd_widget = {}

mpd_widget.label = textbox()

mpd_widget.icon = wibox.widget {
    markup = '',
    align  = 'center',
    valign = 'center',
    font = "Material Design Icons 16",
    widget = wibox.widget.textbox
}

function shorten(s, width)
    local ellipsis = "…"
    local n_ellipsis = string.len(ellipsis)
    if string.len(s) > width then
        return string.sub(s, 1, width - n_ellipsis - 1) .. ellipsis
    end
    return s
end

local function update_widget()
        local text = tostring(artist or "") .. " - " .. tostring(title or "")
        if text == " - " then
                text = tostring(file)
        end

        text = shorten(text, 70)

        if state == "pause" then
            icon = mpd_markup_paused
        end
        if state == "play" then
            icon = mpd_markup_playing
        end
        if state == "stop" then
            text = ""
            icon = ""
        end
        mpd_widget.label.text = text
        mpd_widget.icon.markup = icon
end

local connection
local function error_handler(err)
        -- mpd_widget:set_text("Error: " .. tostring(err))
        mpd_widget.icon.markup = mpd_markup_offline
        mpd_widget.label:set_text("MPD Offline")
        -- Try a reconnect soon-ish
        timer.start_new(10, function()
                connection:send("ping")
        end)
end

connection = mpc.new(nil, nil, nil, error_handler,
        "status", function(_, result)
                state = result.state
        end,
        "currentsong", function(_, result)
                title, artist, file = result.title, result.artist, result.file
                pcall(update_widget)
        end)


mpd_widget.label:buttons(
        gears.table.join(
                awful.button({}, 1, function() connection:toggle_play() end),
                awful.button({}, 2, function() connection:previous_play() end),
                awful.button({}, 3, function() connection:next_play() end)
        )
)


return mpd_widget
