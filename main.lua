local world = require('services/world')

local Entity = require('services/entity')
local keyboard = require('services/keyboard')
local Camera = require('services/camera')

local menu = require('menu/menu')

local textures = require('services/textures')
local background = require('services/background')
local HUD = require('services/HUD')
local map = require('services/map')
local State = require 'services/state'
local save = require('services/save')

local ControlPlayer = require('systems/ControlPlayer')
local Gravitate = require('systems/Gravitate')
local UpdateCamera = require('systems/UpdateCamera')
local UpdateEntityAnimation = require('systems/UpdateEntityAnimation')

local SpaceFriction = require('systems/SpaceFriction')

love.load = function()
    love.window.setMode(800, 600)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    textures.load()
    love.globalFont = love.graphics.newFont('assets/gnevejpixel.ttf', 30)
    love.graphics.setFont(love.globalFont)
    love.starLocations = background.load()
    save.read()
    menu.load()
end


-- Game time
love.keypressed = function(pressed_key)
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

love.draw = function()
    Camera.set()

    background.draw(love.starLocations)

    map.draw()

    if State.paused == true then
        menu.draw()
    else
        HUD.draw()
    end

    Camera.unset()
end

love.update = function(dt)
    if State.paused == false then
        world:update(dt)
        State.seconds = State.seconds + dt
        for _, entity in ipairs(Entity.list) do
            ControlPlayer(entity)
            Gravitate(entity)
            SpaceFriction(entity, dt)
            UpdateCamera(entity)
            UpdateEntityAnimation(entity, dt)
        end
    else
        menu.update(dt)
    end
end

