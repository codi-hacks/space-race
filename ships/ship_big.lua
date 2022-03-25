return {
    displayName = 'Big One', -- Index 8
    shape = {
        points = {
            0, -40,
            -32, 26,
            -32, 26,
            32, 26,
            32, 26
        },
        type = 'polygon'
    },
    spritesheet = {
        image = 'ship_big',
        offset_x = 32,
        offset_y = 34,
        scale_x = 1,
        width = 64,
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
    description =   "The biggest ship in the fleet! " ..
                    "It takes a master vessel commander to handle one THIS big!",
    speed = 0.5,
    handling = 4,
    damping_force = 1.5,
    braking_force = 1.15,
    turning_force = 8.0,
    thrust_force = 8.0,
    max_spin = 5.0,
    max_velocity = 350.0,

    price = 200,

    -- Describes y coordinate of the last row
    -- Of the actual ship for drawing preview
    bottom_y = 64
}
