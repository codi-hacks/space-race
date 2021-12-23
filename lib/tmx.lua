--- Tmx service
-- Parse and decode tmx files

local Base64 = require('lib/base64')
local Love = love
local Xml = require('lib/xml')
local Util = require('lib/util')

-- Typical parsed map table:
-- {
--   columns = 2,
--   image = <love image>,
--   layers = {
--     {
--       data = { 18, 17, 2, 1 },
--       height = "2",
--       type = 'tiles',
--       width = "2",
--       x = 0,
--       y = 0
--     },
--     {
--       groups = {
--         { ... }
--       },
--       type = 'objects'
--     }
--   },
--   orientation = "orthogonal",
--   quads = { <love quad>, <love quad>, ... },
--   render_order = "right-down",
--   rows = 2,
--   tile_height = 32,
--   tile_width = 32,
--   tilesets = {
--     {
--       columns = 16,
--       first_gid = 1,
--       source = "img/general.png",
--       tile_count = 256,
--       tile_height = 32,
--       tile_width = 32,
--       transparency = "ffffff"
--     },
--     { ... }
--   }
-- }

local parse_layer_data_xml = function(tiles)
  local parsed_table = {}
  for i = 1, #tiles do
    table.insert(parsed_table, tonumber(tiles[i].xarg.gid))
  end
  return parsed_table
end

local parse_layer_data_csv = function(tileset)
  local parsed_table = {}
  local i = 1
  for str in string.gmatch(tileset[i], '([^,]+)') do
    table.insert(parsed_table, tonumber(str))
    i = i + 1
  end
  return parsed_table
end

