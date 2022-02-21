return {
    displayName = 'Purple', -- Index 6
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
        image = 'ship_purple',
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
    description = "Can the best color help you get the best time?",
    speed = 3,
    handling = 3,
    damping_force = 0.55,
    braking_force = 1.15,
    turning_force = 4.0,
    thrust_force = 2.1,
    max_spin = 1.0,
    max_velocity = 870.0
}
