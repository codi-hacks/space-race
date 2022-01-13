--- RegisterSprites
-- Load graphics for spawning sprites

local System = require 'lib/system'

local Textures = require 'services/textures'

local components = {
    '_entity',
    'spritesheet'
}

local system = function(entity, spritesheet)
    assert(Textures[spritesheet.image], 'Attempted to load undefined sprite: "' .. spritesheet.image .. '"')

    entity.sprite = Textures[spritesheet.image]
end

return System(components, system)
