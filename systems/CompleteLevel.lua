-- Controls all objects with self.isControlled = true (typically just the player)

local System = require('lib/system')

local Entity = require 'services/entity'
local Map = require 'services/map'
local Menu = require 'menu/menu'
local Sounds = require 'services/sounds'
local State = require 'services/state'

return System(
    { 'checkpoints' },
    function(checkpoints)
        if checkpoints < 1 then
            State.paused = true
            love.audio.play(Sounds.chirp_up)
            Menu.state.map_select = true
            Menu.state.ship_select = false
            Menu.load()
            Map.full_load(-1)
        end
    end
)
