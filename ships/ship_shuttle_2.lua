return {
    displayName = 'Shuttle', -- Index 5
    shape = {
        points = {
            0, -32,
            -15, 15,
            -15, 32,
            15, 15,
            15, 32
        },
        type = 'polygon'
    },
    spritesheet = {
        image = 'ship_shuttle_2',
        offset_x = 16,
        scale_x = 2,
        width = 32,
        actions = {
            default = {
                frames = { 1, 1 }
            },
            thrust_front = {
                frames = { 1, 1 }
            },
        }
    },
    description =   "The boosters have disengaged from the space shuttle. " ..
                    "Speed has been sacrificed for a major improvement to the handling stats.",
    speed = 1,
    handling = 3,
    damping_force = 0.55,
    braking_force = 1.15,
    turning_force = 3.0,
    thrust_force = 4.0,
    max_spin = 5.0,
    max_velocity = 450.0
}
