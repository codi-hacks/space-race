--- Map service
-- Store and decode maps as needed

local Entity = require('services/entity')
local Tmx = require('lib/tmx')
local Util = require('lib/util')
local World = require('services/world')
local DrawEntity = require('systems/DrawEntity')
local DebugPlayer = require('systems/DebugPlayer')
local State = require("services/state")
local mapList = require("maps/mapList")
local background = require('services/background')local active_map
local map_directory = '/maps'
local maps = Tmx.get_map_tables(map_directory)
local draw_objects = function(layer_idx)
    -- Draw each entity that belongs to this layer
    for _, entity in ipairs(Entity.list) do
        DrawEntity(entity, layer_idx)
        DebugPlayer(entity)
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
            draw_objects(idx)
        end
    end
end

local get_dimensions = function()
    return active_map.pixel_width, active_map.pixel_height
end

local load = function(map_name, ship_index)
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

            --Find the player object - J.R.C
            for _, obj in ipairs(layer.objects) do
                if obj.name == 'player' then
                    -- Set the ship type to the specified index
                    obj.ship_type = ship_index
                end
            end
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

local loadMap = function(mapNumber)
    --[[
    This function is necessary due to how entities are destroyed in box2d.
    For some reason, setting Entity.list = {} soft-locks the game.
    So instead we must loop through the entity table and delete them one by one.
    ]]--
    for index = #Entity.list, 1, -1 do
        Entity.list[index].body:destroy()
        Entity.list[index].shape:release()
        table.remove(Entity.list, index)
    end

    -- Do the actual map loading/unloading

    if mapNumber ~= -1 and mapList[State.activeMap] ~=nil then
        unload(mapList[State.activeMap].filename)
    end
    State.activeMap = mapNumber

    if State.activeMap ~= -1 then
        load(mapList[State.activeMap].filename, State.activeShip)

    end
        -- Generate some new stars, because why not?
    love.starLocations = background.load()
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
    loadMap = loadMap,
    --- Set loaded images and quads for a given map to nil.
    -- would have a map name of "general".
    -- @param {string} map_name - name of the tmx file to load
    -- @param {table} ship_index - index of ship to spawn
    -- @return {table} - parsed Tiled map data
    unload = unload
}
