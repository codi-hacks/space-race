require('player')

objects = {}

local keepThingsOnScreen = function(self)
    if self.body:getX() < -25 then
        self.body:setX(825)
    elseif self.body:getX() > 825 then
        self.body:setX(-25)
    end
    if self.body:getY() < -25 then
        self.body:setY(625)
    elseif self.body:getY() > 625 then
        self.body:setY(-25)
    end
end

objects.player = player
objects.square = player

--objects.circle dude
objects.circle = {}
objects.circle.size = 25
objects.circle.body = love.physics.newBody(world, 100, 300, 'dynamic')
objects.circle.shape = love.physics.newCircleShape(objects.circle.size)
objects.circle.fixture = love.physics.newFixture(objects.circle.body, objects.circle.shape)
objects.circle.fixture:setUserData('CIRCLE')
objects.circle.update = keepThingsOnScreen
objects.circle.end_contact = function(self)
    objects.square.body:applyForce(400, 0)
    print('circle bonk')
end

objects.bullet = {}
objects.bullet.body = love.physics.newBody(world, 100, 200, 'dynamic')
objects.bullet.shape = love.physics.newRectangleShape(40, 20)
objects.bullet.fixture = love.physics.newFixture(objects.bullet.body, objects.bullet.shape)
objects.bullet.update = keepThingsOnScreen


return objects