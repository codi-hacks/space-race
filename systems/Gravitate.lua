-- Calculate and apply gravitational force

local System = require('/lib/system')
local Entity = require('services/entity')

-- This is an arbitrary value used to give strength to gravity
local gravitationalConstant = 10000

local gravityMaker = System(
    {'body'},
    function(body2, mass1, body1, x1, y1)
        --[[ This system takes the first entity from the below function
        and grabs the second entity. It then calculates the gravitational
        attraction and applies the necessary force. ]]--

        local mass2 = body2:getMass()
        if body1 ~= body2 then
            print(mass1, mass2)
            local x2, y2 = body2:getPosition()
            local force = (gravitationalConstant * mass2 * mass1) / ((math.abs(x2 - x1))^2 + (math.abs(y2 - y1))^2)
            local forcex = force * (x2 - x1)
            local forcey = force * (y2 - y1)
            body1:applyForce(forcex, forcey)
        end
    end
)

local Gravitate = System(
    {'body'},
    function(body)
        -- This system grabs the first entity in the upcoming calculation

        local mass = body:getMass()
        local tempx, tempy = body:getPosition()
        for _, secondObject in ipairs(Entity.list) do
            gravityMaker(secondObject, mass, body, tempx, tempy)
        end
    end
)

return Gravitate
