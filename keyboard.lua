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
    --optional debug button
    if love.keyboard.isDown('p') then
        obj.body:setAngularVelocity(20)
    end
    local movementForce = 100

    local topx, topy = objects.square.body:getWorldPoint(0, -25)
    local ratiox = (topx - obj.body:getX()) * 0.04
    local ratioy = (topy - obj.body:getY()) * 0.04

    -- Fly spaceship!
    if love.keyboard.isDown('t') then
        obj.body:applyForce(ratiox * movementForce, ratioy * movementForce)
    end
    if love.keyboard.isDown('g') then
        obj.body:applyForce(ratiox * movementForce * -0.25, ratioy * movementForce * -0.25)
    end
    local angVel = player.body:getAngularVelocity()
    local maxAngVel = 2
    if angVel > -maxAngVel and angVel < maxAngVel then
        if love.keyboard.isDown('f') then
            obj.body:applyTorque(-600)
        end
        if love.keyboard.isDown('h') then
            obj.body:applyTorque(600)
        end
    end

    -- Move object via wasd with force
    if love.keyboard.isDown('w') then
        obj.body:applyForce(0, -movementForce)
    end
    if love.keyboard.isDown('s') then
        obj.body:applyForce(0, movementForce)
    end
    if love.keyboard.isDown('d') then
        obj.body:applyForce(movementForce, 0)
    end
    if love.keyboard.isDown('a') then
        obj.body:applyForce(-movementForce, 0)
    end

    -- Move using arrow keys (while holding shift) with "teleportation".
    -- A.K.A. adjusting the x/y of an object.
    -- This block is completely optional (and was left in because it may be useful during development)
    if love.keyboard.isDown('lshift') then
        obj.body:setLinearVelocity(0, 0)
        obj.body:setAngularVelocity(0)
        local movespeed = 200
        local xpos = obj.body:getX()
        local ypos = obj.body:getY()
        if love.keyboard.isDown('up') then
            ypos = ypos - time * movespeed
        end
        if love.keyboard.isDown('down') then
            ypos = ypos + time * movespeed
        end
        if love.keyboard.isDown('left') then
            xpos = xpos - time * movespeed
        end
        if love.keyboard.isDown('right') then
            xpos = xpos + time * movespeed
        end

        obj.body:setX(xpos)
        obj.body:setY(ypos)
    end
end

return keyboard