local world = require('services/world')

local Entity = require('services/entity')
local keyboard = require('services/keyboard')
local Camera = require('services/camera')

local menu = require('menu/menu')
local loadMap = require('menu/loadMap')

local shipMenu = require('menu/shipMenu')

local textures = require('services/textures')
local background = require('services/background')
local map = require('services/map')
local State = require 'services/state'

local ControlPlayer = require('systems/ControlPlayer')
local Gravitate = require('systems/Gravitate')
local UpdateCamera = require('systems/UpdateCamera')
local UpdateEntityAnimation = require('systems/UpdateEntityAnimation')

love.load = function()
    love.seconds =0
    love.window.setMode(800, 600)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    textures.load()
    love.graphics.setNewFont('assets/gnevejpixel.ttf', 30)
    love.starLocations = background.load()
    loadMap(State.activeMap)
    menu.load()
    shipMenu.load() -- Load ship menu - J.R.C 2/2/22
end


-- Game time
love.keypressed = function(pressed_key)
    if State.paused then
        if menu.key_map[pressed_key] then
            menu.key_map[pressed_key]()
        end
    elseif State.shipMenu then  -- Update ship menu keymap - J.R.C 2/2/22
        if shipMenu.key_map[pressed_key] then
            shipMenu.key_map[pressed_key]()
        end
    else
        if keyboard.key_map[pressed_key] then
            keyboard.key_map[pressed_key]()
        end
    end
end

love.draw = function()
        Camera.set()

        background.draw( love.starLocations)

        map.draw()
        if State.shipMenu then -- Draw ship menu  - J.R.C 2/2/22
            shipMenu.draw()
        elseif State.paused == true then
            menu.draw()
        end

    Camera.unset()
end

love.update = function(dt)
    if State.shipMenu then -- Update ship menu - J.R.C 2/2/22
        shipMenu.update(dt)
    elseif State.paused == false then
        world:update(dt)
        love.seconds = love.seconds + dt
        for _, entity in ipairs(Entity.list) do
            ControlPlayer(entity)
            Gravitate(entity)
            UpdateCamera(entity)
            UpdateEntityAnimation(entity, dt)
        end

        if love.seconds <= 0.25 then
            State.camera.scale_x = 1 / (love.seconds*4)
        else
            State.camera.scale_x = 1
        end

    else
        menu.update(dt)
    end
end

