local Love = love

local RegisterBody = require 'systems/RegisterBody'
local RegisterFixture = require 'systems/RegisterFixture'
local RegisterShape = require 'systems/RegisterShape'
local RegisterSprites = require 'systems/RegisterSprites'

local entity_directory = 'entities'

--------Jon's shiplist stuff---------------
local shipList = require('ships/shipList') -- List of ships and attributes J.R.C 2/1/22

local function get_ship(index)
    print("player.lua ship_index: " .. index)
    return shipList[index]
end

-- "Caveman way" of setting the player ship attributes from map - J.R.C 2/1/22
local function check_ship_type(object, entity)
    -- Gross code to Check the ship_type of each applicable entity
    -- and set the player attributes accordingly - J.R.C 2/1/22
    if object.ship_type then
        local ship_num = tonumber(object.ship_type)
        entity.ship_index = ship_num
        local ship = get_ship(ship_num)
        entity.shape = ship.shape
        entity.spritesheet = ship.spritesheet

        -- Potentially set other ship attributes here (Force Modifiers, etc...)

    end
end
-------------------------------------------

local get_entity_factories = function(directory)
    local entities = {}
    local file_list = Love.filesystem.getDirectoryItems(directory)
    for _, file_name in ipairs(file_list) do
        -- Ignore non-lua files
        if file_name:match('[^.]+$') == 'lua' then
            local file_name_without_ext = file_name:match('(.+)%..+')
            local entity = require(directory .. '/' .. file_name_without_ext)
            entities[file_name_without_ext] = entity
        end
    end
    return entities
end

local entity_factories = get_entity_factories(entity_directory)
local entities = {}

-- Caveman way of getting the player
local grab = function(selectedName)
    for _, entity in ipairs(entities) do
        if entity.name == selectedName then
            return entity
        end
    end
end

-- object (table) a map entity object {
--     name (string) entity config file
--     pos_x (number) spawn x coordinate
--     pos_y (number) spawn y coordinate
-- }
-- layer_index (number) what map layer to draw this in
local spawn = function(object, layer_index)
    local entity_factory = entity_factories[object.name]
    assert(
        entity_factory ~= nil,
        'Map entity reference "' .. object.name .. '" not found.'
    )

    -- Pass in the Tiled object to the factory so any spawn-point
    -- specific properties can be extracted out as needed (Tiled's
    -- "Custom Properties"), such as a custom radius for a planet.
    local entity = entity_factory(object)

    -- Check and set ship attributes if applicable - J.R.C 2/1/22
    check_ship_type(object, entity)

    -- Layer to draw player in. We could just get
    -- that information from the fixture collision
    -- group that was set but that collision group
    -- could change in special cases or on death.
    entity.draw_layer = layer_index

    RegisterBody(entity, object.pos_x, object.pos_y)
    RegisterShape(entity)
    RegisterFixture(entity, layer_index)
    RegisterSprites(entity)

    table.insert(entities, entity)
end

return {
    grab = grab,
    list = entities,
    spawn = spawn
}
