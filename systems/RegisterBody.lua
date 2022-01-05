--- RegisterBody
-- Build entity's box2d body when spawning

local System = require 'lib/system'

local Love = love
local World = require 'services/world'

local components = {
  '=body'
}

local system = function(body, pos_x, pos_y)

  local new_body = Love.physics.newBody(
    World,
    pos_x + (body.offset_x or 0),
    pos_y + (body.offset_y or 0),
    body.type or 'dynamic'
  )
  -- Give it a fixed rotation unless
  -- explicitly set to false.
  if body.fixed_rotation == false then
    new_body:setFixedRotation(false)
  else
    new_body:setFixedRotation(true)
  end
  return new_body
end

return System(components, system)
