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
                frames = { 1, 1 }
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
    max_velocity = 900.0
}
