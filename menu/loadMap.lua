local map = require('services/map')
local mapList = require('maps/mapList')
local Entity = require('services/entity')
local State = require 'services/state'
local background = require('services/background')


-- Load a map

return function(mapNumber)
    -- This function is necessary due to how entities are loaded from maps.
    -- I wish a simple Entity.list = {} would work but we don't live in a perfect world.

    -- Copy the current/old set of entities
    local oldEntities = {}
    for k, v in pairs(Entity.list) do
        oldEntities[k] = v
    end
    local destroyList = {}


    -- Do the actual map loading/unloading
    map.unload(mapList[State.activeMap].filename)
    State.activeMap = mapNumber
    map.load(mapList[State.activeMap].filename)

    -- Remove old entities from map
    for k1,v1 in ipairs(Entity.list) do
        for _,v2 in ipairs(oldEntities) do
            if v1 == v2 then
                v2.body:destroy()
                v2.shape:release()
                table.insert(destroyList, k1)
            end
        end
    end
    table.sort(destroyList, function(a,b) return a > b end)
    for _,v in ipairs(destroyList) do
        table.remove(Entity.list, v)
    end

    -- Generate some new stars, because why not?
    love.starLocations = background.load()
end
