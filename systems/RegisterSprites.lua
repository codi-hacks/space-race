--- RegisterSprites
-- Load graphics for spawning sprites

local System = require 'lib/system'

local Textures = require 'services/textures'

local components = {
  '_entity',
  'sprites'
}

local system = function(entity, sprites)
  assert(Textures[sprites], 'Attempted to load undefined sprite: "' .. sprites .. '"')

  entity.sprite = Textures[sprites]
end

return System(components, system)
