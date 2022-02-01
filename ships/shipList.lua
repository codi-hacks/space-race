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
    { 
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
    {
        displayName = 'Ship Two', -- Index 2
        filename = 'ship_spaceship_2',
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
            image = 'ship_spaceship_2',
            offset_x = 12.5,
            scale_x = 2
        }
    },
    {
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
    {
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
    {
        displayName = 'Shuttle', -- Index 5
        filename = 'ship_shuttle_no_boosters',
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
            image = 'ship_shuttle_no_boosters',
            offset_x = 16,
            scale_x = 2
        }
    },
    {
        displayName = 'Stolen', -- Index 5
        filename = 'not_stolen',
        shape = {
            points = {
                -50, -80,
                50, -80,
                -75, 0,
                -75, 40,
                75, 0,
                75, 40
            },
            type = 'polygon'
        },
        spritesheet = {
            image = 'not_stolen',
            offset_x = 75,
            scale_x = 1
        }
    },
    {
        displayName = 'Purple', -- Index 5
        filename = 'ship_purple',
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
            image = 'ship_purple',
            offset_x = 16,
            scale_x = 1
        }
    }
}
