-- Calculate and apply gravitational force

System = require('/lib/system')

local gravitationalConstant = 100

local gravityMaker = System(
    {'mass', 'body'},
    function(mass2, body2, mass1, body1, x1, y1)
        if body1 ~= body2 then
            local x2, y2 = body2:getPosition()
            local forcex = x2 - x1
            local forcey = y2 - y1
            local force = (gravitationalConstant * mass2 * mass1) / ((math.abs(x2 - x1))^2 + (math.abs(y2 - y1))^2)

            forcex = force * (x2 - x1)
            forcey = force * (y2 - y1)
            body1:applyForce((forcex), (forcey))
        end
    end
)

local Gravitate = System(
    {'mass', 'body'},
    function(mass, body)
        local tempx, tempy = body:getPosition()
        for _, secondObject in ipairs(entities) do
            gravityMaker(secondObject, mass, body, tempx, tempy)
        end
    end
)

return Gravitate
