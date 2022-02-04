--local sounds = require 'services/sounds'
local shipList = require('ships/shipList')

-- Returns the ship's attribute table based on index (shipList.lua) - J.R.C 2/2/22
local function get_ship(index)
    if index == nil then
        index = 1 -- Defaults to Trevor's OG ship if none is found in the map props.
    end
    return shipList[index]
end

local function set_Ship(_, index)
    ship_index = index
    ship = get_ship(ship_index)
    shape = ship.shape
    spritesheet = ship.spritesheet
end

return function(props)
    local ship_index = tonumber(props.ship_type)
    local ship = get_ship(ship_index)

    return {
        body = {
            mass = 1
        },
        checkpoints = tonumber(props.checkpoints),
        fixture = {
            category = 1,
            density = 10,
            friction = 0,
            mask = 65535
        },
        on_end_contact = function()
            -- Extremely useful and essential sound effect
            -- TODO: fix this so it only bonks when we expect it to
            --love.audio.play(sounds.bonk)
        end,
        powerUps={

        },
        gravitational_mass = 1,
        isControlled = true,
        shape = ship.shape,
        spritesheet = ship.spritesheet,

        set_ship = set_Ship
    }
end
