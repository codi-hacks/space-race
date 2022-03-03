local sounds = require('services/sounds')
local mapList = require('maps/mapList')
local State = require 'services/state'
local map = require('services/map')
local shipMenu = require('menu/shipMenu')
local save = require('services/save')
local timer = require('services/timer')

local settingsMenu = {}

settingsMenu.up = function()
    -- placeholder
end

settingsMenu.down = function()
    -- placeholder
end

settingsMenu.load = function()
    -- Alias the true corner coordinates for convienience
    settingsMenu.corner = { State.camera.pos_x, State.camera.pos_y }
    settingsMenu.font = love.graphics.newFont('assets/gnevejpixel.ttf', 30)

    -- Save data when opening menu since this is likely right before a player will quit.
    save.write()
end

settingsMenu.unload = function()
    settingsMenu.titleImage = nil
    settingsMenu.blinkTimer = nil
    settingsMenu.mapSelect = nil
    settingsMenu.threeBest = nil
    settingsMenu.font = nil
    settingsMenu.corner = nil
end

settingsMenu.draw = function()
    -- Reset font
    love.graphics.setFont(settingsMenu.font)

    -- Transparent red background
    love.graphics.setColor(0.1, 0.0, 0.0, 0.6)
    local verticies = {
        0 + settingsMenu.corner[1], 0 + settingsMenu.corner[2],
        0 + settingsMenu.corner[1], 600 + settingsMenu.corner[2],
        800 + settingsMenu.corner[1], 600 + settingsMenu.corner[2],
        800 + settingsMenu.corner[1], 0 + settingsMenu.corner[2] }
    love.graphics.polygon('fill', verticies)

    -- Draw settingsMenu image background
    love.graphics.setColor(1, 1, 1, 1)
    --love.graphics.draw(settingsMenu.titleImage, verticies[1], verticies[2])

end

settingsMenu.update = function(dt)
    -- nothing for now!
end

return settingsMenu
