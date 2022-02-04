local Entity = require('services/entity')
local Love = require 'services/love'
local State = require('services/state')
local sounds = require('services/sounds')
local menu = require('menu/menu')

local keyboard = {}

keyboard.key_map = {
    escape = function()
        Love.event.quit()
    end,
    b = function()
        State.debugOn = not State.debugOn
    end,
    o = function()
        local player = Entity.grab('player')
        player.body:setX(player.position.x)
        player.body:setY(player.position.y)
    end,
    p = function()
        State.paused = not State.paused
        menu.load()
        Love.audio.play(sounds.chirp_up)
    end
}

keyboard.move = function(entity, time)
    local body = entity.body;
    -- Standard amount of force to base movement off of
    local movementForce = 100
    if entity.powerUps.speedBoost ~= nil and entity.powerUps.speedBoost.time > 0 then
        movementForce = movementForce + entity.powerUps.speedBoost.value
    end

    -- Variables that allows the function to know which way the spaceship
    -- is pointing and to move it in that direction.
    local topx, topy = body:getWorldPoint(0, -25)
    local ratiox = (topx - body:getX()) * 0.04
    local ratioy = (topy - body:getY()) * 0.04

    -- Fly spaceship forwards and backwards
    if Love.keyboard.isScancodeDown('w') then
        body:applyForce(ratiox * movementForce, ratioy * movementForce)
    end
    if Love.keyboard.isScancodeDown('s') then
        body:applyForce(-ratiox * movementForce, -ratioy * movementForce)
    end

    -- Steer spaceship left and right
    local angVel = body:getAngularVelocity()
    local maxAngVel = 2
    if angVel > -maxAngVel and angVel < maxAngVel then
        if Love.keyboard.isScancodeDown('a') then
            body:applyTorque(-600)
        end
        if Love.keyboard.isScancodeDown('d') then
            body:applyTorque(600)
        end
    end

    -- Brake (applies force in opposite the current direction)
    if Love.keyboard.isScancodeDown('space') then
        local brakeForce = { body:getLinearVelocity() }
        for k, _ in ipairs(brakeForce) do
            brakeForce[k] = brakeForce[k] * 2
            if math.abs(brakeForce[k]) > movementForce then
                brakeForce[k] = -movementForce * (brakeForce[k] > 0 and 1 or brakeForce[k] < 0 and -1 or 0)
            else
                brakeForce[k] = -brakeForce[k]
            end
        end

        body:applyForce(brakeForce[1], brakeForce[2])
    end

    -- This slows player left/right spin to a halt once they are not holding the button
    -- Caution: This hardcodes the left/right buttons and should probably be reworked
    -- so that it doesn't need to.
    if not Love.keyboard.isScancodeDown('a', 'd') or math.abs(angVel) > maxAngVel then
        if angVel < 0 then
            body:applyAngularImpulse(2)
        elseif angVel > 0 then
            body:applyAngularImpulse(-2)
        end
    end

    -- Engine sound effect (also hardcodes movement keys)
    if Love.keyboard.isScancodeDown('space') then
        local brakeForce = { body:getLinearVelocity() }
        if (math.abs(brakeForce[1]) + math.abs(brakeForce[2])) > 0.5 then
            Love.audio.stop(sounds.engine)
            if not sounds.braking:isPlaying() then
                sounds.braking:setLooping(true)
                Love.audio.play(sounds.braking)
            end
        else
            Love.audio.stop(sounds.braking)
        end
    elseif Love.keyboard.isScancodeDown('w', 's') then
        Love.audio.stop(sounds.braking)
        if not sounds.engine:isPlaying() then
            sounds.engine:setLooping(true)
            Love.audio.play(sounds.engine)
        end
    else
        Love.audio.stop(sounds.engine)
        Love.audio.stop(sounds.braking)
    end




    -- The rest of this function is completely optional
    -- (and was left in because it may be useful during development)
    -- Move object via arrow keys with directional force
    if Love.keyboard.isScancodeDown('up') then
        body:applyForce(0, -movementForce)
    end
    if Love.keyboard.isScancodeDown('down') then
        body:applyForce(0, movementForce)
    end
    if Love.keyboard.isScancodeDown('right') then
        body:applyForce(movementForce, 0)
    end
    if Love.keyboard.isScancodeDown('left') then
        body:applyForce(-movementForce, 0)
    end

    -- Move using arrow keys (while holding shift) with "teleportation".
    -- A.K.A. adjusting the x/y of an object.
    if Love.keyboard.isScancodeDown('lshift') then
        body:setLinearVelocity(0, 0)
        body:setAngularVelocity(0)
        local movespeed = 200
        if entity.powerUps.speedBoost ~= nil and entity.powerUps.speedBoost.time > 0 then
            movespeed = movespeed + entity.powerUps.speedBoost.value
        end
        local xpos = body:getX()
        local ypos = body:getY()
        if Love.keyboard.isScancodeDown('up') then
            ypos = ypos - time * movespeed
        end
        if Love.keyboard.isScancodeDown('down') then
            ypos = ypos + time * movespeed
        end
        if Love.keyboard.isScancodeDown('left') then
            xpos = xpos - time * movespeed
        end
        if Love.keyboard.isScancodeDown('right') then
            xpos = xpos + time * movespeed
        end

        body:setX(xpos)
        body:setY(ypos)
    end

    -- Induce crazy spin
    if Love.keyboard.isScancodeDown('l') then
        body:setAngularVelocity(20)
    end
    -- Power Up cleanup
    for _, data in pairs(entity.powerUps) do
        if data.time > 0 then
            data.time = data.time - 1
        end
    end


end
return keyboard
