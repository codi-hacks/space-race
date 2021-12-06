require('keyboard')
require('world')
objects = require('objects')
systems = require('systems')
require('sounds')
Camera = require('camera')
require('state')

love.load = function()
    seconds = 0
    blinkTimer = 0
    blink = true
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
        love.graphics.print(clock_display, pos_x, pos_y, 0, 2, 2)
        
        pos_x = state.camera.pos_x
        pos_y = state.camera.pos_y
        local xpos = 'X/Y Pos: ' .. roundOff(entity.body:getX()) .. '/' .. roundOff(entity.body:getY())
        love.graphics.print(xpos, pos_x, pos_y + 25, 0, 2, 2)
        local currentVelocity = {entity.body:getLinearVelocity()}
        local ypos = 'X/Y Vel: ' .. roundOff(currentVelocity[1]).. '/' .. roundOff(currentVelocity[2])
        love.graphics.print(ypos, pos_x, pos_y + 50, 0, 2, 2)

        local ratios = 'Gravity: ' .. forcex .. ':' .. forcey
        love.graphics.print(ratios, pos_x, pos_y + 75, 0, 2, 2)

        local campos = 'Camera: ' .. pos_x .. ':' .. pos_y
        love.graphics.print(campos, pos_x, pos_y + 100, 0, 2, 2)

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
        love.graphics.print('VelocityArrow: ' .. roundOff(velocityArrow[1]) .. '/' .. roundOff(velocityArrow[2]), pos_x, pos_y + 125, 0, 2, 2)
    end
end


-- Game time
love.keypressed = function(pressed_key)
    if keyboard.key_map[pressed_key] then
        keyboard.key_map[pressed_key]()
    end
end

love.draw = function()
    Camera.set()

    systems.call('DrawObjects')

    if state.debugOn then debug() end

    if state.paused == true then
        blinkTimer = blinkTimer + love.timer.getDelta()
        if blinkTimer > .25 then
            blinkTimer = 0
            blink = not blink
        end
        if blink == true then
            love.graphics.setColor({1, 0, 0, 1})
            love.graphics.rectangle('line', state.camera.pos_x, state.camera.pos_y,
            state.camera.window_width, state.camera.window_height)
        end
    end

    Camera.unset()
end

love.update = function(dt)
    if state.paused == false then
        world:update(dt)
        seconds = seconds + dt
        for _, entity in ipairs(objects) do
            systems.ControlPlayer(entity)
            systems.UpdateObjects(entity)
            systems.Gravitate(entity, entity)
            systems.UpdateCamera(entity)
        end

        if seconds <= 1 then
            state.camera.scale_x = 1 / seconds
        else
            state.camera.scale_x = 1
        end
    end
end
