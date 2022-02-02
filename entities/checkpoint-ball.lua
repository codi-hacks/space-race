return function(props)
    local CompleteLevel = require 'systems/CompleteLevel'

    local default_radius = 32

    return {
        body = {
            type = 'static'
        },
        fixture = {
            category = 1,
            mask = 65535
        },
        on_begin_contact = function(_, entity_b)
            CompleteLevel(entity_b)
        end,
        shape = {
            radius = props.radius or default_radius,
            type = 'circle',
            visible = true
        },
        spritesheet = {
            image = 'checkpoint-ball',
            offset_x = (props.radius or default_radius) / 2,
            scale_x = (props.radius or default_radius) * 2 / 32
        }
    }
end
