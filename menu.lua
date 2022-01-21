local state = require('state')
local sounds = require('services/sounds')
local mapList = require('maps/mapList')
local map = require('services/map')

local menu = {}

menu.load = function()
    titleImage = love.graphics.newImage("/assets/sprites/menu.png")
end

menu.unload = function()
    titleImage = nil
end

menu.key_map = {
    escape = function()
        love.event.quit()
    end,
    b = function()
        state.debugOn = not state.debugOn
    end,
    p = function()
        state.paused = not state.paused
        menu.unload()
        love.audio.play(sounds.chirp_down)
    end,
    t = function()
        state.paused = not state.paused
        map.unload('happy')
        state.activeMap = mapList[2]
        map.load('test')
        love.audio.play(sounds.chirp_down)
    end
}

menu.draw = function()
    love.graphics.setColor(0.1, 0.0, 0.0, 0.6)
    local verticies = {
        0 + state.camera.pos_x, 0 + state.camera.pos_y,
        0 + state.camera.pos_x, 600 + state.camera.pos_y,
        800 + state.camera.pos_x, 600 + state.camera.pos_y,
        800 + state.camera.pos_x, 0 + state.camera.pos_y}
    love.graphics.polygon('fill', verticies)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(titleImage, verticies[1], verticies[2])

    blinkTimer = blinkTimer + love.timer.getDelta()
    if blinkTimer > .25 then
        blinkTimer = 0
        blink = not blink
    end
    if blink == true then
        love.graphics.setColor({1, 0, 0, 1})
        love.graphics.rectangle('line', state.camera.pos_x, state.camera.pos_y,
        state.camera.window_width, state.camera.window_height)
    end
end

menu.update = function(dt)
end

return menu
