local State = require('services/state')
local timer = require('services/timer')

HUD = {}

-- Holds all drawing and updating relating to in-game Heads Up Display

HUD.draw = function()
    -- Alias the true corner coordinates for convienience
    local corner = { State.camera.pos_x, State.camera.pos_y }

    love.graphics.setFont(love.globalFont)
    love.graphics.print(timer.convertSeconds(State.seconds), corner[1], corner[2])
end

return HUD
