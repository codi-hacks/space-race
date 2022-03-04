local sounds = require('services/sounds')
local shipList = require('ships/shipList')
local State = require('services/state')
local Textures = require('services/textures')

--[[
   Menu template code by Trevor. Thanks!

   Additions by J.R.C 2/4/22
]]

local ship_menu = {}

--Function returns the ship table of the ship to the left
local function get_left()
    local left_index = ship_menu.shipSelect
    if left_index <= 1 then
        left_index = #shipList
    else
        left_index = ship_menu.shipSelect - 1
    end
    return shipList[left_index]
end

--Function returns the ship table of the ship to the right
local function get_right()
    local right_index = ship_menu.shipSelect
    if right_index >= #shipList then
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
    love.audio.stop()
    love.audio.play(sounds.menu_click)
end

ship_menu.left = function()
    if ship_menu.shipSelect <= 1 then
        ship_menu.shipSelect = #shipList
    else
        ship_menu.shipSelect = ship_menu.shipSelect - 1
    end
    love.audio.stop()
    love.audio.play(sounds.menu_click)
end

ship_menu.load = function()
    -- Yes, these are global variables. They will be unloaded when the ship_menu is dismissed.
    ship_menu.titleImage = love.graphics.newImage("assets/sprites/menu_images/ship_menu.png")
    State.menu.blink = true
    ship_menu.shipSelect = State.activeShip

    ship_menu.title_font = love.graphics.newFont('assets/gnevejpixel.ttf', 30)
    ship_menu.font = love.graphics.newFont(14)
    ship_menu.description_font = love.graphics.newFont(12)
end

ship_menu.unload = function()
   -- ship_menu.titleImage = nil
    ship_menu.shipSelect = nil

    ship_menu.title_font = nil
    ship_menu.font = nil
    ship_menu.description_font = nil
end

ship_menu.load_ship = function()
        State.activeShip = ship_menu.shipSelect
        State.menu.state = nil
        love.audio.play(sounds.chirp_down)
end

