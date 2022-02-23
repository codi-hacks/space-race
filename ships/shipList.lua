--[[
    This is a table of all ships available
    All ships have a:
    displayName - The display name of the ship.
    shape with:
        points
        type
    spritesheet with:
        image
        offset_x
        scale_x
    description - A string that describes anyhing interesting about the ship
    speed - Force modifier value for acceleration
    handling - Force modifer value for turning, braking, etc...

        - J.R.C 2/1/22
]]

local get_ships = function(directory)
    local ships = {}
    local file_list = love.filesystem.getDirectoryItems(directory)
    count = 1
    for _, file_name in ipairs(file_list) do
        -- Ignore non-lua files
        if file_name:sub(-#'.lua') == '.lua' and not (file_name:sub(-#'.spec.lua') == '.spec.lua') and not (file_name:sub(-#'shipList.lua') == 'shipList.lua') then
            local file_name_without_ext = file_name:match('(.+)%..+')
            local ship = require(directory .. '/' .. file_name_without_ext)
            ships[count] = ship
            count = count + 1
        end
    end
    return ships

end

return get_ships('ships')

