local State = require('services/state')
local timer = require('services/timer')

local textures = require('services/textures')

local HUD = {}

-- Holds all drawing and updating relating to in-game Heads Up Display

HUD.draw = function()
    -- Alias the true corner coordinates for convienience
    local corner = { State.camera.pos_x, State.camera.pos_y }

    -- Draw current time
    love.graphics.setFont(love.globalFont)
    love.graphics.print(timer.convertSeconds(State.seconds), corner[1], corner[2])

    -- Draw time to beat to unlock next map
    if State.seconds <= State.gold then
        love.graphics.print("Beat " .. timer.convertSeconds(State.gold) .. " for " .. State.base_creds * 3 .. " credits", corner[1], corner[2] + 570)
        love.graphics.draw(textures['gold'], corner[1] + 768, corner[2])
    elseif State.seconds <= State.silver then
        love.graphics.print("Beat " .. timer.convertSeconds(State.silver) .. " for " .. State.base_creds * 2 .. " credits", corner[1], corner[2] + 570)
        love.graphics.draw(textures['silver'], corner[1] + 768, corner[2])
    else
        love.graphics.print("Beat the map for " .. State.base_creds  .. " credits", corner[1], corner[2] + 570)
    end

end

return HUD
