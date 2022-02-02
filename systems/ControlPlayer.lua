-- Controls all objects with self.isControlled = true (typically just the player)

local System = require('lib/system')
local keyboard = require('services/keyboard')
local state = require('state')

return System(
    {'_entity','-isControlled'},
    function(entity)
        keyboard.move(entity, love.timer.getDelta())
    end
)
