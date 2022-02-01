local textures = {}

textures.load = function()
    textures.spaceship = love.graphics.newImage("/assets/sprites/ship.png")
    textures.star = love.graphics.newImage("/assets/sprites/star.png")
    textures.planet = love.graphics.newImage('assets/sprites/planet.png')

    -- Assorted spaceships by Jon
    textures.spaceship2 = love.graphics.newImage('/assets/sprites/ship2.png')
    textures.shuttle = love.graphics.newImage('/assets/sprites/shuttle.png')
    textures.shuttle_no_boosters = love.graphics.newImage('/assets/sprites/shuttle_no_boosters.png')
    textures.ufo = love.graphics.newImage('/assets/sprites/shuttle_no_boosters.png')
end

return textures
