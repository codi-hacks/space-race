--local sounds = require 'services/sounds'

return function()
    return {
        body = {
            mass = 1
        },
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
        shape = {
            points = {
                0, -25,
                -25, 2,
                -25, 25,
                25, 2,
                25, 25
            },
            type = 'polygon'
        },
        spritesheet = {
            image = 'spaceship',
            offset_x = 12.5,
            scale_x = 2
        }
    }
end
