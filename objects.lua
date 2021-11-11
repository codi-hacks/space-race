objects = {}

-- objects.square dude
objects.square = {}
objects.square.size = 25
objects.square.body = love.physics.newBody(world, 250, 200, 'dynamic')
objects.square.shape = love.physics.newRectangleShape(objects.square.size * 2, objects.square.size * 2)
objects.square.fixture = love.physics.newFixture(objects.square.body, objects.square.shape)
objects.square.fixture:setRestitution(0.5)
objects.square.fixture:setUserData('SQUARE')
objects.square.end_contact = function(self)
    objects.square.body:applyForce(400, 0)
    print('square bonk')
end

--objects.circle dude
objects.circle = {}
objects.circle.size = 25
objects.circle.body = love.physics.newBody(world, 300, 300, 'dynamic')
objects.circle.shape = love.physics.newCircleShape(objects.circle.size)
objects.circle.fixture = love.physics.newFixture(objects.circle.body, objects.circle.shape)
objects.circle.fixture:setUserData('CIRCLE')
objects.circle.end_contact = function(self)
    objects.square.body:applyForce(400, 0)
    print('circle bonk')
end

--objects.ground dude
objects.ground = {}
objects.ground.body = love.physics.newBody(world, 800/2, 600-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
objects.ground.shape = love.physics.newRectangleShape(800, 50) --make a rectangle with a width of 650 and a height of 50
objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape) --attach shape to body
objects.ground.fixture:setUserData('GROUND')
objects.ground.end_contact = function(self)
    objects.square.body:applyForce(400, 0)
    print('ground bonk')
end

return objects