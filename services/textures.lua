local textures = {}

textures.load = function()
    local i = function(filename)
        return love.graphics.newImage('assets/sprites/' .. filename)
    end
    textures.block1             = i 'block1.png'
    textures.checkpoint         = i 'checkpoint.png'
    textures['checkpoint-gate'] = i 'checkpoint-gate.png'
    textures.spaceship          = i 'ship.png'
    textures.star               = i 'star.png'
    textures.planet             = i 'planet.png'
    textures.speedboost         = i 'speedboost.png'
end

return textures
