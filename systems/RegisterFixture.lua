--- RegisterFixture
-- Build entity's box2d fixture when spawning

local System = require 'lib/system'

local components = {
    '_entity',
    'body',
    '=fixture',
    'shape'
}

local system = function(entity, body, fixture, shape)
    local loaded_fixture = love.physics.newFixture(body, shape)
    if fixture.density then
        loaded_fixture:setDensity(fixture.density)
    end
    if fixture.friction then
        loaded_fixture:setFriction(fixture.friction)
    end
    if fixture.restitution then
        loaded_fixture:setRestitution(fixture.restitution)
    end

    loaded_fixture:setFilterData(
        fixture.category or 0,
        fixture.mask or 0,
        0
    )

    -- Give the fixture context of the entity it belongs to so
    -- we can extract this information in the event of a collision
    loaded_fixture:setUserData(entity)

    return loaded_fixture
end

return System(components, system)
