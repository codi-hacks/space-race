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
        }
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
        }
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
        }
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
        }
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
        }
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
        }
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
        }
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
        }
    }
}
