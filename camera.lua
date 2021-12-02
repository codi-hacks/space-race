--- Camera
-- Translation layer between coordinates and drawn graphics

-- Distance between player and screen edge before the
-- player is considered to be in the bounary in which
-- the camera needs to be moved.
local boundary_size = 0
local pos_x = 0
local pos_y = 0
local rotation = 0
local scale_x = 1
local scale_y = 1
local window_width, window_height = love.graphics:getDimensions()
window_width = window_width / scale_x
window_height = window_height / scale_y
-- https://love2d.org/wiki/FilterMode
love.graphics.setDefaultFilter('nearest', 'nearest')

local get_boundary_bottom = function()
  return pos_y + window_height - boundary_size
end

local get_boundary_left = function()
  return pos_x + boundary_size
end

local get_boundary_right = function()
  return pos_x + window_width - boundary_size
end

local get_boundary_top = function()
  return pos_y + boundary_size
end

local get_position = function()
  return pos_x, pos_y
end

local move = function(dx, dy)
  pos_x = pos_x + (dx or 0)
  pos_y = pos_y + (dy or 0)
end

local rotate = function(dr)
  rotation = rotation + dr
end

local set = function()
  love.graphics.push()
  love.graphics.rotate(-rotation)
  love.graphics.scale(scale_x, scale_y)
  love.graphics.translate(-pos_x, -pos_y)
end

local set_position = function(x, y)
  pos_x = x or pos_x
  pos_y = y or pos_y
end

local set_scale = function(sx, sy)
  scale_x = sx or scale_x
  scale_y = sy or sx or scale_y
end

local unset = function()
  love.graphics.pop()
end

return {
  get_boundary_bottom = get_boundary_bottom,
  get_boundary_left = get_boundary_left,
  get_boundary_right = get_boundary_right,
  get_boundary_top = get_boundary_top,
  get_position = get_position,
  move = move,
  rotate = rotate,
  set = set,
  set_position = set_position,
  set_scale = set_scale,
  unset = unset
}
