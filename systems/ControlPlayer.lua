-- Controls all objects with self.isControlled = true (typically just the player)

local System = require('lib/system')
local keyboard = require('services/keyboard')
local state = require('state')

return System(
    {'-isControlled', 'body'},
    function(body)
        keyboard.move(body, love.timer.getDelta())
    end
)
