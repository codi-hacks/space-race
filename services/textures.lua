local util = require('lib/util')
local textures = {}

--[[
    Automatically loads every png located in assets/sprites/
    Textures are accessible by name-as-index: textures[FILE_NAME]
        - Where FILE_NAME is the name of the png file without the extension

    To load textures located in a different directory:
        - Call get_textures(DIRECTORY) in textures.load()

    -J.R.C 2/23/22
]]

local get_textures = function(directory)
    local file_list = love.filesystem.getDirectoryItems(directory)
    for _, file_name in ipairs(file_list) do
        if util.ends_with(file_name, '.png') then
            local file_name_without_ext = file_name:match('(.+)%..+')
            textures[file_name_without_ext] = love.graphics.newImage(directory .. file_name)
        end
    end
end

textures.load = function()
    get_textures('assets/sprites/')
end
return textures
