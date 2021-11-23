require('objects/player')
require('objects/physics_objects')

objects = {}

table.insert(objects, player)
for index, data in pairs(physics_objects) do
    table.insert(objects, data) 
end

return objects