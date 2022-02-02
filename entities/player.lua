local shipList = require('ships/shipList')

-- Returns the ship's attribute table based on index (shipList.lua) - J.R.C 2/2/22
local function get_ship(index)
    if index then
        print("player.lua ship_index: " .. index)
    else
        index = 1 -- Defaults to Trevor's OG ship if none is found in the map props.
    end
    return shipList[index]
end

return function(object)
    local ship_index = tonumber(object.ship_type)
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
