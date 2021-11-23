local System = require('lib/system')
require('objects')

systems = {}


--[[
    There are two ways to access a systems command.
    1. Call the function like normal
        - Typically used as generic functions for interacting with table of entities
        - These are denoted by having lowercase first letters
    2. Use systems.call('foo', {bar})
        - Typicalled used as game-interacting functions
        - These are denoted by having uppercase first letters
        - To pass an agrument (if necessary), wrap the arg(s) in some curly bois.
]]

-- Easy way to call systems function without re-typing all of the loops and whatnot.
-- Usage: systems.call('foo', [{arg}])
systems.call = function(func, arg)
    arg = arg or nil
    if type(arg) == 'table' then
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
systems.grab = function(selectedName)
    for _, entity in ipairs(objects) do
        if entity.name == selectedName then
            return entity
        end
    end
end

-- Spawn objects at their first position
systems.SpawnObjects = System(
    {'position', 'body'},
    function(position, body)
        body:setX(position.x)
        body:setY(position.y)
    end
)

-- Call any draw functions that need to be drawn
systems.DrawObjects = System(
    {'draw'},
    function(drawFunction)
        drawFunction()
    end
)

-- Call any update functions that need to be updated
systems.UpdateObjects = System(
    {'update'},
    function(updateFunction)
        updateFunction()
    end
)

-- Controls all objects with self.isControlled = true (typically just the player)
systems.ControlPlayer = System(
    {'isControlled', 'body'},
    function(isControlled, body)
        if isControlled then
            keyboard.move(body, love.timer.getDelta())
        end
    end
)

return systems