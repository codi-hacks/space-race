local System = require('lib/system')
local Entity = require('services/entity')
local player = require('entities/player')

return System(
    {'_entity','-isControlled'},
    function(entity, shipNumber)
        -- If a valid ship index is provided
        if shipNumber then

            --Copy of object data
            local object = {
                name = 'player',
                ship_type = shipNumber,
                checkpoints = 0
            }

            -- Copy + Remove existing player entity
            for k,v in ipairs(Entity.list) do
                if v == entity then
                    -- Copy position
                    object.pos_x = v.body:getX()
                    object.pos_y = v.body:getY()
                    -- Copy checkpoints (if any)
                    if v.checkpoints then
                        object.checkpoints = v.checkpoints
                    else
                        object.checkpoints = 0
                    end
                    -- Destroy existing player entity
                    v.body:destroy()
                    v.shape:release()
                    table.remove(Entity.list, k)
                end
            end

            -- Spawn a new one
            Entity.spawn(object, 2)
        end
    end
)
