require('keyboard')
require('world')
objects = require('objects')
systems = require('systems')
require('sounds')

love.load = function()
    seconds = 0
    debugOn = true
    love.window.setMode(800, 600)
    sounds.loadSounds()

    systems.call('SpawnObjects')
end

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

    entity = systems.grab('player')
    if entity.name == 'player' then
        love.graphics.setColor({1, 1, 1, 1})
        local clock_display = 'Time: ' .. roundOff(seconds)
        love.graphics.print(clock_display, 0, 0, 0, 2, 2)
        
        local xpos = 'X/Y Pos: ' .. roundOff(entity.body:getX()) .. '/' .. roundOff(entity.body:getY())
        love.graphics.print(xpos, 0, 25, 0, 2, 2)
        local currentVelocity = {entity.body:getLinearVelocity()}
        local ypos = 'X/Y Vel: ' .. roundOff(currentVelocity[1]).. '/' .. roundOff(currentVelocity[2])
        love.graphics.print(ypos, 0, 50, 0, 2, 2)

        topx, topy = entity.body:getWorldPoint(0, -25)
        local ratiox = (topx - entity.body:getX()) * 0.04
        local ratioy = (topy - entity.body:getY()) * 0.04
        local ratios = 'Ratios: ' .. roundOff(ratiox) .. ':' .. roundOff(ratioy)
        love.graphics.print(ratios, 0, 75, 0, 2, 2)

        angVel = player.body:getAngularVelocity()
        love.graphics.print('Angular Velocity: ' .. roundOff(angVel), 0, 100, 0, 2, 2)

        -- Direction line
        local lastColor = {love.graphics.getColor()}
        love.graphics.setColor({1, 0, 0, 1})
        for _,value in pairs(objects) do
            local currentVelocity = {value.body:getLinearVelocity()}
            local velocityArrow = {value.body:getX() + currentVelocity[1], value.body:getY() + currentVelocity[2]}
            love.graphics.line(value.body:getX(), value.body:getY(), velocityArrow[1], velocityArrow[2])
        end
        
        velocityArrow = {entity.body:getX() + currentVelocity[1], entity.body:getY() + currentVelocity[2]}
        love.graphics.setColor(lastColor)
        love.graphics.print('VelocityArrow: ' .. roundOff(velocityArrow[1]) .. '/' .. roundOff(velocityArrow[2]), 0, 125, 0, 2, 2)
    end
end


-- Game time
love.keypressed = function(pressed_key)
    if keyboard.key_map[pressed_key] then
        keyboard.key_map[pressed_key]()
    end
end

love.draw = function()
    systems.call('DrawObjects')
    --
    if debugOn then debug() end
end

love.update = function(dt)
    world:update(dt)
	seconds = seconds + dt
    systems.call('ControlPlayer')

    systems.call('UpdateObjects')
end
