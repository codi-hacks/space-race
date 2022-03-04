local sounds = require('services/sounds')
local State = require 'services/state'
local save = require('services/save')
local camera = require('services/camera')

local settingsMenu = {}

-- Next section: Actions

settingsMenu.up = function()
    -- Loop up the list of settings
    settingsMenu.selection = settingsMenu.selection + 1
    if settingsMenu.selection > #settingsMenu.options then
        settingsMenu.selection = 1
    end

    settingsMenu.ready = false

    love.audio.stop(sounds.boop)
    love.audio.play(sounds.boop)
end

settingsMenu.down = function()
    -- Loop down the list of settings
    settingsMenu.selection = settingsMenu.selection - 1
    if settingsMenu.selection < 1 then
        settingsMenu.selection = #settingsMenu.options
    end

    settingsMenu.ready = false

    love.audio.stop(sounds.boop)
    love.audio.play(sounds.boop)
end

settingsMenu.left = function()
    -- Decrement settings value, else if player is not entering values leave the settings menu.

    -- If setting a setting, set the setting with the setting set
    if settingsMenu.ready then
        -- Change value and take a sanity check
        local setting = settingsMenu.options[settingsMenu.selection]
        setting.value = setting.value - setting.increment
        if setting.value < setting.min then
            setting.value = setting.min
        end

        -- Play essential sound effects
        love.audio.stop(sounds.boop)
        love.audio.play(sounds.boop)
    else
        -- If not setting a setting, leave
        love.audio.stop(sounds.menu_click)
        love.audio.play(sounds.menu_click)
        State.menu.state = 'map_select'
        save.write()
    end
end

settingsMenu.right = function()
    -- If player is entering values, increment settings value
    if settingsMenu.ready then
        local setting = settingsMenu.options[settingsMenu.selection]
        setting.value = setting.value + setting.increment
        if setting.value > setting.max then
            setting.value = setting.max
        end

        love.audio.stop(sounds.boop)
        love.audio.play(sounds.boop)
    end
end

settingsMenu.enter = function()
    -- Player must press enter to enable setting changes
    settingsMenu.ready = not settingsMenu.ready

    if settingsMenu.ready == false then
        settingsMenu.updateSettings()
    end
end

settingsMenu.escape = function()
    -- Alternate way of leaving settings menu
    settingsMenu.ready = false
    settingsMenu.updateSettings()
    save.write()
    State.menu.state = 'map_select'
end

settingsMenu.updateSettings = function()
    camera.resize(settingsMenu.options[1].value)
    State.volume = settingsMenu.options[2].value / 100
    love.audio.setVolume(State.volume)

    love.audio.stop(sounds.menu_click)
    love.audio.play(sounds.menu_click)

    settingsMenu.ready = false -- Don't ask
end


-- Next section: Loading

settingsMenu.load = function()
    settingsMenu.titleImage = love.graphics.newImage("/assets/sprites/menu_images/settings_menu.png")
    settingsMenu.smallFont = love.graphics.newFont('assets/gnevejpixel.ttf', 60)
    settingsMenu.bigFont = love.graphics.newFont('assets/gnevejpixel.ttf', 90)
    settingsMenu.selection = 1
    settingsMenu.ready = false

    settingsMenu.options = {
        [1] = {
            name = 'Resolution',
            value = State.camera.scale_x,
            increment = 0.1,
            min = 1,
            max = 10
        },
        [2] = {
            name = 'Volume',
            value = State.volume * 100,
            increment = 10,
            min = 0,
            max = 100
        }
    }
end

settingsMenu.unload = function()
    settingsMenu.font = nil
    settingsMenu.options = nil
    settingsMenu.selection = nil
    settingsMenu.ready = nil
    settingsMenu.titleImage = nil
end


-- Next section: Drawing

settingsMenu.draw = function()
    -- Alias the true corner coordinates for convienience
    local corner = { State.camera.pos_x, State.camera.pos_y }
    local unit = ''
    love.graphics.setColor(1, 1, 1, 1)

    -- Short message and fancy graphic before the actual settings stuff
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(settingsMenu.titleImage, corner[1], corner[2] + 375)
    love.graphics.setFont(settingsMenu.smallFont)
    local settingsMessage = 'Use arrow keys and enter key \nto adjust settings'
    love.graphics.print(settingsMessage, corner[1] + 50, corner[2] + 500, 0, 0.5, 0.5)

    -- Begin actual settings stuff
    for i = 0, 1 do
        -- Display current selection in gold, or green if currently setting the setting
        if i + 1 == settingsMenu.selection then
            if settingsMenu.ready then
                love.graphics.setColor(1, 0, 0, 1)
            else
                love.graphics.setColor(255, 215, 0, 1)
            end
        else
            love.graphics.setColor(1, 1, 1, 1)
        end

        -- Draw settings

        -- Give appropriate unit to the setting
        if settingsMenu.options[i + 1].name == 'Resolution' then
            unit = 'x'
        elseif settingsMenu.options[i + 1].name == 'Volume' then
            unit = '%'
        end

        love.graphics.setFont(settingsMenu.bigFont)
        love.graphics.print(settingsMenu.options[i + 1].name, corner[1] + 50, corner[2] + 50 + (200 * i))
        love.graphics.setFont(settingsMenu.smallFont)
        love.graphics.print(settingsMenu.options[i + 1].value .. unit, corner[1] + 50, corner[2] + 150 + (200 * i))
    end
end

settingsMenu.update = function(dt)
    -- Nothing for now!
end

return settingsMenu
