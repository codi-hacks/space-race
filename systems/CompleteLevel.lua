-- Controls all objects with self.isControlled = true (typically just the player)

local System = require('lib/system')

local Entity = require 'services/entity'
local Love = require 'services/love'
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
            Love.audio.play(Sounds.chirp_up)
            --map.unload(2)
            Entity.list = {}
        end
    end
)
