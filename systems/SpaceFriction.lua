local System = require('lib/system')

return System(
    {'_entity','-isControlled'},
    function(entity, dt)
        local body = entity.body;
        local time = dt * 35 -- Time adjustment for frame independence
        -- If the player isn't holding down free drift
        if entity.drift_key == false then
            -- Dampen Velocity Vars
            local vel_x, vel_y = body:getLinearVelocity()
            local targetAngle = body:getAngle()
            local velocityAngle = math.atan2(vel_y, vel_x) + math.pi /2

            velocityAngle = velocityAngle % (2*math.pi)
            targetAngle = targetAngle % (2*math.pi)

            -- Get x and y components of the target angle
            local target_x = math.cos(targetAngle)
            local target_y = math.sin(targetAngle)

            -- Get the x and y components of the difference
            local dif_x = target_x - vel_x
            local dif_y = target_y - vel_y

            -- If target angle is in quadrant
            --    |  #
            -- ___|___
            --    |
            --    |
            -- and velocity is
            --  # |
            -- ___|___
            --    |
            --    |

            local abs_dif = math.abs(targetAngle - velocityAngle) * (180/math.pi)
            local steer_x = target_x * time * 45
            local steer_y = target_y * time * 45

            if targetAngle < math.pi / 2 and velocityAngle > math.pi then
                dif_y = -(vel_y - target_y)
                dif_x = -(vel_x - target_x)
                abs_dif = math.abs(-(2 * math.pi - velocityAngle + targetAngle)) * (180/math.pi)

            -- If target angle is in quadrant
            -- #  |
            -- ___|___
            --    |
            --    |
            -- and velocity is
            --    |  #
            -- ___|___
            --    |
            --    |

                steer_x = 2 * math.pi-steer_x
                steer_y = 2 * math.pi-steer_y

            elseif velocityAngle < math.pi / 2 and targetAngle > math.pi then
                dif_y = -(vel_y - target_y)
                dif_x = -(vel_x - target_x)
                abs_dif = math.abs(-(2 * math.pi - targetAngle + velocityAngle)) * (180/math.pi)
                steer_x = 2 * math.pi-steer_x
                steer_y = 2 * math.pi-steer_y
            end



            if  abs_dif >= 5  then
                -- Change force based on how much of a difference
                -- Between player angle and velocity angle

                local mod = abs_dif / 360

                local force_x = dif_x * mod * entity.damping_force * time
                local force_y = dif_y * mod * entity.damping_force * time

                body:applyForce( force_x, force_y)
                    -- Also apply force in direction the player is facing
                    if (math.abs(vel_x) + math.abs(vel_y)) / 2 < entity.max_velocity  and (math.abs(vel_x) + math.abs(vel_y)) / 2 > 40 then
                        if targetAngle > velocityAngle then
                            body:applyForce(steer_x * entity.damping_force, steer_y * entity.damping_force)
                        else
                            body:applyForce(-steer_x * entity.damping_force , -steer_y * entity.damping_force )
                        end
                    end
            end

                -- Also correct over-spin
            local angular_velocity = body:getAngularVelocity()

            if math.abs(angular_velocity) > entity.max_spin then

                body:applyTorque((angular_velocity-entity.max_spin)*2* time)

            end
        end
    end
)
