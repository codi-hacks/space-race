local state = require('services/state')

local save = {}

save.read = function()
    -- Load data from a file. It's just a lua table that gets loaded into memory with:
    -- local data = {credits = <number>, time = <string>, lastMap = <number>}

    local f = assert(loadfile('maps/saveData.lua')); f()
    state.credits = data.credits
    state.activeMap = data.lastMap
    local time = data.time -- Placeholder
    data = nil
end

save.write = function()
    -- Save current data to file.

    -- Arrange the data nicely
    local data = {}
    data.credits = state.credits
    data.time = '2:33:44'
    data.mapID = state.activeMap
    local newdata = 'data = {credits = ' .. data.credits .. ', time = \'' .. data.time .. '\', lastMap = ' .. data.mapID .. '}'

    -- Write the data to the file.
    fopen = io.open('maps/saveData.lua', 'w')
    fopen:write(newdata)
    fopen:close()
end

return save
