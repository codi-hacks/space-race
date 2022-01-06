local System = require('/lib/system')

function debug()
    -- Displays certain values useful for debugging
    function roundOff(value)
        return math.floor(value * 100) / 100
    end

    -- View all objects currently in the entity component system
    if love.keyboard.isScancodeDown('n') then
        for index, data in ipairs(objects) do
            print(index)

            for key, value in pairs(data) do
                print('\t', key, value)
            end
        end
    elseif love.keyboard.isScancodeDown('m') then
        print('=================================')
    end

    if true == true then
        love.graphics.setColor({1, 1, 1, 1})
        local clock_display = 'Time: ' .. roundOff(seconds)
        love.graphics.print(clock_display, pos_x, pos_y, 0, 2, 2)

        pos_x = state.camera.pos_x
        pos_y = state.camera.pos_y
        local playerPosition = 'X/Y Pos: ' .. roundOff(playerBody:getX()) .. '/' .. roundOff(playerBody:getY())
        love.graphics.print(playerPosition, pos_x, pos_y + 25, 0, 2, 2)
        local currentVelocity = {playerBody:getLinearVelocity()}
        local playerVelocity = 'X/Y Vel: ' .. roundOff(currentVelocity[1]).. '/' .. roundOff(currentVelocity[2])
        love.graphics.print(playerVelocity, pos_x, pos_y + 50, 0, 2, 2)

        local campos = 'Camera: ' .. roundOff(pos_x) .. ':' .. roundOff(pos_y)
        love.graphics.print(campos, pos_x, pos_y + 100, 0, 2, 2)

        -- Direction line and hitbox
        local lastColor = {love.graphics.getColor()}
        love.graphics.setColor({1, 0, 0, 1})
        for _,value in pairs(entities) do
            local currentVelocity = {value.body:getLinearVelocity()}
            local velocityArrow = {value.body:getX() + currentVelocity[1], value.body:getY() + currentVelocity[2]}
            love.graphics.line(value.body:getX(), value.body:getY(), velocityArrow[1], velocityArrow[2])
        end

        velocityArrow = {playerBody:getX() + currentVelocity[1], playerBody:getY() + currentVelocity[2]}
        love.graphics.setColor(lastColor)
        love.graphics.print('VelocityArrow: ' .. roundOff(velocityArrow[1]) .. '/' .. roundOff(velocityArrow[2]), pos_x, pos_y + 125, 0, 2, 2)
    end
end

return debug
