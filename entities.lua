require('entities/player')
require('entities/physics_objects')

entities = {}

table.insert(entities, player)
for index, data in pairs(physics_objects) do
    table.insert(entities, data) 
end

return entities