-- Update and control the camera.
-- Uses Camera.lua for all of the actual camera functions.

local System = require('/lib/system')
local Camera = require('/services/camera')

return System(
    {'-isControlled', 'body'},
    function(body)
        local player_pos_x, player_pos_y = body:getPosition()

        local camera_pos_x = player_pos_x - 400
        local camera_pos_y = player_pos_y - 300

        --[[
            These functions will come in handy once game world borders come
            into play again. For now they are unnessary though.

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
        end

        ]]--

        Camera.set_position(camera_pos_x, camera_pos_y)
    end
)
