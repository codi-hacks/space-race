local state = require('services/state')
local Serialize = require('lib/serialize')
local timer = require('services/timer')

local save = {}

--[[
Save relevant game state data into a save file.
The current data is stored:

credits <number>: The player's hoard of space gold.
time <number>: Placeholder for storing stopwatch times.
lastShip <number>: The ID of the last ship selected.
]]--


save.read = function()
    -- Load data from the save file

    local filename = '/space-race.lua'

    -- Make sure file exists and load the contents
    if love.filesystem.getInfo(filename) then
        local f, message = love.filesystem.load(filename)
        local data = f()

        -- Stuff the save data into the necessary places.
        if data then
            state.credits = data.credits or 0
            timer.timesTable = data.times or {}
            state.activeShip = data.lastShip or 1

        -- Check for errors
        else
            print('Error when loading save data: ' .. message)
        end
    else
        print('No save file found!\nEither this is your first time, or your save data has done a Houdini.')
    end
end

save.write = function()
    -- Save current data to the save file.

    local filename = '/space-race.lua'

    -- Grab the current data
    local data = {}
    data.credits = state.credits
    data.times = timer.timesTable
    data.lastShip = state.activeShip

    -- Serialize data
    local serializedData = Serialize(data)

    -- Write to file
    local success, message = love.filesystem.write(filename, serializedData)
    if not success then
        print('Error when writing save data: ' .. message)
    end
end

return save
