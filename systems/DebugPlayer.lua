local System = require('lib/system')
local Entity = require('services/entity')
local state = require 'state'

local function debug(entity)

    -- Displays certain values useful for debugging
    local function roundOff(value)
        return math.floor(value * 100) / 100
    end

    if love.keyboard.isScancodeDown('n') then
        for index, data in ipairs(Entity.list) do
            print(index)

            for key, value in pairs(data) do
                print('\t', key, value)
            end
        end
    elseif love.keyboard.isScancodeDown('m') then
        print('=================================')
    end
    if state.debugOn then
        local pos_x = state.camera.pos_x
        local pos_y = state.camera.pos_y
        love.graphics.setColor({ 1, 1, 1, 1 })
        -- Time
        local clock_display = 'Time: ' .. roundOff(love.seconds)
        love.graphics.print(clock_display, pos_x, pos_y, 0, 0.9, 0.9)
        -- The Position
        local playerPosition = 'X/Y Pos: ' .. roundOff(entity.body:getX()) .. '/' .. roundOff(entity.body:getY())
        love.graphics.print(playerPosition, pos_x, pos_y + 25, 0, 0.9, 0.9)
        -- Velocity of the Player
        local currentVelocityX, currentVelocityY = entity.body:getLinearVelocity()
        local playerVelocity = 'X/Y Vel: ' .. roundOff(currentVelocityX) .. '/' .. roundOff(currentVelocityY)
        love.graphics.print(playerVelocity, pos_x, pos_y + 50, 0, 0.9, 0.9)
        -- Camera Pos
        local campos = 'Camera: ' .. roundOff(pos_x) .. ':' .. roundOff(pos_y)
        love.graphics.print(campos, pos_x, pos_y + 100, 0, 0.9, 0.9)
        -- VelocityArrow Line For the Player
        local velocityArrowX = entity.body:getX() + currentVelocityX
        local velocityArrowY = entity.body:getY() + currentVelocityY
        -- Location of arrow
        love.graphics.print('VelocityArrow: ' .. roundOff(velocityArrowX) .. '/'
            .. roundOff(velocityArrowY), pos_x, pos_y + 125, 0, 0.9, 0.9)
        -- Actually Draw the Line
        love.graphics.setColor({ 1, 0, 0, 1 })
        love.graphics.line(entity.body:getX(), entity.body:getY(), velocityArrowX,velocityArrowY)

    end
end

return System(
    { '_entity', '-isControlled' },
    function(entity)
        debug(entity)
    end
)
