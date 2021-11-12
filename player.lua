-- .player dude
player = {}
player.size = 25
player.body = love.physics.newBody(world, 350, 350, 'dynamic')
player.shape = love.physics.newRectangleShape(player.size * 2, player.size * 2)
player.fixture = love.physics.newFixture(player.body, player.shape)
player.fixture:setRestitution(0.5)
player.fixture:setUserData('player')
player.update = function(self)
    angVel = player.body:getAngularVelocity()
    maxAngVel = 2

    if not love.keyboard.isDown('f', 'h') or math.abs(angVel) > maxAngVel then
        if angVel < 0 then
            player.body:applyAngularImpulse(10)
        elseif angVel > 0 then
            player.body:applyAngularImpulse(-10)
        end
    end

    -- Copy from keepThingsOnScreen
    if player.body:getX() < -25 then
        player.body:setX(825)
    elseif player.body:getX() > 825 then
        player.body:setX(-25)
    end
    if player.body:getY() < -26 then
        player.body:setY(625)
    elseif player.body:getY() > 626 then
        player.body:setY(-25)
    end
end

return player