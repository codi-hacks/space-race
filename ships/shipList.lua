--[[
    This is a table of all ships available
    All ships have a:
    displayName - The display name of the ship.
    filename - The filename of the ship sprite
    shape with:
        points
        type
    spritesheet with:
        image
        offset_x
        scale_x
    description - A string that describes anyhing interesting about the ship
    speed - Force modifier value for acceleration
    handling - Force modifer value for turning, braking, etc...

        - J.R.C 2/1/22
]]
return {
    [1] = {
        displayName = 'Trevor\'s OG Ship', -- Index 1
        filename = 'ship',
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
        },
        description = "Big T's ORIGINAL ship! Nothing beats the classics",
        speed = 1,
        handling = 1
    },
    [2] = {
        displayName = 'Ship Two', -- Index 2
        filename = 'ship_2',
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
            scale_x = 2
        },
        description =   "This small ship boasts three thrusters and leather seats! " ..
                        "Beat your best time in luxurious style",
        speed = 2,
        handling = 1
    },
    [3] = {
        displayName = 'UFO', -- Index 3
        filename = 'ship_ufo',
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
            scale_x = 2
        },
        description = "This ship is out of this world! *X-files theme music intensifies*",
        speed = 2,
        handling = 2
    },
    [4] = {
        displayName = 'Shuttle Rocket', -- Index 4
        filename = 'ship_shuttle',
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
            scale_x = 2
        },
        description =   "The space shuttle has boosters engaged for insane speed. " ..
                        "Blaassssttt off! ",
        speed = 4,
        handling = 1
    },
    [5] = {
        displayName = 'Shuttle', -- Index 5
        filename = 'ship_shuttle_2',
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
            scale_x = 2
        },
        description =   "The boosters have disengaged from the space shuttle. " ..
                        "Speed has been sacrificed for a major improvement to the handling stats.",
        speed = 1,
        handling = 3
    },
    [6] = {
        displayName = 'Purple', -- Index 6
        filename = 'ship_purple',
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
            scale_x = 1
        },
        description = "Can the best color help you get the best time?",
        speed = 3,
        handling = 3
    },
    [7] = {
        displayName = 'Green', -- Index 7
        filename = 'ship_green',
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
            scale_x = 1
        },
        description = "Make the competition GREEN with envy",
        speed = 3,
        handling = 3
    },
    [8] = {
        displayName = 'Big One', -- Index 8
        filename = 'ship_big',
        shape = {
            points = {
                0, -45,
                -32, 32,
                -32, 32,
                32, 32,
                32, 32
            },
            type = 'polygon'
        },
        spritesheet = {
            image = 'ship_big',
            offset_x = 32,
            scale_x = 1
        },
        description =   "The biggest ship in the fleet! " ..
                        "It takes a master vessel commander to handle one THIS big!",
        speed = 0.5,
        handling = 4
    }
}
