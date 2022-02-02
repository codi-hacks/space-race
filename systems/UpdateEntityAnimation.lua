--- UpdateEntityAnimation
-- Update entity sprites to the right frame

local System = require 'lib/system'

local components = {
    '=sprite'
}

local system = function(sprite, dt)
    sprite:update(dt)
    return sprite
end

return System(components, system)
