--- RegisterBody
-- Build entity's box2d body when spawning

local System = require 'lib/system'

local State = require 'services/state'

local components = {
    '=body'
}

local system = function(body, pos_x, pos_y, rotation)
    local new_body = love.physics.newBody(
        State.world,
        pos_x + (body.offset_x or 0),
        pos_y + (body.offset_y or 0),
        body.type or 'dynamic'
    )

    new_body:setAngle(rotation or 0)

    -- By default, don't allow entities to rotate
    if body.fixed_rotation == true then
        new_body:setFixedRotation(true)
    else
        new_body:setFixedRotation(false)
    end

    return new_body
end

return System(components, system)
