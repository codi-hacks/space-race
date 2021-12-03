local System = require('lib/system')
require('objects')
local Camera = require('camera')

systems = {}


--[[
    There are two ways to access a systems command.
    1. Call the function like normal
        - Typically used as generic functions for interacting with table of entities
        - These are denoted by having lowercase first letters
    2. Use systems.call('foo', {bar})
        - Typically used as game-interacting functions
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

-- Insert entity into table (pure laziness function at this point)
systems.insert = function(insertedObject)
    table.insert(objects, insertedObject)
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
    {'-isControlled', 'body'},
    function(body)
        keyboard.move(body, love.timer.getDelta())
    end
)

systems.UpdateCamera = System(
    {'-isControlled', 'body'},
    function(body)
        local player_pos_x, player_pos_y = body:getPosition()

        local camera_pos_x = player_pos_x - 400
        local camera_pos_y = player_pos_y - 300

        --[[
        local camera_pos_x, camera_pos_y = Camera.get_position()
        local player_height = size
        local player_width = size

        local boundary_bottom = Camera.get_boundary_bottom()
        local boundary_top = Camera.get_boundary_top()

        if player_pos_y < boundary_top then
            camera_pos_y = camera_pos_y - (boundary_top - player_pos_y)
        elseif player_pos_y + player_height > boundary_bottom then
            camera_pos_y = camera_pos_y - (boundary_bottom - (player_pos_y + player_height))
        end

        local boundary_left = Camera.get_boundary_left()
        local boundary_right = Camera.get_boundary_right()

        if player_pos_x < boundary_left then
            camera_pos_x = camera_pos_x - (boundary_left - player_pos_x)
        elseif player_pos_x + player_width > boundary_right then
            camera_pos_x = camera_pos_x - (boundary_right - (player_pos_x + player_width))
        end]]--

        Camera.set_position(camera_pos_x, camera_pos_y)
    end
)

return systems
