-- MODULE AUTO-START
-- Run all the apps listed in programs.lua as run_on_start_up only once when awesome start

local awful = require('awful')
local programs = require('programs')

local function run_once(cmd)
    local findme = cmd
    local firstspace = cmd:find(' ')
    local its_script = cmd:find('.sh')
    if firstspace then
        findme = cmd:sub(0, firstspace - 1)
    end
    if its_script then
        if cmd:find('/') then
            local tmp = cmd:reverse()
            local last_bracket = tmp:find('/')
            tmp = tmp:sub(0, last_bracket - 1)
            findme = tmp:reverse()
        end
    end

    awful.spawn.with_shell(string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd))
end

for _, program in ipairs(programs.run_on_start_up) do
    run_once(program)
end
