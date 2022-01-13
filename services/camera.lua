--- Camera
-- Translation layer between coordinates and drawn graphics

-- Distance between player and screen edge before the
-- player is considered to be in the bounary in which
-- the camera needs to be moved.

local state = require('state')
state.camera.boundary_size = 0
state.camera.pos_x = 0 * .5
state.camera.pos_y = 0 * .5
state.camera.rotation = 0
state.camera.scale_x = 1
state.camera.scale_y = 1
state.camera.window_width, state.camera.window_height = love.graphics:getDimensions()

local window_width = state.camera.window_width / state.camera.scale_x
local window_height = state.camera.window_height / state.camera.scale_y
-- https://love2d.org/wiki/FilterMode
love.graphics.setDefaultFilter('nearest', 'nearest')

local get_boundary_bottom = function()
  return state.camera.pos_y + window_height - state.camera.boundary_size
end

local get_boundary_left = function()
  return state.camera.pos_x + state.camera.boundary_size
end

local get_boundary_right = function()
  return state.camera.pos_x + window_width - state.camera.boundary_size
end

local get_boundary_top = function()
  return state.camera.pos_y + state.camera.boundary_size
end

local get_position = function()
  return state.camera.pos_x, state.camera.pos_y
end

local move = function(dx, dy)
  state.camera.pos_x = state.camera.pos_x + (dx or 0)
  state.camera.pos_y = state.camera.pos_y + (dy or 0)
end

local rotate = function(dr)
  state.camera.rotation = state.camera.rotation + dr
end

local set = function()
  love.graphics.push()
  love.graphics.rotate(-state.camera.rotation)
  love.graphics.scale(state.camera.scale_x, state.camera.scale_y)
  love.graphics.translate(-state.camera.pos_x, -state.camera.pos_y)
end

local set_position = function(x, y)
  state.camera.pos_x = x or state.camera.pos_x
  state.camera.pos_y = y or state.camera.pos_y
end

local set_scale = function(sx, sy)
  state.camera.scale_x = sx or state.camera.scale_x
  state.camera.scale_y = sy or sx or state.camera.scale_y
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
