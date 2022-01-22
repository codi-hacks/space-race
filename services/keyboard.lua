local Entity = require('services/entity')
local state = require('state')
local sounds = require('services/sounds')
local menu = require('menu/menu')

local keyboard = {}

keyboard.key_map = {
    escape = function()
        love.event.quit()
    end,
    b = function()
        state.debugOn = not state.debugOn
    end,
    o = function()
        local player = Entity.grab('player')
        player.body:setX(player.position.x)
        player.body:setY(player.position.y)
    end,
    p = function()
        state.paused = not state.paused
        menu.load()
        love.audio.play(sounds.chirp_up)
    end
}


keyboard.move = function (body, time)
    -- Standard amount of force to base movement off of
    local movementForce = 100

    -- Variables that allows the function to know which way the spaceship
    -- is pointing and to move it in that direction.
    local topx, topy = body:getWorldPoint(0, -25)
    local ratiox = (topx - body:getX()) * 0.04
    local ratioy = (topy - body:getY()) * 0.04

    -- Fly spaceship forwards and backwards
    if love.keyboard.isScancodeDown('w') then
        body:applyForce(ratiox * movementForce, ratioy * movementForce)
    end
    if love.keyboard.isScancodeDown('s') then
        body:applyForce(-ratiox * movementForce, -ratioy * movementForce)
    end

    -- Steer spaceship left and right
    local angVel = body:getAngularVelocity()
    local maxAngVel = 2
    if angVel > -maxAngVel and angVel < maxAngVel then
        if love.keyboard.isScancodeDown('a') then
            body:applyTorque(-600)
        end
        if love.keyboard.isScancodeDown('d') then
            body:applyTorque(600)
        end
    end

    -- Brake (applies force in opposite the current direction)
    if love.keyboard.isScancodeDown('space') then
        local brakeForce = {body:getLinearVelocity()}
        for k,_ in ipairs(brakeForce) do
            brakeForce[k] = brakeForce[k] * 2
            if math.abs(brakeForce[k]) > movementForce then
                brakeForce[k] = -movementForce * (brakeForce[k]>0 and 1 or brakeForce[k]<0 and -1 or 0)
            else
                brakeForce[k] = -brakeForce[k]
            end
        end

        body:applyForce(brakeForce[1], brakeForce[2])
    end

    -- This slows player left/right spin to a halt once they are not holding the button
    -- Caution: This hardcodes the left/right buttons and should probably be reworked
    -- so that it doesn't need to.
    if not love.keyboard.isScancodeDown('a', 'd') or math.abs(angVel) > maxAngVel then
        if angVel < 0 then
            body:applyAngularImpulse(2)
        elseif angVel > 0 then
            body:applyAngularImpulse(-2)
        end
    end

    -- Engine sound effect (also hardcodes movement keys)
    if love.keyboard.isScancodeDown('space') then
        brakeForce = {body:getLinearVelocity()}
        if (math.abs(brakeForce[1]) + math.abs(brakeForce[2])) > 0.5 then
            love.audio.stop(sounds.engine)
            if not sounds.braking:isPlaying() then
                sounds.braking:setLooping(true)
                love.audio.play(sounds.braking)
            end
        else
            love.audio.stop(sounds.braking)
        end
    elseif love.keyboard.isScancodeDown('w', 's') then
        love.audio.stop(sounds.braking)
        if not sounds.engine:isPlaying() then
            sounds.engine:setLooping(true)
            love.audio.play(sounds.engine)
        end
    else
        love.audio.stop(sounds.engine)
        love.audio.stop(sounds.braking)
    end




    -- The rest of this function is completely optional
    -- (and was left in because it may be useful during development)
    -- Move object via arrow keys with directional force
    if love.keyboard.isScancodeDown('up') then
        body:applyForce(0, -movementForce)
    end
    if love.keyboard.isScancodeDown('down') then
        body:applyForce(0, movementForce)
    end
    if love.keyboard.isScancodeDown('right') then
        body:applyForce(movementForce, 0)
    end
    if love.keyboard.isScancodeDown('left') then
        body:applyForce(-movementForce, 0)
    end

    -- Move using arrow keys (while holding shift) with "teleportation".
    -- A.K.A. adjusting the x/y of an object.
    if love.keyboard.isScancodeDown('lshift') then
        body:setLinearVelocity(0, 0)
        body:setAngularVelocity(0)
        local movespeed = 200
        local xpos = body:getX()
        local ypos = body:getY()
        if love.keyboard.isScancodeDown('up') then
            ypos = ypos - time * movespeed
        end
        if love.keyboard.isScancodeDown('down') then
            ypos = ypos + time * movespeed
        end
        if love.keyboard.isScancodeDown('left') then
            xpos = xpos - time * movespeed
        end
        if love.keyboard.isScancodeDown('right') then
            xpos = xpos + time * movespeed
        end

        body:setX(xpos)
        body:setY(ypos)
    end

    -- Induce crazy spin
    if love.keyboard.isScancodeDown('l') then
        body:setAngularVelocity(20)
    end
end

return keyboard
