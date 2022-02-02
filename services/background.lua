-- Load random spots for stars to be drawn then draw them.
local state = require 'state'
local background = {}

function background.load()
    -- Load returns a table full of values for star locations
    local randomsTable = {}
    local window_x = math.floor(state.camera.window_width / 10)
    local window_y = math.floor(state.camera.window_height / 10)
    for i=10, window_x, 10 do
        for j=10, window_y, 10 do
            local random_x = (i - love.math.random(0, 9)) * 10
            local random_y = (j - love.math.random(0, 9)) * 10
            table.insert(randomsTable, {random_x, random_y})
        end
    end

    return randomsTable
end

function background.draw(randoms)
    -- Renders generated star pattern over many window areas (as decided by `repeats`).
    -- Probably should create a system where it only renders when visible,
    -- but it seems fine for now.
    local window_x = state.camera.window_width
    local window_y = state.camera.window_height
    local repeats = 10
    for _,coords in ipairs(randoms) do
        love.graphics.setColor({1, 1, 1, 1})
        for i = window_x * -repeats, window_x * repeats, window_x do
            for j = window_y * -repeats, window_y * repeats, window_y do
                love.graphics.circle('fill', coords[1] + i, coords[2] + j, 1)
            end
        end
    end
end

return background
