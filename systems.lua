local System = require('lib/system')
require('entities')

systems = {}

--[[
    There are two ways to access a systems command.
    1. Call the function like normal
        - Used when accessing multiple systems in the main functions of the game (like love.draw()).
    2. Use systems.call('foo')
        - Used when accessing just one system at some random point.
        - Totally just for convenience.
]]

-- Easy way to call systems function without re-typing all of the loops and whatnot.
-- Usage: systems.call('foo')
systems.call = function(func)
    for _, entity in ipairs(entities) do
        systems[func](entity)
    end
end

-- Grab a specific entity table by name
systems.grab = function(selectedName)
    for _, entity in ipairs(entities) do
        if entity.name == selectedName then
            return entity
        end
    end
end

systems.DrawEntities = require('/systems/DrawEntities')
systems.SpawnEntities = require('/systems/SpawnEntities')
systems.UpdateEntities = require('/systems/UpdateEntities')
systems.ControlPlayer = require('/systems/ControlPlayer')
systems.UpdateCamera = require('/systems/UpdateCamera')
systems.Gravitate = require('/systems/Gravitate')

return systems
