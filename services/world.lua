love.physics.setMeter(64)

local end_contact_callback = function(fixture_a, fixture_b, contact)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()

    -- Walls have no fixtures. We don't care for those.
    if entity_a and entity_b then
        if entity_a.on_end_contact then entity_a:on_end_contact(entity_b, contact) end
        if entity_b.on_end_contact then entity_b:on_end_contact(entity_a, contact) end
    end
end

local pre_solve_callback = function(fixture_a, fixture_b, contact)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()

    -- Walls have no fixtures. We don't care for those.
    if entity_a and entity_b then
        if entity_a.on_pre_solve then entity_a:on_pre_solve(entity_b, contact) end
        if entity_b.on_pre_solve then entity_b:on_pre_solve(entity_a, contact) end
    end
end

local world = love.physics.newWorld(0, 0)

world:setCallbacks(nil, end_contact_callback, pre_solve_callback, nil)

return world
