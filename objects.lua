require('objects/player')
require('objects_old')

objects = {}

table.insert(objects, player)
for index, data in pairs(objects_old) do
    table.insert(objects, data) 
end

--[[for index, data in ipairs(objects) do
    print(index)

    for key, value in pairs(data) do
        print('\t', key, value)
    end
end]]

return objects