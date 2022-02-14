-- Controls all objects with self.isControlled = true (typically just the player)

local System = require('lib/system')
local keyboard = require('services/keyboard')
local SpaceFriction = require('systems/SpaceFriction')

return System(
    {'_entity','-isControlled'},
    function(entity)
        keyboard.move(entity, love.timer.getDelta())
        SpaceFriction(entity)
    end
)
