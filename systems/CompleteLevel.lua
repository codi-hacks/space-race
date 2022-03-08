-- Controls all objects with self.isControlled = true (typically just the player)

local System = require('lib/system')

local Map = require 'services/map'
local Menu = require 'menu/menu'
local Sounds = require 'services/sounds'
local State = require 'services/state'
local Timer = require 'services/timer'

 -- Very poorly designed function to get credits and unlock next maps
local function update_creds()
     -- base credit amount for finishing the map
    local cred_amount = State.base_creds

    if tonumber(State.seconds) < State.gold then
        -- x3 cred multiplier
        cred_amount = cred_amount * 3
        -- unlock next map if not unlocked
        if State.unlocked_maps <= State.activeMap then
            State.unlocked_maps = State.unlocked_maps + 1
        end
    elseif tonumber(State.seconds) < State.silver then
         -- x2 cred multiplier
         cred_amount = cred_amount * 2
         -- unlock next map if not unlocked
         if State.unlocked_maps <= State.activeMap then
             State.unlocked_maps = State.unlocked_maps + 1
         end
    end

    State.credits = State.credits + cred_amount
    --Save new cred amount and map unlocks
end

return System(
    { 'checkpoints' },
    function(checkpoints)
        if checkpoints < 1 then
            update_creds()
            Timer.saveNewTime(State.seconds)
            State.paused = true
            love.audio.stop()
            love.audio.play(Sounds.chirp_up)
            Menu.state.map_select = true
            Menu.state.ship_select = false
            Menu.load()
            Map.loadMap(-1)
        end
    end
)
