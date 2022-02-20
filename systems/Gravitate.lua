-- Calculate and apply gravitational force

local System = require('/lib/system')
local Entity = require('services/entity')

-- This is an arbitrary value used to give strength to gravity
local gravitationalConstant = 60

local gravityMaker = System(
    {'body', 'gravitational_mass'},
    function(body2, mass2, mass1, body1, x1, y1, shape)
        --[[ This system takes the first entity from the below function
        and grabs the second entity. It then calculates the gravitational
        attraction and applies the necessary force. ]]--

        if body1 ~= body2 then

            -- Check if distance is in the right range - J.R.C 2/19/22
            local x2, y2 = body2:getPosition()

            local distance =  math.sqrt( (x2-x1)^2 + (y2-y1)^2)

            local diameter = shape:getRadius()*2

            if distance < 500 + diameter and distance > diameter then

                local force = (gravitationalConstant * mass2 * mass1) / ((math.abs(x2 - x1))^2 + (math.abs(y2 - y1))^2)
                local forcex = force * (x2 - x1)
                local forcey = force * (y2 - y1)
                body1:applyForce(forcex, forcey)

            end
        end
    end
)

local Gravitate = System(
    {'body', 'gravitational_mass', 'shape'},
    function(body, mass, shape)
        -- This system grabs the first entity in the upcoming calculation

        local tempx, tempy = body:getPosition()
        for _, secondObject in ipairs(Entity.list) do
            gravityMaker(secondObject, mass, body, tempx, tempy, shape)
        end
    end
)

return Gravitate
