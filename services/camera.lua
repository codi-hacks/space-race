--- Camera
-- Translation layer between coordinates and drawn graphics

-- Distance between player and screen edge before the
-- player is considered to be in the bounary in which
-- the camera needs to be moved.


love.state.camera.boundary_size = 0
love.state.camera.pos_x = 0 * .5
love.state.camera.pos_y = 0 * .5
love.state.camera.rotation = 0
love.state.camera.scale_x = 1
love.state.camera.scale_y = 1
love.state.camera.window_width, love.state.camera.window_height = love.graphics:getDimensions()

local window_width = love.state.camera.window_width / love.state.camera.scale_x
local window_height = love.state.camera.window_height / love.state.camera.scale_y
-- https://love2d.org/wiki/FilterMode
love.graphics.setDefaultFilter('nearest', 'nearest')

local get_boundary_bottom = function()
    return love.state.camera.pos_y + window_height - love.state.camera.boundary_size
end

local get_boundary_left = function()
    return love.state.camera.pos_x + love.state.camera.boundary_size
end

local get_boundary_right = function()
    return love.state.camera.pos_x + window_width - love.state.camera.boundary_size
end

local get_boundary_top = function()
    return love.state.camera.pos_y + love.state.camera.boundary_size
end

local get_position = function()
    return love.state.camera.pos_x, love.state.camera.pos_y
end

local move = function(dx, dy)
    love.state.camera.pos_x = love.state.camera.pos_x + (dx or 0)
    love.state.camera.pos_y = love.state.camera.pos_y + (dy or 0)
end

local rotate = function(dr)
    love.state.camera.rotation = love.state.camera.rotation + dr
end

local set = function()
    love.graphics.push()
    love.graphics.rotate(-love.state.camera.rotation)
    love.graphics.scale(love.state.camera.scale_x, love.state.camera.scale_y)
    love.graphics.translate(-love.state.camera.pos_x, -love.state.camera.pos_y)
end

local set_position = function(x, y)
    love.state.camera.pos_x = x or love.state.camera.pos_x
    love.state.camera.pos_y = y or love.state.camera.pos_y
end

local set_scale = function(sx, sy)
    love.state.camera.scale_x = sx or love.state.camera.scale_x
    love.state.camera.scale_y = sy or sx or love.state.camera.scale_y
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
