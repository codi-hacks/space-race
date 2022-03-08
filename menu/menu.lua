local sounds = require('services/sounds')
local mapList = require('maps/mapList')
local State = require 'services/state'
local map = require('services/map')
local shipMenu = require('menu/shipMenu')
local save = require('services/save')
local timer = require('services/timer')

local textures = require('services/textures')


local menu = {
    state = {}
}

menu.up = function()
    menu.mapSelect = menu.mapSelect + 1
    if menu.mapSelect > #mapList then
        menu.mapSelect = 1
    end

    menu.threeBest = timer.getBestTimes(menu.mapSelect, 3)
end

menu.down = function()
    menu.mapSelect = menu.mapSelect - 1
    if menu.mapSelect < 1 then
        menu.mapSelect = #mapList
    end

    menu.threeBest = timer.getBestTimes(menu.mapSelect, 3)
end

local function displayTime()
    -- Draw current time and best times.
    local isNewBest = false
    local convertedTime
    local corner = { State.camera.pos_x, State.camera.pos_y }

    -- Display either the last finish time (if map has finished) or current time.
    if State.activeMap ~= -1 then
        convertedTime = timer.convertSeconds(State.seconds)
    else
        convertedTime = timer.convertSeconds(State.lastCompletedTime)
    end

    -- Display three best times on record
    for i = 0, 2 do
        -- If map was completed and time is one of the best, display it in gold.
        if menu.threeBest[i + 1] == convertedTime then
            isNewBest = true
            love.graphics.setColor(255, 215, 0, 1)
        end
        -- Print out times
        love.graphics.print('#' .. i + 1 .. ': ' .. menu.threeBest[i + 1],
                            corner[1] + 448, corner[2] + 430 + (i * 45), 0, 1.5, 1.5)
        love.graphics.setColor(1, 1, 1, 1)
    end

    -- If map was completed and time is not the best, display it above best times.
    if isNewBest == false then
        -- If map was completed, display time in green, else in red.
        if State.activeMap == -1 then
            love.graphics.setColor(0.1, 0.8, 0.3, 1)
        else
            love.graphics.setColor(1, 0, 0.25, 1)
        end
        -- Print current time.
        love.graphics.print(convertedTime, corner[1] + 550, corner[2] + 340, 0, 1.5, 1.5)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print('-----', corner[1] + 550, corner[2] + 385, 0, 1.5, 1.5)
    end
end

menu.load = function()
    -- Yes, these are global variables. They will be unloaded when the menu is dismissed.
    menu.titleImage = love.graphics.newImage("/assets/sprites/menu.png")
    menu.blinkTimer = 0
    menu.blink = true
    if State.activeMap ~= -1 then
        menu.mapSelect = State.activeMap
    else
        menu.mapSelect = 1
    end
    menu.threeBest = timer.getBestTimes(menu.mapSelect, 3)

    shipMenu.load() -- Load ship menu - J.R.C 2/2/22

    -- Set the current menu state to map select
    menu.state.map_select = true
    menu.state.ship_select = false
    menu.font = love.graphics.newFont('assets/gnevejpixel.ttf', 30)

    -- Save data when opening menu since this is likely right before a player will quit.
    save.write()
end

menu.unload = function()
    menu.titleImage = nil
    menu.blinkTimer = nil
    menu.blink = nil
    menu.mapSelect = nil
    menu.threeBest = nil
    menu.font = nil
    shipMenu.unload()
end

