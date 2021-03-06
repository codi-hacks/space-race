love.physics.setMeter(64)

local begin_contact_callback = function(fixture_a, fixture_b, contact)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()

    -- Walls have no fixtures. We don't care for those.
    if entity_a and entity_b then
        if entity_a.on_begin_contact then entity_a:on_begin_contact(entity_b, contact) end
        if entity_b.on_begin_contact then entity_b:on_begin_contact(entity_a, contact) end
    end
end

local end_contact_callback = function(fixture_a, fixture_b, contact)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()

    if entity_a and entity_b then
        if entity_a.on_end_contact then entity_a:on_end_contact(entity_b, contact) end
        if entity_b.on_end_contact then entity_b:on_end_contact(entity_a, contact) end
    end
end

local pre_solve_callback = function(fixture_a, fixture_b, contact)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()

    if entity_a and entity_b then
        if entity_a.on_pre_solve then entity_a:on_pre_solve(entity_b, contact) end
        if entity_b.on_pre_solve then entity_b:on_pre_solve(entity_a, contact) end
    end
end

return {
    pre_solve_callback = pre_solve_callback,
    end_contact_callback = end_contact_callback,
    begin_contact_callback = begin_contact_callback,

}
