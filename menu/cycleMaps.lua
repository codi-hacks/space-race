local mapList = require('maps/mapList')

-- Cycle the map list up and down based on the temporary global variable `mapSelect`

cycleMaps = {}

cycleMaps.up = function()
    mapSelect = mapSelect + 1
    if mapSelect > #mapList then
        mapSelect = 1
    end
end

cycleMaps.down = function()
    mapSelect = mapSelect - 1
    if mapSelect < 1 then
        mapSelect = #mapList
    end
end

return cycleMaps

