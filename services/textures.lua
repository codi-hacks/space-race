local textures = {}

textures.load = function()
    local i = function(filename)
        return love.graphics.newImage('assets/sprites/' .. filename)
    end
    textures.block1             = i 'block1.png'
    textures.checkpoint         = i 'checkpoint.png'
    textures['checkpoint-ball'] = i 'checkpoint-ball.png'
    textures['checkpoint-gate'] = i 'checkpoint-gate.png'
    textures.spaceship          = i 'ship.png'
    textures.star               = i 'star.png'
    textures.planet             = i 'planet.png'
    textures.speedboost         = i 'speedboost.png'

    -- Assorted spaceships by Jon
    textures.ship_2             = i 'ship_2.png'                -- Ship Index 2
    textures.ship_ufo           = i 'ship_ufo.png'              -- Ship Index 3
    textures.ship_shuttle       = i 'ship_shuttle.png'          -- Ship Index 4
    textures.ship_shuttle_2     = i 'ship_shuttle_2.png'        -- Ship Index 5
    textures.ship_purple        = i 'ship_purple_legacy.png'    -- Ship Index 6
    textures.ship_green         = i 'ship_green.png'            -- Ship Index 7
    textures.ship_big           = i 'ship_big.png'              -- Ship Index 8
end

return textures
