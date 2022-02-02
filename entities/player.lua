--local sounds = require 'services/sounds'

return function(props)
    return {
        body = {
            mass = 1
        },
        checkpoints = tonumber(props.checkpoints),
        fixture = {
            category = 1,
            density = 10,
            friction = 0,
            mask = 65535
        },
        on_end_contact = function()
            -- Extremely useful and essential sound effect
            -- TODO: fix this so it only bonks when we expect it to
            --love.audio.play(sounds.bonk)
        end,
        powerUps={

        },
        gravitational_mass = 1,
        isControlled = true,
        shape = ship.shape,
        spritesheet = ship.spritesheet
    }
end
