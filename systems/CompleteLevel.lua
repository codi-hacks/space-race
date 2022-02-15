-- Controls all objects with self.isControlled = true (typically just the player)

local System = require('lib/system')

local Map = require 'services/map'
local Menu = require 'menu/menu'
local Sounds = require 'services/sounds'
local State = require 'services/state'
local Timer = require 'services/timer'

return System(
    { 'checkpoints' },
    function(checkpoints)
        if checkpoints < 1 then
            Timer.saveNewTime(State.seconds)
            State.paused = true
            love.audio.play(Sounds.chirp_up)
            Menu.state.map_select = true
            Menu.state.ship_select = false
            Menu.load()
            Map.loadMap(-1)
        end
    end
)
