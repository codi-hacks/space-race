keyboard = {}

keyboard.key_map = {
    escape = function()
        love.event.quit()
    end,
    b = function()
        debugOn = not debugOn
    end
}

function keyboard.move(time, obj)
    -- Standard amount of force to base movement off of
    local movementForce = 100

    -- Variables that allows the function to know which way the spaceship
    -- is pointing and to move it in that direction.
    local topx, topy = objects.square.body:getWorldPoint(0, -25)
    local ratiox = (topx - obj.body:getX()) * 0.04
    local ratioy = (topy - obj.body:getY()) * 0.04

    -- Fly spaceship forwards and backwards
    if love.keyboard.isScancodeDown('w') then
        obj.body:applyForce(ratiox * movementForce, ratioy * movementForce)
    end
    if love.keyboard.isScancodeDown('s') then
        obj.body:applyForce(ratiox * movementForce * -0.25, ratioy * movementForce * -0.25)
    end

    -- Steer spaceship left and right
    local angVel = player.body:getAngularVelocity()
    local maxAngVel = 2
    if angVel > -maxAngVel and angVel < maxAngVel then
        if love.keyboard.isScancodeDown('a') then
            obj.body:applyTorque(-600)
        end
        if love.keyboard.isScancodeDown('d') then
            obj.body:applyTorque(600)
        end
    end

    -- The rest of this function is completely optional
    -- (and was left in because it may be useful during development)
    -- Move object via arrow keys with directional force
    if love.keyboard.isScancodeDown('up') then
        obj.body:applyForce(0, -movementForce)
    end
    if love.keyboard.isScancodeDown('down') then
        obj.body:applyForce(0, movementForce)
    end
    if love.keyboard.isScancodeDown('right') then
        obj.body:applyForce(movementForce, 0)
    end
    if love.keyboard.isScancodeDown('left') then
        obj.body:applyForce(-movementForce, 0)
    end

    -- Move using arrow keys (while holding shift) with "teleportation".
    -- A.K.A. adjusting the x/y of an object.
    if love.keyboard.isScancodeDown('lshift') then
        obj.body:setLinearVelocity(0, 0)
        obj.body:setAngularVelocity(0)
        local movespeed = 200
        local xpos = obj.body:getX()
        local ypos = obj.body:getY()
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

        obj.body:setX(xpos)
        obj.body:setY(ypos)
    end

    -- Induce crazy spin
    if love.keyboard.isScancodeDown('p') then
        obj.body:setAngularVelocity(20)
    end
end

return keyboard