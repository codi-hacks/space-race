system = require('lib/system')

keyboard = {}

keyboard.key_map = {
    escape = function()
        love.event.quit()
    end,
    b = function()
        debugOn = not debugOn
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
        body:applyForce(ratiox * movementForce * -0.25, ratioy * movementForce * -0.25)
    end

    -- Steer spaceship left and right
    local angVel = player.body:getAngularVelocity()
    local maxAngVel = 2
    if angVel > -maxAngVel and angVel < maxAngVel then
        if love.keyboard.isScancodeDown('a') then
            body:applyTorque(-600)
        end
        if love.keyboard.isScancodeDown('d') then
            body:applyTorque(600)
        end
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
    if love.keyboard.isScancodeDown('p') then
        body:setAngularVelocity(20)
    end
end

return keyboard