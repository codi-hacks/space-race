local sounds = require('services/sounds')
local mapList = require('maps/mapList')
local State = require 'services/state'
local map = require('services/map')
local shipMenu = require('menu/shipMenu')
local settingsMenu = require('menu/settingsMenu')
local save = require('services/save')
local timer = require('services/timer')

local menu = {}

State.menu.state = nil
State.menu.blink = true

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
                            menu.corner[1] + 448, menu.corner[2] + 430 + (i * 45), 0, 1.5, 1.5)
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
        love.graphics.print(convertedTime, menu.corner[1] + 550, menu.corner[2] + 340, 0, 1.5, 1.5)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print('-----', menu.corner[1] + 550, menu.corner[2] + 385, 0, 1.5, 1.5)
    end
end

menu.load = function()
    -- Yes, these are global variables. They will be unloaded when the menu is dismissed.
    menu.titleImage = love.graphics.newImage("/assets/sprites/menu_images/menu.png")
    menu.barImage = love.graphics.newImage("/assets/sprites/menu_images/menu_bar.png")
    menu.blinkTimer = 0
    if State.activeMap ~= -1 then
        menu.mapSelect = State.activeMap
    else
        menu.mapSelect = 1
    end
    -- Alias the true corner coordinates for convienience
    menu.corner = { State.camera.pos_x, State.camera.pos_y }
    menu.threeBest = timer.getBestTimes(menu.mapSelect, 3)

    shipMenu.load() -- Load ship menu - J.R.C 2/2/22
    settingsMenu.load()

    --[[ Set the current menu state to map select
        menu.state values can be:
        nil - no menu
        map_select - main menu/map selection prior to selecting ship
        ship_select - select ship prior to loading map
        settings - settings menu (precedes no specific event)
    ]]--

    State.menu.state = 'map_select'

    menu.smallFont = love.graphics.newFont('assets/gnevejpixel.ttf', 30)
    menu.bigFont = love.graphics.newFont('assets/gnevejpixel.ttf', 60)

    -- Save data when opening menu since this is likely right before a player will quit.
    save.write()
end

menu.unload = function()
    menu.titleImage = nil
    menu.barImage = nil
    menu.blinkTimer = nil
    menu.mapSelect = nil
    menu.threeBest = nil
    menu.smallFont = nil
    menu.bigFont = nil
    menu.corner = nil
    shipMenu.unload()
    settingsMenu.unload()
end

menu.current_menu_keys = function(pressed_key)
    -- Prioritize current menu's key_map, otherwise fall back on main menu key_map
    if State.menu.state == 'ship_select' and shipMenu.key_map[pressed_key] then
        shipMenu.key_map[pressed_key]()
    elseif State.menu.state == 'settings' and settingsMenu.key_map[pressed_key] then
        settingsMenu.key_map[pressed_key]()
    elseif menu.key_map[pressed_key] then
        menu.key_map[pressed_key]()
    end
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
            State.menu.state = nil
            State.paused = not State.paused
        end
    end,
    up = function()
        menu.up()
    end,
    down = function()
        menu.down()
    end,
    right = function()
        State.menu.state = 'settings'
        love.audio.stop(sounds.menu_click)
        love.audio.play(sounds.menu_click)
    end,
    ['return'] = function()
        if State.menu.state == 'ship_select' then
            shipMenu.load_ship()
            menu.load_map()
        else
            State.menu.state = 'ship_select'
        end
    end
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

    -- Transparent red background to be displayed for all menus
    love.graphics.setColor(0.1, 0.0, 0.0, 0.6)
    local verticies = {
        0 + menu.corner[1], 0 + menu.corner[2],
        0 + menu.corner[1], State.camera.window_height + menu.corner[2],
        State.camera.window_width + menu.corner[1], State.camera.window_height + menu.corner[2],
        State.camera.window_width + menu.corner[1], 0 + menu.corner[2] }
    love.graphics.polygon('fill', verticies)

    -- Draw map select (normal menu)
    if State.menu.state == 'map_select' then
        -- Added this because shipMenu changed the font - J.R.C
        love.graphics.setFont(menu.smallFont)

        -- Draw menu image background
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(menu.titleImage, verticies[1], verticies[2])

        -- Draw text
        if State.menu.blink then
            love.graphics.print(State.credits, menu.corner[1] + 700, menu.corner[2] + 70)

            -- Highlight map name in red if it is the active map.
            if menu.mapSelect == State.activeMap then
                love.graphics.setColor(1, 0, 0.25, 1)
            end
            love.graphics.setFont(menu.bigFont)
            love.graphics.print(mapList[menu.mapSelect].displayName, menu.corner[1] + 55, menu.corner[2] + 410)
            love.graphics.setColor(1, 1, 1, 1)
        end

        love.graphics.setFont(menu.bigFont)
        love.graphics.print('SPACE RACE', menu.corner[1] + 25, menu.corner[2] + 110)
        love.graphics.setFont(menu.smallFont)
        love.graphics.print('Credits: ', menu.corner[1] + 550, menu.corner[2] + 70)

        -- Draw best times and current time.
        displayTime()

        -- Display navigation bar
        love.graphics.draw(menu.barImage, menu.corner[1], menu.corner[2])
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print('Settings >>', menu.corner[1] + 690, menu.corner[2] + 8, 0, 0.5, 0.5)

        -- Draw ship select Menu
    elseif State.menu.state == 'ship_select' then
        shipMenu.draw()
    elseif State.menu.state == 'settings' then
        settingsMenu.draw()
    end

end

menu.update = function(dt)
    -- Blink timer for visual effect
    menu.blinkTimer = menu.blinkTimer + dt
    if menu.blinkTimer > 0.80 and State.menu.blink == true then
        menu.blinkTimer = 0
        State.menu.blink = not State.menu.blink
    elseif menu.blinkTimer > 0.2 and State.menu.blink == false then
        menu.blinkTimer = 0
        State.menu.blink = not State.menu.blink
    end
end

return menu
