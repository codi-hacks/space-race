-- Controls all objects with self.isControlled = true (typically just the player)

local System = require('lib/system')
local Love = require 'services/love'
local keyboard = require('services/keyboard')

return System(
    {'_entity','-isControlled'},
    function(entity)
        keyboard.move(entity, Love.timer.getDelta())
    end
)
