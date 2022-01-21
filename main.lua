local world = require('services/world')
local state = require('state')
local Entity = require('services/entity')
local keyboard = require('services/keyboard')
local Camera = require('services/camera')
local menu = require('menu')

local sounds = require('services/sounds')
local textures = require('services/textures')
local keyboard = require('services/keyboard')
local background = require('services/background')
local map = require('services/map')

local ControlPlayer = require('systems/ControlPlayer')
local DebugPlayer = require('systems/DebugPlayer')
local UpdateCamera = require('systems/UpdateCamera')
local Gravitate = require('systems/Gravitate')

love.load = function()
    seconds = 0
    blinkTimer = 0
    blink = true
    love.window.setMode(800, 600)
    textures.load()
    starLocations = background.load()
    map.load(state.activeMap.filename)
end


-- Game time
love.keypressed = function(pressed_key)
    if state.paused then
        if menu.key_map[pressed_key] then
            menu.key_map[pressed_key]()
        end
    else
        if keyboard.key_map[pressed_key] then
            keyboard.key_map[pressed_key]()
        end
    end
end

love.draw = function()
        Camera.set()

        background.draw(starLocations)

        map.draw()

    if state.paused == true then
        menu.draw()
    end

    Camera.unset()
end

love.update = function(dt)
    if state.paused == false then
        world:update(dt)
        seconds = seconds + dt
        for _, entity in ipairs(Entity.list) do
            ControlPlayer(entity)
            Gravitate(entity)
            UpdateCamera(entity)
        end

        if seconds <= 0.25 then
            state.camera.scale_x = 1 / (seconds*4)
        else
            state.camera.scale_x = 1
        end
    else
        menu.update(dt)
    end
end
