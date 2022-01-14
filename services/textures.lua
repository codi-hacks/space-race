local textures = {}

textures.load = function()
    textures.spaceship = love.graphics.newImage("/assets/sprites/ship.png")
    textures.star = love.graphics.newImage("/assets/sprites/star.png")
    textures.planet = love.graphics.newImage('assets/sprites/planet.png')
end

return textures
