local wibox = require("wibox")
local awful = require("awful")
local watch = require("awful.widget.watch")
local beautiful = require("beautiful")
local helpers = require("helpers")
local gears = require("gears")
local theme = require("theme")

local shared = require("shared")

local command = "env LANG='en_US.UTF-8' pactl list sinks"
local markup = '<span fgcolor="'..theme.volume..'">󰕾</span>'
local markup_muted = '<span fgcolor="'..theme.volume_mute..'">󰖁</span>'

local step = 5

local volume = {}

volume.label = wibox.widget{
    markup = markup,
    align  = 'center',
    valign = 'center',
    font = "Material Design Icons 16",
    widget = wibox.widget.textbox
}

function volume.get_volume_state(cb)
  awful.spawn.easy_async(command, function(stdout)
    local mute = stdout:match("Mute:%s+(%a+)")
    local volume = stdout:match("%s%sVolume:[%s%a-:%d/]+%s(%d+)%%")

    cb(tonumber(volume), mute == "yes")
  end)
end

function volume.volume_up (cb)
  volume.get_volume_state(function(vol, mute)
    local next_vol = vol + step

    if (next_vol > 100) then
      next_vol = 100
    end

    awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ "..next_vol.."%", false)
    cb(next_vol, mute)
  end)
end

function volume.volume_down(cb)
  volume.get_volume_state(function(vol, mute)
    local next_vol = vol - step

    if (next_vol < 0) then
      next_vol = 0
    end

    awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ "..next_vol.."%", false)
    cb(next_vol, mute)
  end)
end

function volume.volume_mute(cb)
  volume.get_volume_state(function(vol, mute)
    local next_mute_bool = not mute
    awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle", false)
    cb(vol, next_mute_bool)
  end)
end

-- Bar widget
volume.bar = shared.rounded_bar(theme.volume)

function update_volume_bar(vol, mute)
    volume.bar.value = vol
    if mute then
        volume.label.markup = markup_muted
        volume.bar.color = theme.volume_mute
    else
        volume.label.markup = markup
        volume.bar.color = theme.volume
    end
end

volume.bar:buttons(
    gears.table.join(
        awful.button({}, 4, function() volume.volume_up(update_volume_bar) end), 
        awful.button({}, 5, function() volume.volume_down(update_volume_bar) end),
        awful.button({}, 1, function() volume.volume_mute(update_volume_bar) end)
    )
)

-- Init widget state
volume.get_volume_state(update_volume_bar)

-- Update widget when headphones conneted
awesome.connect_signal("acpi::headphones", function()
    volume.get_volume_state(update_volume_bar)
end)

-- Updates volumes
-- Setting LANG variable for not messing with output message
watch(command, 1, 
    function(widget, stdout, _, _, _) 
        local mute = stdout:match("Mute:%s+(%a+)")
        local volume = stdout:match("%s%sVolume:[%s%a-:%d/]+%s(%d+)%%")

        update_volume_bar(tonumber(volume), mute == "yes")

    end, volume)

return volume
