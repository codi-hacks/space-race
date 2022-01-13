--- RegisterShape
-- Build entity's box2d shape when spawning

local System = require 'lib/system'

local Love = love

local components = {
    '=shape'
}

local system = function(shape)
    assert(
        shape.type ~= nil,
        'Entity has no shape type.'
    )

    local new_shape
    if shape.type == 'rectangle' then
        new_shape = Love.physics.newRectangleShape(
            shape.offset_x or 0,
            shape.offset_y or 0,
            shape.width,
            shape.height
        )
    elseif shape.type == 'circle' then
        new_shape = Love.physics.newCircleShape(
            shape.offset_x or 0,
            shape.offset_y or 0,
            shape.radius
        )
    else
        new_shape = Love.physics.newPolygonShape(shape.points)
    end

    return new_shape
end

return System(components, system)
