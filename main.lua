require('world')
require('entities')
require('systems')
require('state')

require('/services/debug')
require('/services/sounds')
require('/services/textures')
require('/services/keyboard')
require('/services/background')

love.load = function()
    seconds = 0
    blinkTimer = 0
    blink = true
    love.window.setMode(800, 600)
    sounds.load()
    textures.load()
    starLocations = background.load()

    for _, entity in ipairs(entities) do
        systems.SpawnEntities(entity)
    end
end


-- Game time
love.keypressed = function(pressed_key)
    if keyboard.key_map[pressed_key] then
        keyboard.key_map[pressed_key]()
    end
end

love.draw = function()
    Camera.set()

    background.draw(starLocations)

    for _, entity in ipairs(entities) do
        systems.DrawEntities(entity)
    end

    if state.debugOn then debug() end

    if state.paused == true then
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

    Camera.unset()
end

love.update = function(dt)
    if state.paused == false then
        world:update(dt)
        seconds = seconds + dt
        for _, entity in ipairs(entities) do
            systems.ControlPlayer(entity)
            systems.UpdateEntities(entity)
            systems.Gravitate(entity, entity)
            systems.UpdateCamera(entity)
        end

        if seconds <= 0.25 then
            state.camera.scale_x = 1 / (seconds*4)
        else
            state.camera.scale_x = 1
        end
    end
end
