require('world')
require('/services/sounds')

-- .player dude
local player = {}
player.name = 'player'
player.type = 'entity'
player.isControlled = true
player.size = 25
player.position = {x = 350, y = 350}
player.mass = 1
player.layer = 1
player.body = love.physics.newBody(world, 0, 0, 'dynamic')
--player.shape = love.physics.newRectangleShape(player.size * 2, player.size * 2)
player.shape = love.physics.newPolygonShape(0,-25, -25,2, -25,25, 25,2, 25,25)
player.fixture = love.physics.newFixture(player.body, player.shape)
player.body:setMass(player.mass) -- TODO center of mass still seems wonky
player.fixture:setRestitution(0.5)
player.fixture:setUserData('player')
player.update = nil
player.draw = function()
    love.graphics.setColor({1, 0, 0, 1})
    local localX, localY = player.body:getWorldPoint(0, 25)
    love.graphics.circle('fill', localX, localY, 10)
    --Use this line to show hitbox with debug menu later: love.graphics.polygon('line', player.body:getWorldPoints(player.shape:getPoints()))
    love.graphics.setColor({1, 1, 1, 1})
    love.graphics.draw(textures.spaceship, player.body:getX(), player.body:getY(), player.body:getAngle(), 2, 2, 12.5, 12.5)
end

return player
