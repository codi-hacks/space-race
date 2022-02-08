local RespawnPlayer = require('systems/RespawnPlayer')
local Entity = require('services/entity')

-- Load a ship
return function(shipNumber)
   for _, entity in ipairs(Entity.list) do
    RespawnPlayer(entity, shipNumber)
   end
end
