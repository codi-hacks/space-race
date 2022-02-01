local textures = {}

textures.load = function()
    textures.spaceship = love.graphics.newImage("/assets/sprites/ship.png")
    textures.star = love.graphics.newImage("/assets/sprites/star.png")
    textures.planet = love.graphics.newImage('assets/sprites/planet.png')

    -- Wyatt's Beautiful spedboost
    textures.speedboost = love.graphics.newImage('assets/sprites/speedboost.png')

     -- Assorted spaceships by Jon
     textures.ship_spaceship_2 = love.graphics.newImage('/assets/sprites/ship_ship_2.png')
     textures.ship_shuttle = love.graphics.newImage('/assets/sprites/ship_shuttle.png')
     textures.ship_shuttle_no_boosters = love.graphics.newImage('/assets/sprites/ship_shuttle_no_boosters.png')
     textures.ship_ufo = love.graphics.newImage('/assets/sprites/ship_ufo.png')
     textures.not_stolen = love.graphics.newImage('/assets/sprites/not_stolen.png')
     textures.ship_purple = love.graphics.newImage('/assets/sprites/ship_purple.png')

end

return textures