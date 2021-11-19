-- .player dude
player = {}
player.size = 25
player.position = {x = 350, y = 350}
player.body = love.physics.newBody(world, 0, 0, 'dynamic')
player.shape = love.physics.newRectangleShape(player.size * 2, player.size * 2)
player.fixture = love.physics.newFixture(player.body, player.shape)
player.fixture:setRestitution(0.5)
player.fixture:setUserData('player')
player.update = function(self)
    angVel = player.body:getAngularVelocity()
    maxAngVel = 2

    -- This slows player left/right spin to a halt once they are not holding the button
    -- Caution: This hardcodes the left/right buttons and should probably be reworked
    -- so that it doesn't need to.
    if not love.keyboard.isDown('a', 'd') or math.abs(angVel) > maxAngVel then
        if angVel < 0 then
            player.body:applyAngularImpulse(10)
        elseif angVel > 0 then
            player.body:applyAngularImpulse(-10)
        end
    end

    -- Engine sound effect (also hardcodes movement keys)
    if love.keyboard.isDown('w', 's') then
        if not engineSound:isPlaying() then
            love.audio.play(sounds.engine)
        end
    else
        love.audio.stop(engineSound)
    end

    -- Copy from keepThingsOnScreen
    if self.body:getX() < -25 then
        self.body:setX(825)
    elseif self.body:getX() > 825 then
        self.body:setX(-25)
    end
    if self.body:getY() < -25 then
        self.body:setY(625)
    elseif self.body:getY() > 626 then
        self.body:setY(-25)
    end
end

return player