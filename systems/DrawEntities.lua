--- DrawEntity
-- Draw currently-visible entities on screen.

local Love = love
local System = require 'lib/system'
local state = require 'state'

local components = {
  'body',
  'draw_layer',
  '?shape',
  '?sprite',
  '?spritesheet',
  '?gravitational_mass'
}

local system = function(body, draw_layer, shape, sprite, spritesheet, gravitational_mass, layer_idx)
  -- Don't draw the entity unless it belongs to the
  -- layer from which this system was invoked.
  if draw_layer ~= layer_idx then
    return
  end

  if spritesheet then
    Love.graphics.draw(
        sprite,
        body:getX(),
        body:getY(),
        body:getAngle(),
        spritesheet.scale_x or 1,
        spritesheet.scale_y or spritesheet.scale_x or 1,
        spritesheet.offset_x or 0,
        spritesheet.offset_y or spritesheet.offset_x or 0
    )
  end

  -- Draw fixture shape edges in debug mode
  if shape and state.debugOn then
    Love.graphics.setColor(160, 72, 14, 255)
    if shape:getType() == 'polygon' then
      Love.graphics.polygon(
      'line',
      body:getWorldPoints(shape:getPoints())
      )
    else
        if gravitational_mass then
            Love.graphics.setColor(gravitational_mass / 10, 0.1, 0.1, 1)
        end
        Love.graphics.circle(
            'fill',
            body:getX(),
            body:getY(),
            shape:getRadius()
        )
    end
    Love.graphics.setColor(255, 255, 255, 255)
  end
end

return System(components, system)
