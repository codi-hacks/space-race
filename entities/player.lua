
local shipList = require('ships/shipList')

local function get_ship(index)
    print("player.lua ship_index: " .. index)
    return shipList[index]
end

return function()
    local ship_index = 6
    local ship = get_ship(ship_index)
    return {
        body = {
            mass = 1
        },
        fixture = {
            category = 1,
            density = 10,
            friction = 0,
            mask = 65535
        },
        powerUps={

        },
        gravitational_mass = 1,
        isControlled = true,
        shape = ship.shape,
        spritesheet = ship.spritesheet

    }
end
