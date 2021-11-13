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
    if self.body:getX() < -25 then
        self.body:setX(825)
    elseif self.body:getX() > 825 then
        self.body:setX(-25)
    end
    if self.body:getY() < -26 then
        self.body:setY(625)
    elseif self.body:getY() > 626 then
        self.body:setY(-25)
    end
end

return player