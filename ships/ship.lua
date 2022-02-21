return{
    displayName = 'Trevor\'s OG Ship', -- Index 1
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
        scale_x = 2,
        width = 25,
        actions = {
            default = {
                frames = { 1, 1 }
            },
            thrust_front = {
                frames = { 1, 1 }
            },
        }
    },
    description = "Big T's ORIGINAL ship! Nothing beats the classics",
    speed = 1,
    handling = 1,
    damping_force = 0.00,
    braking_force = 1.00,
    turning_force = 1.0,
    thrust_force = 1.0,
    max_spin = 15.0,
    max_velocity = 5500.0
}

