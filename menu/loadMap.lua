local map = require('services/map')


-- Load a mapW
return function(mapNumber)
   map.full_load(mapNumber)
end
