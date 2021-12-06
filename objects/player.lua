require('world')
require('sounds')

-- .player dude
player = {}
player.name = 'player'
player.isControlled = true
player.size = 25
player.position = {x = 350, y = 350}
player.mass = 1
player.body = love.physics.newBody(world, 0, 0, 'dynamic')
player.shape = love.physics.newRectangleShape(player.size * 2, player.size * 2)
player.fixture = love.physics.newFixture(player.body, player.shape)
player.fixture:setRestitution(0.5)
player.fixture:setUserData('player')
player.body:setMass(player.mass)
player.update = function()
    -- Copy from keepThingsOnScreen
--[[    if player.body:getX() < -25 then
        player.body:setX(825)
    elseif player.body:getX() > 825 then
        player.body:setX(-25)
    end
    if player.body:getY() < -25 then
        player.body:setY(625)
    elseif player.body:getY() > 626 then
        player.body:setY(-25)
    end ]]--
end
player.draw = function()
    love.graphics.setColor({1, 0, 0, 1})
    local localX, localY = player.body:getWorldPoint(0, 25)
    love.graphics.circle('fill', localX, localY, 10)
	love.graphics.setColor({0, 1, 0.5, 1})
    love.graphics.polygon('fill', player.body:getWorldPoints(player.shape:getPoints()))
end

return player