physics_objects = {}

--physics_objects.circle dude
physics_objects.circle = {}
physics_objects.circle.name = 'circle'
physics_objects.circle.size = 25
physics_objects.circle.body = love.physics.newBody(world, 100, 300, 'dynamic')
physics_objects.circle.shape = love.physics.newCircleShape(physics_objects.circle.size)
physics_objects.circle.fixture = love.physics.newFixture(physics_objects.circle.body, physics_objects.circle.shape)
physics_objects.circle.fixture:setUserData('CIRCLE')
physics_objects.circle.update = function()
    if physics_objects.circle.body:getX() < -25 then
        physics_objects.circle.body:setX(825)
    elseif physics_objects.circle.body:getX() > 825 then
        physics_objects.circle.body:setX(-25)
    end
    if physics_objects.circle.body:getY() < -25 then
        physics_objects.circle.body:setY(625)
    elseif physics_objects.circle.body:getY() > 625 then
        physics_objects.circle.body:setY(-25)
    end
end
physics_objects.circle.end_contact = function(self)
    physics_objects.square.body:applyForce(400, 0)
    print('circle bonk')
end
physics_objects.circle.draw = function()
    love.graphics.setColor({0, 0, 1, 1})
    love.graphics.circle('line', physics_objects.circle.body:getX(), physics_objects.circle.body:getY(), physics_objects.circle.size)
end

physics_objects.bullet = {}
physics_objects.bullet.name = 'bullet'
physics_objects.bullet.body = love.physics.newBody(world, 100, 200, 'dynamic')
physics_objects.bullet.shape = love.physics.newRectangleShape(40, 20)
physics_objects.bullet.fixture = love.physics.newFixture(physics_objects.bullet.body, physics_objects.bullet.shape)
physics_objects.bullet.update = function()
    if physics_objects.bullet.body:getX() < -25 then
        physics_objects.bullet.body:setX(825)
    elseif physics_objects.bullet.body:getX() > 825 then
        physics_objects.bullet.body:setX(-25)
    end
    if physics_objects.bullet.body:getY() < -25 then
        physics_objects.bullet.body:setY(625)
    elseif physics_objects.bullet.body:getY() > 625 then
        physics_objects.bullet.body:setY(-25)
    end
end
physics_objects.bullet.draw = function()
    love.graphics.setColor({1, 1, 0, 1})
    love.graphics.polygon('fill', physics_objects.bullet.body:getWorldPoints(physics_objects.bullet.shape:getPoints()))
end

return physics_objects