-- Calculate and apply gravitational force

local System = require('/lib/system')
local Entity = require('services/entity')

local gravitationalConstant = 10000

local gravityMaker = System(
    {'body'},
    function(body2, mass1, body1, x1, y1)
        local mass2 = body2:getMass()
        if body1 ~= body2 then
            local x2, y2 = body2:getPosition()
            local forcex = x2 - x1
            local forcey = y2 - y1
            local force = (gravitationalConstant * mass2 * mass1) / ((math.abs(x2 - x1))^2 + (math.abs(y2 - y1))^2)

            forcex = force * (x2 - x1)
            forcey = force * (y2 - y1)
            body1:applyForce(forcex, forcey)
        end
    end
)

local Gravitate = System(
    {'body'},
    function(body)
        local mass = body:getMass()
        local tempx, tempy = body:getPosition()
        for _, secondObject in ipairs(Entity.list) do
            gravityMaker(secondObject, mass, body, tempx, tempy)
        end
    end
)

return Gravitate
