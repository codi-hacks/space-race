require('keyboard')
require('world')
local obj = require('objects')

love.load = function()
    seconds = 0
    debugOn = false
    love.window.setMode(800, 600)
end

function debug()
    love.graphics.setColor({1, 1, 1, 1})
    local clock_display = 'Time: ' .. math.floor(seconds * 100) / 100
	love.graphics.print(clock_display, 0, 0, 0, 2, 2)
	local xpos = 'X/Y Pos: ' .. math.floor(obj.square.body:getX() * 100) / 100 .. '/' .. math.floor(obj.square.body:getY() * 100) / 100
	love.graphics.print(xpos, 0, 25, 0, 2, 2)
    local currentVelocity = {obj.square.body:getLinearVelocity()}
	local ypos = 'X/Y Vel: ' .. math.floor(currentVelocity[1] * 100) / 100 .. '/' .. math.floor(currentVelocity[2] * 100) / 100
	love.graphics.print(ypos, 0, 50, 0, 2, 2)
    local something = 'Value: ' .. 'nothing'
	love.graphics.print(something, 0, 75, 0, 2, 2)
end


-- Game time
love.keypressed = function(pressed_key)
    if keyboard.key_map[pressed_key] then
        keyboard.key_map[pressed_key]()
    end
end

love.draw = function()
    love.graphics.setColor({1, 1, 1, 1})
    localX, localY = obj.square.body:getWorldPoint(0, 25)
    love.graphics.circle('fill', localX, localY, 10)
	love.graphics.setColor({1, 0, 0, 1})
    love.graphics.polygon('fill', obj.square.body:getWorldPoints(obj.square.shape:getPoints()))

    love.graphics.setColor({0, 0, 1, 1})
    love.graphics.circle('line', obj.circle.body:getX(), obj.circle.body:getY(), obj.circle.size)

    love.graphics.setColor({1, 1, 0, 1})
    love.graphics.polygon('fill', objects.bullet.body:getWorldPoints(objects.bullet.shape:getPoints()))

    love.graphics.setColor({1, 1, 1, 1})
    if debugOn then debug() end
end

love.update = function(dt)
    world:update(dt)
	seconds = seconds + dt
    keyboard.move(dt, obj.square)

    keptObjects = {'square', 'bullet', 'circle'}
    for _,v in ipairs(keptObjects) do
        obj[v].update(obj[v])
    end
end
