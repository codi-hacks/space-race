physics_objects = {}

--physics_objects.circle dude
physics_objects.circle = {}
physics_objects.circle.name = 'circle'
physics_objects.circle.size = 25
physics_objects.circle.position = {x = 500, y = 400}
physics_objects.circle.mass = 75
physics_objects.circle.body = love.physics.newBody(world, 0, 0, 'static')
physics_objects.circle.shape = love.physics.newCircleShape(physics_objects.circle.size)
physics_objects.circle.fixture = love.physics.newFixture(physics_objects.circle.body, physics_objects.circle.shape)
physics_objects.circle.fixture:setUserData('CIRCLE')
physics_objects.circle.update = nil
physics_objects.circle.body:setMass(physics_objects.circle.mass)
physics_objects.circle.end_contact = function(self)
    physics_objects.square.body:applyForce(400, 0)
    print('circle bonk')
end
physics_objects.circle.draw = function()
    love.graphics.setColor({0, 0, 1, 1})
    love.graphics.circle('line', physics_objects.circle.body:getX(), physics_objects.circle.body:getY(), physics_objects.circle.size)
end

--physics_objects.circle dude
physics_objects.circle2 = {}
physics_objects.circle2.name = 'circle2'
physics_objects.circle2.size = 25
physics_objects.circle2.position = {x = 200, y = 700}
physics_objects.circle2.mass = 25
physics_objects.circle2.body = love.physics.newBody(world, 0, 0, 'static')
physics_objects.circle2.shape = love.physics.newCircleShape(physics_objects.circle2.size)
physics_objects.circle2.fixture = love.physics.newFixture(physics_objects.circle2.body, physics_objects.circle2.shape)
physics_objects.circle2.fixture:setUserData('CIRCLE2')
physics_objects.circle2.update = nil
physics_objects.circle2.body:setMass(physics_objects.circle2.mass)
physics_objects.circle2.end_contact = function(self)
    physics_objects.square.body:applyForce(400, 0)
    print('circle2 bonk')
end
physics_objects.circle2.draw = function()
    love.graphics.setColor({0.8, 0, 0.6, 1})
    love.graphics.circle('line', physics_objects.circle2.body:getX(), physics_objects.circle2.body:getY(), physics_objects.circle2.size)
end

physics_objects.bullet = {}
physics_objects.bullet.name = 'bullet'
physics_objects.bullet.position = {x = 100, y = 200}
physics_objects.bullet.mass = 0.01
physics_objects.bullet.body = love.physics.newBody(world, 0, 0, 'dynamic')
physics_objects.bullet.shape = love.physics.newRectangleShape(40, 20)
physics_objects.bullet.fixture = love.physics.newFixture(physics_objects.bullet.body, physics_objects.bullet.shape)
physics_objects.bullet.update = nil
physics_objects.bullet.draw = function()
    love.graphics.setColor({1, 1, 0, 1})
    love.graphics.polygon('fill', physics_objects.bullet.body:getWorldPoints(physics_objects.bullet.shape:getPoints()))
end

return physics_objects