local System = require('lib/system')
local Entity = require('services/entity')
local state = require('state')

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
        pos_x = state.camera.pos_x;
        pos_y = state.camera.pos_y;
        love.graphics.setColor({ 1, 1, 1, 1 })


        local clock_display = 'Time: ' .. roundOff(seconds)
        love.graphics.print(clock_display, pos_x, pos_y, 0, 0.9, 0.9)


        local playerPosition = 'X/Y Pos: ' .. roundOff(entity.body:getX()) .. '/' .. roundOff(entity.body:getY())
        love.graphics.print(playerPosition, pos_x, pos_y + 25, 0, 0.9, 0.9)
        local currentVelocity = { entity.body:getLinearVelocity() }
        local playerVelocity = 'X/Y Vel: ' .. roundOff(currentVelocity[1]) .. '/' .. roundOff(currentVelocity[2])
        love.graphics.print(playerVelocity, pos_x, pos_y + 50, 0, 0.9, 0.9)

        local campos = 'Camera: ' .. roundOff(pos_x) .. ':' .. roundOff(pos_y)
        love.graphics.print(campos, pos_x, pos_y + 100, 0, 0.9, 0.9)

        -- Direction line and hitbox
        local lastColor = { love.graphics.getColor() }
        love.graphics.setColor({ 1, 0, 0, 1 })
        for _, value in pairs(Entity.list) do
            local currentVelocity = { value.body:getLinearVelocity() }
            local velocityArrow = { value.body:getX() + currentVelocity[1], value.body:getY() + currentVelocity[2] }
            love.graphics.line(value.body:getX(), value.body:getY(), velocityArrow[1], velocityArrow[2])
        end

        velocityArrow = { entity.body:getX() + currentVelocity[1], entity.body:getY() + currentVelocity[2] }
        love.graphics.setColor(lastColor)
        love.graphics.print('VelocityArrow: ' .. roundOff(velocityArrow[1]) .. '/' .. roundOff(velocityArrow[2]), pos_x, pos_y + 125, 0, 0.9, 0.9)
    end
end

return System(
    { '_entity','-isControlled' },
    function(entity)
        debug(entity)
    end
)
