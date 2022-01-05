local Love = love
local Util = require 'lib/util'

local RegisterBody = require 'systems/RegisterBody'
local RegisterFixture = require 'systems/RegisterFixture'
local RegisterShape = require 'systems/RegisterShape'
local RegisterSprites = require 'systems/RegisterSprites'

local entity_directory = 'entities'

local get_entity_configs = function(directory)
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

local entity_configs = get_entity_configs(entity_directory)
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
--   name (string) entity config file
--   pos_x (number) spawn x coordinate
--   pos_y (number) spawn y coordinate
-- }
-- layer_index (number) what map layer to draw this in
local spawn = function(object, layer_index)
  local entity_config = entity_configs[object.name]
  assert(
    entity_config ~= nil,
    'Map entity reference "' .. object.name .. '" not found.'
  )

  -- Don't mutate the source config
  local entity = Util.copy(entity_config)
  -- Plovisionary table to write and track active inputs
  entity.input = {}
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
