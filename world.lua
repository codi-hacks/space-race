love.physics.setMeter(64)

--[[local end_contact_callback = function(fixture_a, fixture_b, contact)
  local entity_a = fixture_a:getUserData()
  local entity_b = fixture_b:getUserData()
  if entity_a.end_contact then entity_a:end_contact() end
  if entity_b.end_contact then entity_b:end_contact() end
end
]]--
world = love.physics.newWorld(0, 0)

world:setCallbacks(nil, nil, nil, nil)

return world