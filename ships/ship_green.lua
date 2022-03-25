return {
    displayName = 'Green', -- Index 7
    shape = {
        points = {
            0, -26,
            -15, 15,
            -15, 16,
            15, 15,
            15, 16
        },
        type = 'polygon'
    },
    spritesheet = {
        image = 'ship_green',
        offset_x = 16,
        scale_x = 1,
        width = 32,
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
    description = "Make the competition GREEN with envy",
    speed = 3,
    handling = 3,
    damping_force = 0.55,
    braking_force = 1.15,
    turning_force = 4.0,
    thrust_force = 2.0,
    max_spin = 1.0,
    max_velocity = 850.0,

    price = 650,
    -- Describes y coordinate of the last row
    -- Of the actual ship for drawing preview
    bottom_y = 32
}
