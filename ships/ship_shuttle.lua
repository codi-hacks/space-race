return {
    displayName = 'Shuttle Rocket', -- Index 4
    shape = {
        points = {
            0, -32,
            -15, -15,
            -15, 32,
            15, -15,
            15, 32
        },
        type = 'polygon'
    },
    spritesheet = {
        image = 'ship_shuttle',
        offset_x = 16,
        scale_x = 2,
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
    description =   "The space shuttle has boosters engaged for insane speed. " ..
                    "Blaassssttt off! ",
    speed = 4,
    handling = 1,
    damping_force = 0.15,
    braking_force = 1.15,
    turning_force = 2.0,
    thrust_force = 7.0,
    max_spin = 5.0,
    max_velocity = 1050.0,

    -- Describes y coordinate of the last row
    -- Of the actual ship for drawing preview
    bottom_y = 32
}
