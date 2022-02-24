--[[
    This is a table of all maps available
    They are automatically indexed from the maps directory
    The display name is the name of the file without the .tmx extension
]]

local util = require('lib/util')


local get_maps = function(directory)
    local maps = {}
    local file_list = love.filesystem.getDirectoryItems(directory)
    local count = 1
    for _, file_name in ipairs(file_list) do
        -- Ignore non-lua files and the shipList file
        if util.ends_with(file_name, '.tmx') then
            local map = {}
            local file_name_without_ext = file_name:match('(.+)%..+')
            map.displayName =  file_name_without_ext:sub(5,file_name_without_ext:len())
            map.filename = file_name_without_ext
            map.thumbnail = nil
            maps[count] = map
            count = count + 1
        end
    end

    return maps
end

return get_maps("maps")
