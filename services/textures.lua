local textures = {}

textures.load = function()
    textures.spaceship = love.graphics.newImage("/assets/sprites/ship.png") -- Ship Index 1 J.R.C 2/1/22
    textures.star = love.graphics.newImage("/assets/sprites/star.png")
    textures.planet = love.graphics.newImage('assets/sprites/planet.png')

    -- Wyatt's Beautiful spedboost
    textures.speedboost = love.graphics.newImage('assets/sprites/speedboost.png')

     -- Assorted spaceships by Jon
     textures.ship_spaceship_2 = love.graphics.newImage('/assets/sprites/ship_ship_2.png')-- Ship Index 2 J.R.C 2/1/22
     textures.ship_ufo = love.graphics.newImage('/assets/sprites/ship_ufo.png') -- Ship Index 3 J.R.C 2/1/22
     textures.ship_shuttle = love.graphics.newImage('/assets/sprites/ship_shuttle.png') -- Ship Index 4 J.R.C 2/1/22
     textures.ship_shuttle_no_boosters = love.graphics.newImage('/assets/sprites/ship_shuttle_no_boosters.png') -- Ship Index 5 J.R.C 2/1/22
     textures.ship_purple = love.graphics.newImage('/assets/sprites/ship_purple.png') -- Ship Index 6 J.R.C 2/1/22

end

return textures