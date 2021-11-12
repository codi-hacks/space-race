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
    -- Move object via wasd with force
    local movementForce = 100
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

    -- Fly spaceship!
    bottomx, bottomy = objects.square.body:getWorldPoint(0, 25)
    topx, topy = objects.square.body:getWorldPoint(0, -25)
    ratiox = math.abs(topx/bottomx)
    ratioy = math.abs(topy/bottomy)
    if love.keyboard.isDown('g') then
        if ratioy > 1 then
            obj.body:applyForce(0, ratioy * movementForce)
        elseif ratioy < 1 then
            obj.body:applyForce(0, ratioy * -movementForce)
        end
        if ratiox > 1 then
            obj.body:applyForce(movementForce, 0)
        elseif ratiox < 1 then
            obj.body:applyForce(-movementForce, 0)
        end
    end
    if love.keyboard.isDown('f') then
        obj.body:applyTorque(-movementForce - 500)
    end
    if love.keyboard.isDown('h') then
        obj.body:applyTorque(movementForce + 500)
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