ship_menu.draw = function()
    -- Alias the true corner coordinates for convienience
    local corner = { State.camera.pos_x, State.camera.pos_y }

    -- Draw ship_menu image background
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(ship_menu.titleImage, corner[1], corner[2])

    -- Draw text
    if State.menu.blink then
        love.graphics.setFont(ship_menu.font)
        local name = shipList[ship_menu.shipSelect].displayName
        love.graphics.printf(name, corner[1] + 208 / 2, corner[2] + 143,  300, "center", 0, 2, 2)
       -- love.graphics.print(name, corner[1] + 400 - string.len(name) * 8, corner[2] + 145, 0, 2, 2)
    end
    love.graphics.setFont(ship_menu.title_font)
    love.graphics.print('Select Ship', corner[1] + 210, corner[2] + 35, 0, 2, 2)

    -- Center ship variables
    local ship = shipList[ship_menu.shipSelect]
    local image = Textures[ship.spritesheet.image]
    -- Normalize all center ship previews to 128x128
    local center_scale_x = 128 / image:getPixelWidth()
    local center_scale_y = 128 / image:getPixelHeight()


    -- Left ship variables
    local left_ship = get_left()
    local left_image = Textures[left_ship.spritesheet.image]
    -- Normalize all left ship previews to 64x64
    local left_scale_x = 64 / left_image:getPixelWidth()
    local left_scale_y = 64 / left_image:getPixelHeight()

    -- Right ship variables
    local right_ship = get_right()
    local right_image = Textures[right_ship.spritesheet.image]

    -- Normalize all right ship previews to 64x64
    local right_scale_x = 64 / right_image:getPixelWidth()
    local right_scale_y = 64 / right_image:getPixelHeight()

    if image ~= nil then
        -- Do some neat math to center the ship image on screen
        local shift_x = image:getPixelWidth() * (center_scale_x) / 2
        local shift_y = image:getPixelHeight() * (center_scale_y) / 2

        -- Draw blinking Square around currently selected ship
        if State.menu.blink then
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.rectangle("line", corner[1] + 400 - shift_x  - 10, corner[2] + 200 + shift_y - 10,  148, 148)


            --Draw line from preview box to actual size
            love.graphics.line(
                corner[1] + 464 - shift_x,
                corner[2] + 338 + shift_y,
                corner[1] + 464 - shift_x + 80,
                corner[2] + 338 + shift_y + 80,
                corner[1] + 464 - shift_x + 280,
                corner[2] + 338 + shift_y + 80
            )

            love.graphics.setColor(1, 1, 1, 1)
        end

        local quad = love.graphics.newQuad(
            0, 0, ship.spritesheet.width, image:getHeight(),
            image:getWidth(), image:getHeight()
        )

        local quad_left = love.graphics.newQuad(
            0, 0, left_ship.spritesheet.width, left_image:getHeight(),
            left_image:getWidth(), left_image:getHeight()
        )

        local quad_right = love.graphics.newQuad(
            0, 0, right_ship.spritesheet.width, right_image:getHeight(),
            right_image:getWidth(), right_image:getHeight()
        )

        local scale_mod_x = (
            image:getWidth() / ship.spritesheet.width
        )
        local scale_mod_y = (
            image:getHeight() / ship.bottom_y
        )

        -- Draw Actual Size Text
        love.graphics.setFont(ship_menu.font)
        love.graphics.printf(
            'Actual Size',
            corner[1] + 464 - shift_x + 85,
            corner[2] + 338 + shift_y + 85,
            100, "left",
            0, 1, 1
        )

        -- Draw a preview of the currently selected ship at 128x128
        love.graphics.draw(
            image, quad,
            corner[1] + 400 - shift_x, corner[2] + 200 + shift_y,
            0,
            center_scale_x * scale_mod_x,
            center_scale_y * scale_mod_y
        )

        -- Also draw the preview at actual scale
        shift_x =
        (
            image:getPixelWidth() / 3 * shipList[ship_menu.shipSelect].spritesheet.scale_x / 2
        )
        shift_y = (
            ship.bottom_y *
            shipList[ship_menu.shipSelect].spritesheet.scale_x / 2
        )
        love.graphics.draw(
            image, quad,
            corner[1] + 680 - shift_x, corner[2] + 480 - shift_y,
            0,
            ship.spritesheet.scale_x
        )


        shift_x = left_image:getPixelWidth() * (left_scale_x) / 2
        shift_y = left_image:getPixelHeight() * (left_scale_y) / 2

        scale_mod_x = (
            left_image:getWidth() / left_ship.spritesheet.width
        )
        scale_mod_y = (
            left_image:getHeight() / left_ship.bottom_y
        )


        -- Draw a preview of the left option at 64x64
        love.graphics.draw(
            left_image, quad_left,
            corner[1] + 220 - shift_x, corner[2] + 240 + shift_y,
            0,
            left_scale_x * scale_mod_x,
            left_scale_y * scale_mod_y
        )

        shift_x = -right_image:getPixelWidth() * (right_scale_x) / 2
        shift_y = right_image:getPixelHeight() * (right_scale_y) / 2

        scale_mod_x = (
            right_image:getWidth() / right_ship.spritesheet.width
        )
        scale_mod_y = (
            right_image:getHeight() / right_ship.bottom_y
        )

        -- Draw a preview of the right option at 64x64
        love.graphics.draw(
            right_image, quad_right,
            corner[1] + 580 + shift_x, corner[2] + 240 + shift_y,
            0,
            right_scale_x * scale_mod_x,
            right_scale_y * scale_mod_y
        )

        -- Draw description text
        love.graphics.setFont(ship_menu.font)
        -- Size takes into account actual pixel display size
        local size = (
            image:getPixelWidth() *
            shipList[ship_menu.shipSelect].spritesheet.scale_x / 32
        )
        local sizeT = "Small"
        if size >= 2 then
            sizeT = "Large"
        elseif size > 1 then
            sizeT = "Medium"
        end

        love.graphics.printf("Description: ", corner[1] + 25, corner[2] + 450,  300, "left", 0, 1, 1)
        love.graphics.setFont(ship_menu.description_font)
        love.graphics.printf(
            "\t Size: " .. sizeT,
            corner[1] + 25, corner[2] + 480,
            300,
            "left", 0, 1, 1
        )
        love.graphics.printf(
            "\t Speed: " .. shipList[ship_menu.shipSelect].speed,
            corner[1] + 25, corner[2] + 500,
            300, "left", 0, 1, 1
        )
        love.graphics.printf(
            "\t Handling: " .. shipList[ship_menu.shipSelect].handling,
            corner[1] + 25, corner[2] + 520,
            300, "left", 0, 1, 1
        )
        love.graphics.printf("\t Notes: ", corner[1] + 25, corner[2] + 540,  600, "left", 0, 1, 1)
        love.graphics.printf(
            shipList[ship_menu.shipSelect].description,
            corner[1] + 90, corner[2] + 540,
            650, "left", 0, 1, 1
        )


    end
end

ship_menu.update = function()
    -- nothing for now!
end

return ship_menu
