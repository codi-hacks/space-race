require('keyboard')
require('world')
local objects = require('objects')

love.load = function()
    seconds = 0
    debugOn = false
    love.window.setMode(800, 600)
end

function debug()
    function roundOff(value)
        return math.floor(value * 100) / 100
    end
    love.graphics.setColor({1, 1, 1, 1})
    local clock_display = 'Time: ' .. roundOff(seconds)
	love.graphics.print(clock_display, 0, 0, 0, 2, 2)
	local xpos = 'X/Y Pos: ' .. roundOff(objects.square.body:getX()) .. '/' .. roundOff(objects.square.body:getY())
	love.graphics.print(xpos, 0, 25, 0, 2, 2)
    local currentVelocity = {objects.square.body:getLinearVelocity()}
	local ypos = 'X/Y Vel: ' .. roundOff(currentVelocity[1]).. '/' .. roundOff(currentVelocity[2])
	love.graphics.print(ypos, 0, 50, 0, 2, 2)

    bottomx, bottomy = objects.square.body:getWorldPoint(0, 25)
    topx, topy = objects.square.body:getWorldPoint(0, -25)
    --ratiox = (topx/bottomx - 1) * 6.666666
    ratiox = (topx - objects.player.body:getX()) * 0.04
    ratioy = (topy - objects.player.body:getY()) * 0.04
    local ratios = 'Ratios: ' .. roundOff(ratiox) .. ':' .. roundOff(ratioy)
	love.graphics.print(ratios, 0, 75, 0, 2, 2)

    angVel = player.body:getAngularVelocity()
	love.graphics.print('Angular Velocity: ' .. roundOff(angVel), 0, 100, 0, 2, 2)
end


-- Game time
love.keypressed = function(pressed_key)
    if keyboard.key_map[pressed_key] then
        keyboard.key_map[pressed_key]()
    end
end

love.draw = function()
    love.graphics.setColor({1, 0, 0, 1})
    localX, localY = objects.square.body:getWorldPoint(0, 25)
    love.graphics.circle('fill', localX, localY, 10)
	love.graphics.setColor({0, 1, 0.5, 1})
    love.graphics.polygon('fill', objects.square.body:getWorldPoints(objects.square.shape:getPoints()))    
    love.graphics.setColor({0, 0, 1, 1})
    love.graphics.circle('line', objects.circle.body:getX(), objects.circle.body:getY(), objects.circle.size)

    love.graphics.setColor({1, 1, 0, 1})
    love.graphics.polygon('fill', objects.bullet.body:getWorldPoints(objects.bullet.shape:getPoints()))

    love.graphics.setColor({1, 1, 1, 1})
    if debugOn then debug() end
end

love.update = function(dt)
    world:update(dt)
	seconds = seconds + dt
    keyboard.move(dt, objects.square)

    keptObjects = {'square', 'bullet', 'circle'}
    for _,v in ipairs(keptObjects) do
        objects[v].update(objects[v])
    end
end