local parse_tile_layer = function(raw_layer_data, error_suffix)
  local formatted_layer = {
    type = 'tiles'
  }
  formatted_layer.data = {}
  formatted_layer.height = raw_layer_data.xarg.height
  formatted_layer.width = raw_layer_data.xarg.width
  formatted_layer.pos_x = (raw_layer_data.xarg.x or 0)
  formatted_layer.pos_y = (raw_layer_data.xarg.y or 0)
  -- The tileset data is stored in XML format
  if not raw_layer_data[1].xarg.encoding then
    formatted_layer.data = parse_layer_data_xml(raw_layer_data[1])
  elseif raw_layer_data[1].xarg.encoding == 'base64' then
    local tile_data_string = raw_layer_data[1][1]
    -- Strip newlines and whitespaces
    tile_data_string = tile_data_string:gsub('%s+', '')
    tile_data_string = Base64.decode(tile_data_string)

    local compression = raw_layer_data[1].xarg.compression
    if not compression then
      for i = 1, #tile_data_string, 4 do
        table.insert(formatted_layer.data, string.byte(tile_data_string, i))
      end
    elseif compression == 'gzip' or compression == 'zlib' then
      tile_data_string = Love.math.decompress(tile_data_string, compression)
      -- Glue together an integer from four bytes. Little endian
      formatted_layer.data = {}
      -- Decimal values for binary digits
      local bin = {}
      local mult = 1
      for i = 1, 40 do
          bin[i] = mult
          mult = mult * 2
      end
      for i = 1, #tile_data_string, 4 do
        -- Glue together an integer from four bytes, little endian
        local int = string.byte(tile_data_string, i) % bin[9] +
          string.byte(tile_data_string, i + 1) % bin[9] * bin[9] +
          string.byte(tile_data_string, i + 2) % bin[9] * bin[17] +
          string.byte(tile_data_string, i + 3) % bin[9] * bin[25]
        formatted_layer.data[#formatted_layer.data + 1] = int
      end
    else
      assert(
        false,
        'Only zlib and gzip map compressions are supported.' ..
        'Found "' .. compression .. '"' .. error_suffix
      )
    end
  elseif raw_layer_data[1].xarg.encoding == 'csv' then
    formatted_layer.data = parse_layer_data_csv(raw_layer_data[1])
  else
    assert(
      false,
      'Unexpected Tiled layer encoding "' ..
      raw_layer_data[1].xarg.encoding ..
      '" set' .. error_suffix
    )
  end
  return formatted_layer
end

local parse_object_layer = function(raw_object_group)
  local formatted_object_group = {
    objects = {},
    type = 'objects'
  }
  for _, raw_object in ipairs(raw_object_group) do
    local formatted_object = {}
    if raw_object[1] and raw_object[1].xarg.points then
      local points = {}
      for _, val in ipairs(Util.split(raw_object[1].xarg.points)) do
        for _, point in ipairs(Util.split(val, ',')) do
          table.insert(points, tonumber(point))
        end
      end
      formatted_object.points = points
    end
    if raw_object.xarg.height then
      formatted_object.height = tonumber(raw_object.xarg.height)
    end
    if raw_object.xarg.name then
      formatted_object.name = raw_object.xarg.name
    end
    if raw_object.xarg.rotation then
      formatted_object.rotation = math.rad(tonumber(raw_object.xarg.rotation))
    end
    if raw_object.xarg.type then
      formatted_object.type = raw_object.xarg.type
    end
    if raw_object.xarg.width then
      formatted_object.width = tonumber(raw_object.xarg.width)
    end
    if raw_object.xarg.x then
      formatted_object.pos_x = tonumber(raw_object.xarg.x)
    end
    if raw_object.xarg.y then
      formatted_object.pos_y = tonumber(raw_object.xarg.y)
    end
    -- Shallow copy all the object's "custom properties" attributes
    if raw_object[1] then
      for _, property in ipairs(raw_object[1]) do
        formatted_object[property.xarg.name] = property.xarg.value
      end
    end
    table.insert(formatted_object_group.objects, formatted_object)
  end
  return formatted_object_group
end

local parse_tileset = function(raw_tileset_data, error_suffix)
  local formatted_tileset = {}
  assert(
    raw_tileset_data[1].label == 'image',
    'Expected the tileset data to be an image. Got "' ..
    raw_tileset_data[1].label .. '"' .. error_suffix
  )
  assert(
    raw_tileset_data[1].xarg.source ~= nil,
    'Expected a tileset image source. Got nil' .. error_suffix
  )
  assert(
    raw_tileset_data.xarg.columns ~= nil,
    'Expected a defined set of tileset columns. Got nil' .. error_suffix
  )
  assert(
    raw_tileset_data.xarg.firstgid ~= nil,
    'Expected tileset to define first gid. Got nil' .. error_suffix
  )
  assert(
    raw_tileset_data.xarg.tilecount ~= nil,
    'Expected a total tile count for the given tileset. Got nil' .. error_suffix
  )
  if raw_tileset_data[1].xarg.trans then
    formatted_tileset.transparency = raw_tileset_data[1].xarg.trans
  end
  formatted_tileset.source = raw_tileset_data[1].xarg.source:gsub('%.%./', '')
  formatted_tileset.columns = tonumber(raw_tileset_data.xarg.columns)
  formatted_tileset.first_gid = tonumber(raw_tileset_data.xarg.firstgid)
  formatted_tileset.image_height = tonumber(raw_tileset_data[1].xarg.height)
  formatted_tileset.image_width = tonumber(raw_tileset_data[1].xarg.width)
  formatted_tileset.tile_count = tonumber(raw_tileset_data.xarg.tilecount)
  formatted_tileset.tile_height = tonumber(raw_tileset_data.xarg.tileheight)
  formatted_tileset.tile_width = tonumber(raw_tileset_data.xarg.tilewidth)
  return formatted_tileset
end

-- file_name (string) for error messages only
-- raw_file_content (string) the tmx file as a single string
local parse = function(file_name, raw_file_content)
  -- This will be our map's final table:
  local parsed_map = {
    layers = {},
    tilesets = {}
  }
  -- We get an array of elements, but only need the map element
  local parsed_xml = Xml.parse(raw_file_content)[2]
  local error_suffix = ' for Tiled map "' .. file_name .. '".'
  assert(
    parsed_xml ~= nil,
    'Cannot find map element' .. error_suffix
  )
  assert(
    parsed_xml.xarg.orientation == 'orthogonal',
    'Unsupported map type "' .. parsed_xml.xarg.orientation .. '"' ..
    error_suffix
  )
  assert(
    parsed_xml.xarg.renderorder == 'right-down',
    'Only "right-down" map render order supported, but found order set to "' ..
    parsed_xml.xarg.renderorder .. '"' .. error_suffix
  )
  parsed_map.rows = tonumber(parsed_xml.xarg.height)
  parsed_map.columns = tonumber(parsed_xml.xarg.width)
  parsed_map.orientation = parsed_xml.xarg.orientation
  parsed_map.render_order = parsed_xml.xarg.renderorder
  parsed_map.tile_height = tonumber(parsed_xml.xarg.tileheight)
  parsed_map.tile_width = tonumber(parsed_xml.xarg.tilewidth)
  -- This will save doing the calculation in-game
  parsed_map.pixel_height = parsed_map.rows * parsed_map.tile_height
  parsed_map.pixel_width = parsed_map.columns * parsed_map.tile_width
  for _, element in ipairs(parsed_xml) do
    if element.label == 'layer' then
      table.insert(parsed_map.layers, parse_tile_layer(element, error_suffix))
      --local parsed_layer = parse_tile_layer(element, error_suffix)
      --Util.push(parsed_map.layers, parsed_layer)
    elseif element.label == 'objectgroup' then
      table.insert(parsed_map.layers, parse_object_layer(element))
      --local parsed_object_group = parse_object_layer(element)
      --Util.push(parsed_map.layers, parsed_object_group)
    elseif element.label == 'tileset' then
      table.insert(parsed_map.tilesets, parse_tileset(element, error_suffix))
    end
  end
  assert(
    parsed_map.orientation ~= nil,
    'Unable to set map orientation' .. error_suffix
  )
  assert(
    parsed_map.render_order ~= nil,
    'Unable to set map render order' .. error_suffix
  )
  assert(
    parsed_map.tile_height ~= nil,
    'Unable to set map tile height' .. error_suffix
  )
  assert(
    parsed_map.tile_width ~= nil,
    'Unable to set map tile width' .. error_suffix
  )
  return parsed_map
end

return {
  parse = parse
}
