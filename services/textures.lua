textures = {}

textures.load = function()
    textures.spaceship = love.graphics.newImage("/assets/sprites/ship.png")
    textures.star = love.graphics.newImage("/assets/sprites/star.png")
end

return textures
