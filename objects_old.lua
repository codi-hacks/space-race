objects_old = {}

--objects_old.circle dude
objects_old.circle = {}
objects_old.circle.name = 'circle'
objects_old.circle.size = 25
objects_old.circle.body = love.physics.newBody(world, 100, 300, 'dynamic')
objects_old.circle.shape = love.physics.newCircleShape(objects_old.circle.size)
objects_old.circle.fixture = love.physics.newFixture(objects_old.circle.body, objects_old.circle.shape)
objects_old.circle.fixture:setUserData('CIRCLE')
objects_old.circle.update = function()
    if objects_old.circle.body:getX() < -25 then
        objects_old.circle.body:setX(825)
    elseif objects_old.circle.body:getX() > 825 then
        objects_old.circle.body:setX(-25)
    end
    if objects_old.circle.body:getY() < -25 then
        objects_old.circle.body:setY(625)
    elseif objects_old.circle.body:getY() > 625 then
        objects_old.circle.body:setY(-25)
    end
end
objects_old.circle.end_contact = function(self)
    objects_old.square.body:applyForce(400, 0)
    print('circle bonk')
end
objects_old.circle.draw = function()
    love.graphics.setColor({0, 0, 1, 1})
    love.graphics.circle('line', objects_old.circle.body:getX(), objects_old.circle.body:getY(), objects_old.circle.size)
end

objects_old.bullet = {}
objects_old.bullet.name = 'bullet'
objects_old.bullet.body = love.physics.newBody(world, 100, 200, 'dynamic')
objects_old.bullet.shape = love.physics.newRectangleShape(40, 20)
objects_old.bullet.fixture = love.physics.newFixture(objects_old.bullet.body, objects_old.bullet.shape)
objects_old.bullet.update = function()
    if objects_old.bullet.body:getX() < -25 then
        objects_old.bullet.body:setX(825)
    elseif objects_old.bullet.body:getX() > 825 then
        objects_old.bullet.body:setX(-25)
    end
    if objects_old.bullet.body:getY() < -25 then
        objects_old.bullet.body:setY(625)
    elseif objects_old.bullet.body:getY() > 625 then
        objects_old.bullet.body:setY(-25)
    end
end
objects_old.bullet.draw = function()
    love.graphics.setColor({1, 1, 0, 1})
    love.graphics.polygon('fill', objects_old.bullet.body:getWorldPoints(objects_old.bullet.shape:getPoints()))
end

return objects_old