local sounds = require('services/sounds')
local shipList = require('ships/shipList')
local loadShip = require('menu/loadShip')
local state = require('services/state')
local Textures = require('services/textures')




--[[
   Menu template code by Trevor. Thanks!

   Additions by J.R.C 2/4/22
]]

local ship_menu = {}

--Function returns the ship table of the ship to the left
local function get_left()
    local left_index = ship_menu.shipSelect
    if ship_menu.shipSelect <= 1 then
        left_index = #shipList
    else
        left_index = ship_menu.shipSelect - 1
    end
    return shipList[left_index]
end

--Function returns the ship table of the ship to the right
local function get_right()
    local right_index = ship_menu.shipSelect
    if ship_menu.shipSelect >= #shipList then
        right_index = 1
    else
        right_index = ship_menu.shipSelect + 1
    end
    return shipList[right_index]
end






ship_menu.right = function()

    if ship_menu.shipSelect >= #shipList then
        ship_menu.shipSelect = 1
    else
        ship_menu.shipSelect = ship_menu.shipSelect + 1
    end
end

ship_menu.left = function()
    if ship_menu.shipSelect <= 1 then
        ship_menu.shipSelect = #shipList
    else
        ship_menu.shipSelect = ship_menu.shipSelect - 1
    end
end



ship_menu.load = function()
    -- Yes, these are global variables. They will be unloaded when the ship_menu is dismissed.
    ship_menu.titleImage = love.graphics.newImage("assets/sprites/ship_menu/ship_menu.png")
    ship_menu.blinkTimer = 0
    ship_menu.blink = true
    ship_menu.shipSelect = state.activeShip

    ship_menu.title_font = love.graphics.newFont('assets/gnevejpixel.ttf', 30)
    ship_menu.font = love.graphics.newFont(14)
end

ship_menu.unload = function()
   -- ship_menu.titleImage = nil
    ship_menu.blinkTimer = nil
    ship_menu.blink = nil
    ship_menu.shipSelect = nil
end

ship_menu.key_map = {
    escape = function()
        love.event.quit()
    end,
    b = function()
        state.debugOn = not state.debugOn
    end,
    p = function()
        ship_menu.load_ship()
    end,
    left = function()
        ship_menu.left()
    end,
    right = function()
        ship_menu.right()
    end,
    ['return'] = function()
        ship_menu.load_ship()
    end,
}
ship_menu.load_ship = function()
    -- If selected ship is the same, just unpause...
    if state.activeShip == ship_menu.shipSelect then
        state.shipMenu = not state.shipMenu
        ship_menu.unload()
        love.audio.play(sounds.chirp_down)
        -- ...or else load a new ship
    else
        --Entity.list = {}
        loadShip(ship_menu.shipSelect)

        state.shipMenu = not state.shipMenu
        --ship_menu.unload()
        love.audio.play(sounds.chirp_down)
    end
end

ship_menu.draw = function()
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

    -- Draw ship_menu image background
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(ship_menu.titleImage, verticies[1], verticies[2])

    -- Draw text
    if ship_menu.blink then
        love.graphics.setFont(ship_menu.font)
        local name = shipList[ship_menu.shipSelect].displayName
        love.graphics.print(name, corner[1] + 400 - string.len(name) * 8, corner[2] + 145, 0, 2, 2)
    end
    love.graphics.setFont(ship_menu.title_font)
    love.graphics.print('Select Ship', corner[1] + 210, corner[2] + 35, 0, 2, 2)

    -- Center ship variables
    local ship = shipList[ship_menu.shipSelect]
    local image = Textures[ship.spritesheet.image]

    -- Left ship variables
    local left_ship = get_left()
    local left_image = Textures[left_ship.spritesheet.image]

    -- Right ship variables
    local right_ship = get_right()
    local right_image = Textures[right_ship.spritesheet.image]

    if image ~= nil then
        -- Do some neat math to center the ship image on screen
        local shift_x = image:getPixelWidth() * (ship.spritesheet.scale_x + 1) / 2
        local shift_y = image:getPixelHeight() * (ship.spritesheet.scale_x + 1) / 2

        -- Draw a preview of the currently selected ship at normal scale + 1 (Inflated)
        love.graphics.draw(image, corner[1] + 400 - shift_x, corner[2] + 240 + shift_y, 0, ship.spritesheet.scale_x + 1)

        shift_x = left_image:getPixelWidth() * (left_ship.spritesheet.scale_x + 0.5) / 2 + left_image:getPixelWidth()
        shift_y = left_image:getPixelHeight() % 64

        -- Draw a preview of the left option
        love.graphics.draw(left_image, corner[1] + 250 - shift_x, corner[2] + 240 + shift_y, 0, left_ship.spritesheet.scale_x + 0.5)

        shift_x = right_image:getPixelWidth() * (right_ship.spritesheet.scale_x + 0.5) / 2 - right_image:getPixelWidth()
        shift_y = right_image:getPixelHeight() % 64

        -- Draw a preview of the right option
        love.graphics.draw(right_image, corner[1] + 550 + shift_x, corner[2] + 240 + shift_y, 0, right_ship.spritesheet.scale_x + 0.5)
    end


    --[[if ship_menu.blink == true then
        love.graphics.setColor({1, 0, 0, 1})
        love.graphics.rectangle('line', corner[1], corner[2],
        state.camera.window_width, state.camera.window_height)
    end]]--
end

ship_menu.update = function(dt)
    -- Blink timer for visual effect
    ship_menu.blinkTimer = ship_menu.blinkTimer + dt
    if ship_menu.blinkTimer > 0.80 and ship_menu.blink == true then
        ship_menu.blinkTimer = 0
        ship_menu.blink = not ship_menu.blink
    elseif ship_menu.blinkTimer > 0.2 and ship_menu.blink == false then
        ship_menu.blinkTimer = 0
        ship_menu.blink = not ship_menu.blink
    end
end

return ship_menu
