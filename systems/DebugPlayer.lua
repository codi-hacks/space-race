local System = require('lib/system')
local Entity = require('services/entity')
local Love = require 'services/love'
local State = require 'services/state'

local function debug(entity)

    -- Displays certain values useful for debugging
    local function roundOff(value)
        return math.floor(value * 100) / 100
    end

    if Love.keyboard.isScancodeDown('n') then
        for index, data in ipairs(Entity.list) do
            print(index)

            for key, value in pairs(data) do
                print('\t', key, value)
            end
        end
    elseif Love.keyboard.isScancodeDown('m') then
        print('=================================')
    end
    if State.debugOn then
        local pos_x = State.camera.pos_x
        local pos_y = State.camera.pos_y
        Love.graphics.setColor({ 1, 1, 1, 1 })
        -- Time
        local clock_display = 'Time: ' .. roundOff(Love.seconds)
        Love.graphics.print(clock_display, pos_x, pos_y, 0, 0.9, 0.9)
        -- The Position
        local playerPosition = 'X/Y Pos: ' .. roundOff(entity.body:getX()) .. '/' .. roundOff(entity.body:getY())
        Love.graphics.print(playerPosition, pos_x, pos_y + 25, 0, 0.9, 0.9)
        -- Velocity of the Player
        local currentVelocityX, currentVelocityY = entity.body:getLinearVelocity()
        local playerVelocity = 'X/Y Vel: ' .. roundOff(currentVelocityX) .. '/' .. roundOff(currentVelocityY)
        Love.graphics.print(playerVelocity, pos_x, pos_y + 50, 0, 0.9, 0.9)
        -- Camera Pos
        local campos = 'Camera: ' .. roundOff(pos_x) .. ':' .. roundOff(pos_y)
        Love.graphics.print(campos, pos_x, pos_y + 100, 0, 0.9, 0.9)
        -- VelocityArrow Line For the Player
        local velocityArrowX = entity.body:getX() + currentVelocityX
        local velocityArrowY = entity.body:getY() + currentVelocityY
        -- Location of arrow
        Love.graphics.print('VelocityArrow: ' .. roundOff(velocityArrowX) .. '/'
            .. roundOff(velocityArrowY), pos_x, pos_y + 125, 0, 0.9, 0.9)
        -- Actually Draw the Line
        Love.graphics.setColor({ 1, 0, 0, 1 })
        Love.graphics.line(entity.body:getX(), entity.body:getY(), velocityArrowX,velocityArrowY)
        Love.graphics.setColor({ 1, 1, 1, 1 }) -- Added this line to fix sprite drawing as red - J.R.C 2/2/22
    end
end

return System(
    { '_entity', '-isControlled' },
    function(entity)
        debug(entity)
    end
)
