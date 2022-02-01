
local sounds = require('services/sounds')
local mapList = require('maps/mapList')
local loadMap = require('menu/loadMap')
local state = require 'state'

--[[
    TODO:
        Fix entities not being cleared upon loading a new map.
        Add text to title saying SPAAACE RAAAAACE
]]



local menu = {}



menu.up = function()
    menu.mapSelect = menu.mapSelect + 1
    if menu.mapSelect > #mapList then
        menu.mapSelect = 1
    end
end

menu.down = function()
    menu.mapSelect = menu.mapSelect - 1
    if menu.mapSelect < 1 then
        menu.mapSelect = #mapList
    end
end



menu.load = function()
    -- Yes, these are global variables. They will be unloaded when the menu is dismissed.
    menu.titleImage = love.graphics.newImage("/assets/sprites/menu.png")
    menu.blinkTimer = 0
    menu.blink = true
    menu.mapSelect = state.activeMap
end

menu.unload = function()
    menu.titleImage = nil
    menu.blinkTimer = nil
    menu.blink = nil
    menu.mapSelect = nil
end

menu.key_map = {
    escape = function()
        love.event.quit()
    end,
    b = function()
        state.debugOn = not state.debugOn
    end,
    p = function()
        menu.load_map()
    end,
    up = function()
        menu.up()
    end,
    down = function()
        menu.down()
    end,
    ['return'] = function()
        menu.load_map()
    end,
}
menu.load_map = function()
    -- If selected map is the same, just unpause...
    if state.activeMap == menu.mapSelect then
        state.paused = not state.paused
        menu.unload()
        love.audio.play(sounds.chirp_down)
        -- ...or else load a new map
    else
        --Entity.list = {}
        loadMap(menu.mapSelect)

        state.paused = not state.paused
        menu.unload()
        love.audio.play(sounds.chirp_down)
    end
end

menu.draw = function()
    -- Alias the true corner coordinates for convienience
    local corner = { state.camera.pos_x, state.camera.pos_y }

    -- Transparent red background
    love.graphics.setColor(0.1, 0.0, 0.0, 0.6)
    local verticies = {
        0 + corner[1], 0 + corner[2],
        0 + corner[1], 600 + corner[2],
        800 + corner[1], 600 + corner[2],
        800 + corner[1], 0 + corner[2] }
    love.graphics.polygon('fill', verticies)

    -- Draw menu image background
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(menu.titleImage, verticies[1], verticies[2])

    -- Draw text
    if menu.blink then
        love.graphics.print(mapList[menu.mapSelect].displayName, corner[1] + 55, corner[2] + 420, 0, 2, 2)
    end
    love.graphics.print('Current Map:\n' .. mapList[state.activeMap].displayName,
        corner[1] + 400, corner[2] + 450, 0, 2, 2)
    love.graphics.print('SPACE RACE', corner[1] + 25, corner[2] + 100, 0, 2, 2)

    --[[if menu.blink == true then
        love.graphics.setColor({1, 0, 0, 1})
        love.graphics.rectangle('line', corner[1], corner[2],
        state.camera.window_width, state.camera.window_height)
    end]]--
end

menu.update = function(dt)
    -- menu.blink timer for visual effect
    menu.blinkTimer = menu.blinkTimer + dt
    if menu.blinkTimer > 0.80 and menu.blink == true then
        menu.blinkTimer = 0
        menu.blink = not menu.blink
    elseif menu.blinkTimer > 0.2 and menu.blink == false then
        menu.blinkTimer = 0
        menu.blink = not menu.blink
    end
end

return menu
