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
        gravitational_mass = 5,
        shape = {
            radius = props.radius or 100,
            type = 'circle',
            visible = true
        }
    }
end
