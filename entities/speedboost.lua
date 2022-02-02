return function()
    return {
        body = {
            type = 'static'
        },
        fixture = {
            category = 1,
            mask = 65535
        },
        on_begin_contact = function(_, entity_b)
            if entity_b.isControlled then
                entity_b.powerUps.speedBoost = { value = 100, time = 100 };
            end
        end,
        on_pre_solve = function(_, _, contact)
            contact:setEnabled(false)
        end,
        shape = {
            type = 'rectangle',
            width =32,
            height=32,
            offset_x =16,
            offset_y=16
        },
        spritesheet = {
            image = 'speedboost',
        }
    }
end
