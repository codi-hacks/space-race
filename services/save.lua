local state = require('services/state')
local Serialize = require('lib/serialize')

local save = {}

save.read = function()
    -- Load data from a file. It's just a lua table that gets loaded into memory with:
    -- local data = {credits = <number>, time = <string>, lastMap = <number>}

    local filename = '/space-race.lua'

    -- Make sure file exists and load into memory
    if love.filesystem.getInfo(filename) then
        local f, message = love.filesystem.load(filename)
        local data = f()
        if data then
            state.credits = data.credits
            state.activeMap = data.lastMap
            -- local time = data.time -- Placeholder
        else
            print('Error when loading save data: ' .. message)
        end
    else
        print('No save file found!\nEither this is your first time, or your save data has done a Houdini.')
        state.credits = 0
    end
end

save.write = function()
    -- Save current data to file.

    local filename = '/space-race.lua'

    -- Grab the current data
    local data = {}
    data.credits = state.credits
    data.time = '2:33:44'
    data.lastMap = state.activeMap

    -- Serialize data
    local serializedData = Serialize(data)

    -- Write to file
    local success, message = love.filesystem.write(filename, serializedData)
    if not success then
        print('Error when writing save data: ' .. message)
    end
end

return save
