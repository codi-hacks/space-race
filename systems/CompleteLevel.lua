-- Controls all objects with self.isControlled = true (typically just the player)

local System = require('lib/system')

local Entity = require 'services/entity'
--local Map = require 'services/map'
local Menu = require 'menu/menu'
local Sounds = require 'services/sounds'
local State = require 'services/state'

return System(
    {'checkpoints'},
    function(checkpoints)
        if checkpoints < 1 then
            State.paused = true
            Menu.load()
            love.audio.play(Sounds.chirp_up)
            --map.unload(2)
            Entity.list = {}
        end
    end
)
