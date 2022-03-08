local System = require('lib/system')
local Entity = require('services/entity')
local State = require 'services/state'

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
    if State.debugOn then
        love.graphics.setNewFont('assets/gnevejpixel.ttf', 30)
        local pos_x = State.camera.pos_x
        local pos_y = State.camera.pos_y
        love.graphics.setColor({ 1, 1, 1, 1 })
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
        love.graphics.setColor({ 1, 1, 1, 1 }) -- Added this line to fix sprite drawing as red - J.R.C 2/2/22

        -- Window debug information
        love.graphics.setColor({ 1, 0, 1, 1 })
        love.graphics.line(pos_x, pos_y + 300, pos_x + 800, pos_y + 300)
        love.graphics.line(pos_x + 400, pos_y, pos_x + 400, pos_y + 600)

        love.graphics.setColor({ 1, 1, 1, 1 })
        love.graphics.circle('fill', 400 + State.camera.pos_x, 300 + State.camera.pos_y, 5)
    end
end

return System(
    { '_entity', '-isControlled' },
    function(entity)
        debug(entity)
    end
)
