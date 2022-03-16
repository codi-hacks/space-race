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

    -- Render culling - J.R.C 3/16/22
    local cull_entity = false
    if shape then
        local low_x, high_x
        local low_y, high_y
        -- If entity is a polygon
        if shape:getType() == 'polygon' then
            local cull_points = {body:getWorldPoints(shape:getPoints())}
            -- Find min and max on each axis
            for i, v in pairs(cull_points) do
               if i == 1 then
                low_x = v
                high_x = v
               elseif i == 2 then
                low_y = v
                high_y = v
               else
                -- If it's an x coordinate
                if i % 2 == 1 then
                    if v < low_x then
                        low_x = v
                    end
                    if v > high_x then
                        high_x = v
                    end
                -- If it's a y coordinate
                else
                    if v < low_y then
                        low_y = v
                    end
                    if v > high_y then
                        high_y = v
                    end
                end
               end
            end

            -- Check if min and max are on screen
            if(
                low_x > State.camera.pos_x + State.camera.window_width or
                high_x < State.camera.pos_x or
                high_y < State.camera.pos_y or
                low_y > State.camera.pos_y + State.camera.window_height
            ) then
                cull_entity = true
            end

        -- If entity is a circle
        else
            local bx, by = body:getWorldPoints(shape:getPoint())
            local r = shape:getRadius()

            if(
                bx + r <  State.camera.pos_x or
                bx - r > State.camera.pos_x + State.camera.window_width or
                by - r >  State.camera.pos_y + State.camera.window_height or
                by + r < State.camera.pos_y
            )then
                cull_entity = true
            end

        end
    end

    if not cull_entity then
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
end

return System(components, system)
