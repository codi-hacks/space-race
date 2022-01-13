--- Map service
-- Store and decode maps as needed

local Entity = require('services/entity')
local Love = love
local Tmx = require('lib/tmx')
local Util = require('lib/util')
local World = require('services/world')
local DrawEntities = require('systems/DrawEntities')
local DebugPlayer = require('systems/DebugPlayer')

local active_map
local map_directory = '/maps'
local maps = Tmx.get_map_tables(map_directory)

local draw_objects = function(layer, layer_idx)
    -- Draw each entity that belongs to this layer
    for _, entity in ipairs(Entity.list) do
        DrawEntities(entity, layer_idx)
        DebugPlayer(entity)
    end

    -- Draw collision fixture shape's edges in debug mode
    for _, fixture in ipairs(layer.objects) do
        local body = fixture:getBody()
        local shape = fixture:getShape()
        Love.graphics.setColor(255, 0, 0, 255)
        Love.graphics.polygon('line', body:getWorldPoints(shape:getPoints()))
        Love.graphics.setColor(255, 255, 255, 255)
    end
end

local draw = function()
    -- We're probably on the menu screen
    -- if there isn't an active map
    if not active_map then
        return
    end
    for idx, layer in ipairs(active_map.layers) do
        if layer.type == 'tiles' then
            Tmx.draw_tiles(layer, active_map)
        else
            draw_objects(layer, idx)
        end
    end
end

local get_dimensions = function()
    return active_map.pixel_width, active_map.pixel_height
end

local load = function(map_name)
    assert(
        type(map_name) == 'string',
        'Expected map_name string parameter. Got "' .. type(map_name) .. '".'
    )
    assert(
        maps[map_name] ~= nil,
        'Could not find indexed map "' .. map_name .. '".'
    )

    active_map = Util.copy(maps[map_name])

    assert(
        active_map.render_order == 'right-down',
        'Only "right-down" map render order supported, but found order set to "' ..
        active_map.render_order .. '" ' .. 'for map "' .. map_name .. '".'
    )

    active_map.quads = Tmx.load_quads(active_map)

    for layer_idx, layer in ipairs(active_map.layers) do
        -- Apply collision fixtures
        if layer.type == 'objects' then
            active_map.layers[layer_idx].objects = Tmx.load_fixtures(World, layer, layer_idx, Entity.spawn)
        end
    end

    return active_map
end

local unload = function(map_name)
    assert(
        maps[map_name] ~= nil,
        'Could not find indexed map "' .. map_name .. '".'
    )
    maps[map_name].quads = nil
end

return {
    --- Render a map on screen. Map names are based
    -- on the filename. For instance, "general.tmx"
    -- would have a map name of "general".
    -- @param {string} map_name - name of map to draw
    -- @return {nil}
    draw = draw,
    -- Return active map's pixel dimensions
    -- @param {number} width
    -- @param {number} height
    get_dimensions = get_dimensions,
    load = load,
    --- Set loaded images and quads for a given map to nil.
    -- would have a map name of "general".
    -- @param {string} map_name - name of the tmx file to load
    -- @return {table} - parsed Tiled map data
    unload = unload
}
