require('world')
require('sounds')

-- .player dude
player = {}
player.name = 'player'
player.isControlled = true
player.size = 25
player.position = {x = 350, y = 350}
player.body = love.physics.newBody(world, 0, 0, 'dynamic')
player.shape = love.physics.newRectangleShape(player.size * 2, player.size * 2)
player.fixture = love.physics.newFixture(player.body, player.shape)
player.fixture:setRestitution(0.5)
player.fixture:setUserData('player')
player.update = function()
    angVel = player.body:getAngularVelocity()
    maxAngVel = 2

    -- This slows player left/right spin to a halt once they are not holding the button
    -- Caution: This hardcodes the left/right buttons and should probably be reworked
    -- so that it doesn't need to.
    if not love.keyboard.isScancodeDown('a', 'd') or math.abs(angVel) > maxAngVel then
        if angVel < 0 then
            player.body:applyAngularImpulse(10)
        elseif angVel > 0 then
            player.body:applyAngularImpulse(-10)
        end
    end

    -- Engine sound effect (also hardcodes movement keys)
    if love.keyboard.isScancodeDown('w', 's') then
        if not sounds.engine:isPlaying() then
            sounds.engine:setLooping(true)
            love.audio.play(sounds.engine)
        end
    else
        love.audio.stop(sounds.engine)
    end

    -- Copy from keepThingsOnScreen
    if player.body:getX() < -25 then
        player.body:setX(825)
    elseif player.body:getX() > 825 then
        player.body:setX(-25)
    end
    if player.body:getY() < -25 then
        player.body:setY(625)
    elseif player.body:getY() > 626 then
        player.body:setY(-25)
    end
end
player.draw = function()
    love.graphics.setColor({1, 0, 0, 1})
    local localX, localY = player.body:getWorldPoint(0, 25)
    love.graphics.circle('fill', localX, localY, 10)
	love.graphics.setColor({0, 1, 0.5, 1})
    love.graphics.polygon('fill', player.body:getWorldPoints(player.shape:getPoints()))
end

return player