love.state = {}
love.state.paused = true
love.state.debugOn = false
love.state.activeMap = 1
love.state.camera = {
} -- Initialized in /camera.lua
love.state.camera.pos_x =0
love.state.camera.pos_y =0
local world = require('services/world')

local Entity = require('services/entity')
local keyboard = require('services/keyboard')
local Camera = require('services/camera')

local menu = require('menu/menu')
local loadMap = require('menu/loadMap')

local textures = require('services/textures')
local background = require('services/background')
local map = require('services/map')

local ControlPlayer = require('systems/ControlPlayer')
local UpdateCamera = require('systems/UpdateCamera')
local CustomCollision = require('systems/CustomCollision')
local Gravitate = require('systems/Gravitate')




love.load = function()
    love.seconds =0
    love.window.setMode(800, 600)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    textures.load()
    love.graphics.setNewFont('assets/gnevejpixel.ttf', 30)
    love.starLocations = background.load()
    loadMap(love.state.activeMap)
    menu.load()
end


-- Game time
love.keypressed = function(pressed_key)
    if love.state.paused then
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

        background.draw( love.starLocations)

        map.draw()

    if love.state.paused == true then
        menu.draw()
    end

    Camera.unset()
end

love.update = function(dt)
    if love.state.paused == false then
        world:update(dt)
        love.seconds = love.seconds + dt
        for _, entity in ipairs(Entity.list) do
            ControlPlayer(entity)
            Gravitate(entity)
            UpdateCamera(entity)
            CustomCollision(entity)
        end

        if love.seconds <= 0.25 then
            love.state.camera.scale_x = 1 / (love.seconds*4)
        else
            love.state.camera.scale_x = 1
        end
    else
        menu.update(dt)
    end
end
