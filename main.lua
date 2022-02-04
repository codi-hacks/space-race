local world = require('services/world')

local Entity = require('services/entity')
local keyboard = require('services/keyboard')
local Camera = require('services/camera')
local Love = require 'services/love'

local menu = require('menu/menu')
local loadMap = require('menu/loadMap')

local textures = require('services/textures')
local background = require('services/background')
local map = require('services/map')
local State = require 'services/state'

local ControlPlayer = require('systems/ControlPlayer')
local Gravitate = require('systems/Gravitate')
local UpdateCamera = require('systems/UpdateCamera')
local UpdateEntityAnimation = require('systems/UpdateEntityAnimation')

Love.load = function()
    Love.seconds =0
    Love.window.setMode(800, 600)
    Love.graphics.setDefaultFilter('nearest', 'nearest')
    textures.load()
    Love.graphics.setNewFont('assets/gnevejpixel.ttf', 30)
    Love.starLocations = background.load()
    loadMap(State.activeMap)
    menu.load()
end


-- Game time
Love.keypressed = function(pressed_key)
    if State.paused then
        if menu.key_map[pressed_key] then
            menu.key_map[pressed_key]()
        end
    else
        if keyboard.key_map[pressed_key] then
            keyboard.key_map[pressed_key]()
        end
    end
end

Love.draw = function()
        Camera.set()

        background.draw( Love.starLocations)

        map.draw()

    if State.paused == true then
        menu.draw()
    end

    Camera.unset()
end

Love.update = function(dt)
    if State.paused == false then
        world:update(dt)
        Love.seconds = Love.seconds + dt
        for _, entity in ipairs(Entity.list) do
            ControlPlayer(entity)
            Gravitate(entity)
            UpdateCamera(entity)
            UpdateEntityAnimation(entity, dt)
        end

        if Love.seconds <= 0.25 then
            State.camera.scale_x = 1 / (Love.seconds*4)
        else
            State.camera.scale_x = 1
        end
    else
        menu.update(dt)
    end
end
