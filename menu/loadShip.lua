local shipList = require('ships/shipList')
local Entity = require('services/entity')
local State = require 'services/state'

-- Returns the ship's attribute table based on index (shipList.lua) - J.R.C 2/2/22
local function get_ship(index)
    if index == nil then
        index = 1 -- Defaults to Trevor's OG ship
    end
    return shipList[index]
end

-- Load a ship
return function(shipNumber)
    -- This function is necessary due to how entities are loaded from ships.
    -- I wish a simple Entity.list = {} would work but we don't live in a perfect world.


--[[
    local player = Entity.grab('player')

    if player then
        print(player.ship_index)
        player.ship_index = shipNumber
        print(player.ship_index)
        player.ship = get_ship(shipNumber)
        print(player.ship)
        player.shape = player.ship.shape
        print(player.shape)
        player.spritesheet = player.ship.spritesheet
        print(player.spritesheet)
    end

    RespawnPlayer(player)
    --Spawn a new player
    ]]

end
