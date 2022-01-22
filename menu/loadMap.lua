local map = require('services/map')
local mapList = require('maps/mapList')
local Entity = require('services/entity')
local state = require('state')

-- Load a map

return function(mapNumber)
    map.unload(mapList[state.activeMap].filename)
    state.activeMap = mapNumber
    map.load(mapList[state.activeMap].filename)
end
