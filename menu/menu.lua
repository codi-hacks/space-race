local state = require('state')
local sounds = require('services/sounds')
local mapList = require('maps/mapList')
local loadMap = require('menu/loadMap')
local cycleMaps = require('menu/cycleMaps')


--[[
    TODO:
        Fix entities not being cleared upon loading a new map.
        Add text to title saying SPAAACE RAAAAACE
]]



local menu = {}

menu.load = function()
    -- Yes, these are global variables. They will be unloaded when the menu is dismissed.
    titleImage = love.graphics.newImage("/assets/sprites/menu.png")
    blinkTimer = 0
    blink = true
    mapSelect = state.activeMap
end

menu.unload = function()
    titleImage = nil
    blinkTimer = nil
    blink = nil
    mapSelect = nil
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
        cycleMaps.up()
    end,
    down = function()
        cycleMaps.down()
    end,
    ['return'] = function()
        menu.load_map()

    end,
    backspace = function()
        menu.load_map()
    end
}
menu.load_map = function()
    -- If selected map is the same, just unpause...
    if state.activeMap == mapSelect then
        state.paused = not state.paused
        menu.unload()
        love.audio.play(sounds.chirp_down)
        -- ...or else load a new map
    else
        --Entity.list = {}
        loadMap(mapSelect)

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
    love.graphics.draw(titleImage, verticies[1], verticies[2])

    -- Draw text
    if blink then
        love.graphics.print(mapList[mapSelect].displayName, corner[1] + 55, corner[2] + 420, 0, 2, 2)
    end
    love.graphics.print('Current Map:\n' .. mapList[state.activeMap].displayName, corner[1] + 400, corner[2] + 450, 0, 2, 2)
    love.graphics.print('SPACE RACE', corner[1] + 25, corner[2] + 100, 0, 2, 2)

    --[[if blink == true then
        love.graphics.setColor({1, 0, 0, 1})
        love.graphics.rectangle('line', corner[1], corner[2],
        state.camera.window_width, state.camera.window_height)
    end]]--
end

menu.update = function(dt)
    -- Blink timer for visual effect
    blinkTimer = blinkTimer + dt
    if blinkTimer > 0.80 and blink == true then
        blinkTimer = 0
        blink = not blink
    elseif blinkTimer > 0.2 and blink == false then
        blinkTimer = 0
        blink = not blink
    end
end

return menu
