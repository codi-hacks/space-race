local System = require('lib/system')

return System(
    {'_entity','-isControlled'},
    function(entity)
        local body = entity.body;

        -- Dampen Velocity Vars
        local vel_x, vel_y = body:getLinearVelocity()
        local targetAngle = body:getAngle() % (math.pi * 2)
        local velocityAngle = math.atan2(vel_y, vel_x)

        -- Normalize radians to unit circle 0 - 2PI
        if velocityAngle >= -math.pi/2 then
            velocityAngle = velocityAngle + math.pi / 2
        else
            velocityAngle = velocityAngle + math.pi * 2 + math.pi / 2
        end

        -- Get x and y components of the target angle
        local target_x = math.cos(targetAngle)
        local target_y = math.sin(targetAngle)

        -- Get the x and y components of the difference
        local dif_x = target_x - vel_x
        local dif_y = target_y - vel_y

        local abs_dif = math.abs(targetAngle - velocityAngle) * (180/math.pi)

        if  abs_dif >= 10  then
            -- Change force based on how much of a difference
            -- Between player angle and velocity angle

            local mod = abs_dif / 360

            body:applyForce(dif_x * mod * entity.damping_force , dif_y * mod * entity.damping_force)
        end

        -- Also correct over-spin
        local angular_velocity = body:getAngularVelocity()

        if math.abs(angular_velocity) > entity.max_spin then
            if angular_velocity > 1 then
                body:applyTorque((angular_velocity-entity.max_spin)*2)
            else
                body:applyTorque((angular_velocity-entity.max_spin)*2)
            end
        end
    end

)
