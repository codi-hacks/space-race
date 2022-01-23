return function(props)
    return {
        body = {
            mass = 75,
            type = 'static'
        },
        fixture = {
            category = 1,
            density = 10,
            friction = 0,
            mask = 65535
        },
        gravitational_mass = 500,
        spritesheet = {
            image = 'planet',
            offset_x = 16,
            scale_x = (props.radius or 64) * 2 / 32
        },
        shape = {
            radius = props.radius or 64,
            type = 'circle',
            visible = true
        }
    }
end
