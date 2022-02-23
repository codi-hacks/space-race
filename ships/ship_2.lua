
return {
    displayName = 'Ship Two', -- Index 2
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
        image = 'ship_2',
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
        },
    },
    description =   "This small ship boasts three thrusters and leather seats! " ..
                    "Beat your best time in luxurious style",
    speed = 2,
    handling = 1,
    damping_force = 1.65,
    braking_force = 1.25,
    turning_force = 4.0,
    thrust_force = 4.0,
    max_spin = 1.0,
    max_velocity = 550.0,

    -- Describes y coordinate of the last row
    -- Of the actual ship for drawing preview
    bottom_y = 25
}
