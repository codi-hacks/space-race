--- DrawEntity
-- Draw currently-visible entities on screen.

local System = require 'lib/system'
local State = require 'services/state'

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
        local offset_x = sprite.offset_x or spritesheet.offset_x or 0
        local offset_y = sprite.offset_y or spritesheet.offset_y or offset_x
        sprite:draw(
            spritesheet.image,
            body:getX(),
            body:getY(),
            body:getAngle(),
            spritesheet.scale_x or 1,
            spritesheet.scale_y or spritesheet.scale_x or 1,
            offset_x,
            offset_y
        )
    end

    -- Draw fixture shape edges in debug mode
    if shape and State.debugOn then
        love.graphics.setColor(160, 72, 14, 255)

        if shape:getType() == 'polygon' then
            love.graphics.polygon(
                'line',
                body:getWorldPoints(shape:getPoints())
            )
        else
            if gravitational_mass then
                love.graphics.setColor(gravitational_mass / 10, 0.1, 0.1, 1)
            end
            love.graphics.circle(
                'fill',
                body:getX(),
                body:getY(),
                shape:getRadius()
            )
        end

        love.graphics.setColor(255, 255, 255, 255)
    end
end

return System(components, system)
