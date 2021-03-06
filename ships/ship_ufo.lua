return {
    displayName = 'UFO', -- Index 3
    shape = {
        points = {
            0, -25,
            -25, 2,
            -25, 15,
            25, 2,
            25, 15
        },
        type = 'polygon'
    },
    spritesheet = {
        image = 'ship_ufo',
        offset_x = 12.5,
        scale_x = 2,
        width = 25,
        actions = {
            default = {
                frames = { 1, 1 }
            },
            thrust_front = {
                duration = 0.05,
                frames = { '1-3', 1},
                on_loop = function(animation)
                    animation:gotoFrame(2)
                end
            },
        }
    },
    description = "This ship is out of this world! *X-files theme music intensifies*",
    speed = 2,
    handling = 2,
    damping_force = 4.85,
    braking_force = 1.15,
    turning_force = 15.0,
    thrust_force = 4.0,
    max_spin = 5.0,
    max_velocity = 900.0,

    price = 1000,

    -- Describes y coordinate of the last row
    -- Of the actual ship for drawing preview
    bottom_y = 25
}
