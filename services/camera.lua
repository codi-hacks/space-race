--- Camera
-- Translation layer between coordinates and drawn graphics

-- Distance between player and screen edge before the
-- player is considered to be in the bounary in which
-- the camera needs to be moved.
local State = require 'services/state'

State.camera.boundary_size = 0
State.camera.pos_x = 0 * .5
State.camera.pos_y = 0 * .5
State.camera.rotation = 0
State.camera.scale_x = 1
State.camera.scale_y = 1
State.camera.window_width, State.camera.window_height = 800, 600

local window_width = State.camera.window_width
local window_height = State.camera.window_height
-- https://love2d.org/wiki/FilterMode
love.graphics.setDefaultFilter('nearest', 'nearest')

local get_boundary_bottom = function()
    return State.camera.pos_y + window_height - State.camera.boundary_size
end

local get_boundary_left = function()
    return State.camera.pos_x + State.camera.boundary_size
end

local get_boundary_right = function()
    return State.camera.pos_x + window_width - State.camera.boundary_size
end

local get_boundary_top = function()
    return State.camera.pos_y + State.camera.boundary_size
end

local get_position = function()
    return State.camera.pos_x, State.camera.pos_y
end

local move = function(dx, dy)
    State.camera.pos_x = State.camera.pos_x + (dx or 0)
    State.camera.pos_y = State.camera.pos_y + (dy or 0)
end

local resize = function(dx)
    State.camera.scale_x = dx
    State.camera.scale_y = dx

    State.camera.window_width = 800 * dx
    State.camera.window_height = 600 * dx
    love.window.updateMode(State.camera.window_width, State.camera.window_height)
end


local rotate = function(dr)
    State.camera.rotation = State.camera.rotation + dr
end

local set = function()
    love.graphics.push()
    love.graphics.rotate(-State.camera.rotation)
    love.graphics.scale(State.camera.scale_x, State.camera.scale_y)
    love.graphics.translate(-State.camera.pos_x, -State.camera.pos_y)
end

local set_position = function(x, y)
    State.camera.pos_x = x or State.camera.pos_x
    State.camera.pos_y = y or State.camera.pos_y
end

local set_scale = function(sx, sy)
    State.camera.scale_x = sx or State.camera.scale_x
    State.camera.scale_y = sy or sx or State.camera.scale_y
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
    resize = resize,
    rotate = rotate,
    set = set,
    set_position = set_position,
    set_scale = set_scale,
    unset = unset
}
