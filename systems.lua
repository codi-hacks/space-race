local System = require('lib/system')
require('objects')

systems = {}


-- Easy way to call systems function without re-typing all of the loops and whatnot.
-- Usage: systems.call('foo', [arg])
systems.call = function(func, arg)
    -- TODO: Make optional args test for a table of values instead? (That way args can be limitless I think?)
    arg = arg or nil
    if arg then
        for _, entity in ipairs(objects) do
            systems[func](entity, arg)
        end
    else
        for _, entity in ipairs(objects) do
            systems[func](entity)
        end
    end
end

-- Grab object by name
systems.grab = System(
    {'name'},
    function(entityName, selectedName)
        for _, entity in ipairs(objects) do
            if entityName == selectedName then
                print(entity.name)
            end
        end
    end
)

systems.spawnObjects = System(
    {'position', 'body'},
    function(position, body)
        body:setX(position.x)
        body:setY(position.y)
    end
)

systems.drawObjects = System(
    {'draw'},
    function(drawFunction)
        drawFunction()
    end
)

systems.updateObjects = System(
    {'update'},
    function(updateFunction)
        updateFunction()
    end
)

systems.controlPlayer = System(
    {'isControlled', 'body'},
    function(isControlled, body)
        if isControlled then
            keyboard.move(body, love.timer.getDelta())
        end
    end
)

return systems