menu.key_map = {
    escape = function()
        save.write()
        love.event.quit()
    end,
    o = function()
        -- Become Mr. Krabs and get all the money
        love.audio.play(sounds.chirp_up)
        State.credits = State.credits + 1
    end,
    b = function()
        State.debugOn = not State.debugOn
    end,
    -- P now just pauses and unpauses
    -- use ENTER to select a map and ship - J.R.C 2/7/22
    p = function()
        if State.activeMap ~= -1 then
            menu.state.map_select = not menu.state.map_select
            State.paused = not State.paused
        end
    end,
    up = function()
        if menu.state.map_select then
            menu.up()
        end
    end,
    down = function()
        if menu.state.map_select then
            menu.down()
        end
    end,
    left = function()
        if menu.state.ship_select then
            shipMenu.left()
        end
    end,
    right = function()
        if menu.state.ship_select then
            shipMenu.right()
        end
    end,
    backspace = function()
        if menu.state.ship_select then
            menu.state.map_select = true
            menu.state.ship_select = false
        end
    end,
    ['return'] = function()
        if menu.state.map_select then
            -- If map is unlocked - J.R.C 3/8/22
            if menu.mapSelect <= State.unlocked_maps then
                menu.state.map_select = false
                menu.state.ship_select = true
            else
                -- Play a denial sound here

            end
        elseif menu.state.ship_select then
            shipMenu.load_ship()
            menu.load_map()
        end
    end,
}

menu.load_map = function()
    -- If selected map is the same, just unpause...
    --[[

            Removed unpause, map is reloaded every time you select now
            - J.R.C 2/7/22

            if State.activeMap == menu.mapSelect then
                State.paused = not State.paused
                menu.unload()
                love.audio.play(sounds.chirp_down)
             -- ...or else load a new map
            else

    ]]
    --Entity.list = {}

    map.loadMap(menu.mapSelect)

    State.paused = not State.paused
    State.shipMenu = true -- Go to ship select menu - J.R.C 2/2/22
    menu.unload()
    love.audio.play(sounds.chirp_down)
end

menu.draw = function()

    -- Draw map select (normal menu)
    if menu.state.map_select then
        -- Added this because shipMenu changed the font - J.R.C
        love.graphics.setFont(menu.font)
        -- Alias the true corner coordinates for convienience
        local corner = { State.camera.pos_x, State.camera.pos_y }

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

         -- Highlight map name in red if it is the active map.
         if menu.mapSelect == State.activeMap then
            love.graphics.setColor(1, 0, 0.25, 1)
        end

        -- If map is not unlocked - J.R.C 3/8/22
        if menu.mapSelect > State.unlocked_maps then
            local verts = {
                500 + corner[1], 160 + corner[2],
                500 + corner[1], 260 + corner[2],
                750 + corner[1], 260 + corner[2],
                750 + corner[1], 160 + corner[2]
            }
            love.graphics.setColor(0.2, 0.2, 0.2, 0.9)
            love.graphics.polygon('fill', verts)
            -- Draw lock icon
            love.graphics.draw(textures['lock'], corner[1] + 505, corner[2] + 170)
            love.graphics.draw(textures['lock'], corner[1] + 713, corner[2] + 170)

            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.print('Map', corner[1] + 601, corner[2] + 170)
            love.graphics.print('Locked', corner[1] + 575, corner[2] + 215)
            love.graphics.setColor(0.2, 0.2, 0.2, 0.9)

        end

        -- Draw text
        if menu.blink then
            love.graphics.print(mapList[menu.mapSelect].displayName, corner[1] + 55, corner[2] + 420, 0, 2, 2)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.print(State.credits, corner[1] + 655, corner[2] + 30)
        end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print('SPACE RACE', corner[1] + 25, corner[2] + 100, 0, 2, 2)
        love.graphics.print('Credits: ', corner[1] + 505, corner[2] + 30)

        -- Draw best times and current time.
        displayTime()

        -- Draw ship select Menu
    elseif menu.state.ship_select then
        shipMenu.draw()
    end

end

menu.update = function(dt)
    if menu.state.map_select then
        -- Blink timer for visual effect
        menu.blinkTimer = menu.blinkTimer + dt
        if menu.blinkTimer > 0.80 and menu.blink == true then
            menu.blinkTimer = 0
            menu.blink = not menu.blink
        elseif menu.blinkTimer > 0.2 and menu.blink == false then
            menu.blinkTimer = 0
            menu.blink = not menu.blink
        end
    elseif menu.state.ship_select then
        shipMenu.update(dt)
    end
end

return menu
