local state = require('services/state')

local save = {}

save.read = function()
    -- Load data from a file. It's just a lua table that gets loaded into memory with:
    -- local data = {credits = <number>, time = <string>, lastMap = <number>}

    local filename = '/space-race.lua'

    -- Make sure file exists and load into memory
    if love.filesystem.getInfo(filename) then
        local f, message = love.filesystem.load(filename)
        if f then
            local data = f()
            state.credits = data.credits
            state.activeMap = data.lastMap
            local time = data.time -- Placeholder
        else
            print('Error when loading save data: ' .. message)
        end
    else
        print('Error when loading save data: No save file found!')
    end
end

save.write = function()
    -- Save current data to file.

    local filename = '/space-race.lua'

    -- Grab the current data
    local data = {}
    data.credits = state.credits
    data.time = '2:33:44'
    data.mapID = state.activeMap

    -- Arrange the data into a returned table
    local newdata = 'return {credits = ' .. data.credits
    .. ', time = \'' .. data.time
    .. '\', lastMap = ' .. data.mapID
    .. '}'

    -- Write to file
    local success, message = love.filesystem.write(filename, newdata)
    if not success then
        print('Error when writing save data: ' .. message)
    end
end

return save
