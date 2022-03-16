local sounds = require('services/sounds')
local shipList = require('ships/shipList')
local State = require('services/state')
local Textures = require('services/textures')

local Save = require('services/save')

--[[
   Menu template code by Trevor. Thanks!

   Additions by J.R.C 2/4/22
]]

local ship_menu = {}

-- checks if a ship is unlocked
-- @param index - index of the ship
-- @return true if unlocked
local function is_unlocked(index)
    for _, e in ipairs(State.unlocked_ships) do
        if index == e then
            return true
        end
    end
    return false
end

--Function returns the index of the ship to the left
local function get_left_index()
    local left_index = ship_menu.shipSelect
    if left_index <= 1 then
        left_index = #shipList
    else
        left_index = ship_menu.shipSelect - 1
    end
    return left_index
end

--Function returns the index of the ship to the right
local function get_right_index()
    local right_index = ship_menu.shipSelect
    if right_index >= #shipList then
        right_index = 1
    else
        right_index = ship_menu.shipSelect + 1
    end
    return right_index
end

--Function returns the ship table of the ship to the left
local function get_left()
    return shipList[get_left_index()]
end

--Function returns the ship table of the ship to the right
local function get_right()
    return shipList[get_right_index()]
end

-- Function toggles the selected option
-- on the ship unlock prompt
local function toggle_unlock_option()
    if ship_menu.unlock_option == 0 then
        ship_menu.unlock_option = 1
    else
        ship_menu.unlock_option = 0
    end
end

local function unlock_ship()
    local price = shipList[ship_menu.shipSelect].price
    local creds = State.credits

    local can_afford = price <= creds

    if not can_afford then
        -- Play a denial sound here
        love.audio.stop()
        love.audio.play(sounds.chirp_deny)
    else
        State.credits = State.credits - price
        table.insert(State.unlocked_ships, ship_menu.shipSelect)
        -- Save the ship and new credit amount
        Save.write()

        love.audio.play(sounds.chirp_down)
        ship_menu.unlock_store = false
    end
end

local function unlock_all_ships()
    for i, _ in ipairs(shipList) do
        local unlocked = false
        for _, v in ipairs(State.unlocked_ships) do
            if i == v then
                unlocked = true
                break
            end
        end

        if not unlocked then
            table.insert(State.unlocked_ships, i)
            -- Save the ship and new credit amount
        end
    end
    Save.write()
end

ship_menu.enter = function()

    if ship_menu.unlock_store ~= true then
        if is_unlocked(ship_menu.shipSelect) then
            ship_menu.unlock_store = false
            ship_menu.load_ship()
            return true
        else
            ship_menu.unlock_store = true
            love.audio.play(sounds.chirp_up)
            return false
        end
    else
        if ship_menu.unlock_option == 1 then
            unlock_ship()
        else
            ship_menu.unlock_store = false
            love.audio.play(sounds.chirp_down)
        end
    end
end
ship_menu.key_map = {
    -- DEBUG REMOVE BEFORE RELEASE
    a = function()
        unlock_all_ships()
    end,
    escape = function()
        if ship_menu.unlock_store then
            ship_menu.unlock_store = false
            love.audio.play(sounds.chirp_down)
        else
            -- If we are not in the unlock ship prompt
            -- Go back to main menu
            State.menu.state = 'map_select'
        end
    end,
    backspace = function()
        if ship_menu.unlock_store then
            ship_menu.unlock_store = false
            love.audio.play(sounds.chirp_down)
        else
            -- If we are not in the unlock ship prompt
            -- Go back to main menu
            State.menu.state = 'map_select'
        end
    end,
    right = function()
        if ship_menu.unlock_store then
            toggle_unlock_option()
            love.audio.stop()
            love.audio.play(sounds.menu_click)
        else
            -- If we are not in the unlock ship prompt
            if ship_menu.shipSelect >= #shipList then
                ship_menu.shipSelect = 1
            else
                ship_menu.shipSelect = ship_menu.shipSelect + 1
            end
            love.audio.stop()
            love.audio.play(sounds.menu_click)
        end
    end,
    left = function()

        if ship_menu.unlock_store then
            toggle_unlock_option()
            love.audio.stop()
            love.audio.play(sounds.menu_click)
        else
            -- If we are not in the unlock ship prompt
            if ship_menu.shipSelect <= 1 then
                ship_menu.shipSelect = #shipList
            else
                ship_menu.shipSelect = ship_menu.shipSelect - 1
            end
            love.audio.stop()
            love.audio.play(sounds.menu_click)
        end
    end,

}

ship_menu.load = function()
    -- Yes, these are global variables. They will be unloaded when the ship_menu is dismissed.
    ship_menu.titleImage = love.graphics.newImage("assets/sprites/menu_images/ship_menu.png")
    State.menu.blink = true
    ship_menu.shipSelect = State.activeShip

    ship_menu.title_font = love.graphics.newFont('assets/gnevejpixel.ttf', 30)
    ship_menu.medium_font = love.graphics.newFont('assets/gnevejpixel.ttf', 24)
    ship_menu.font = love.graphics.newFont(14)
    ship_menu.x2font = love.graphics.newFont(28)
    ship_menu.x2p5font = love.graphics.newFont(35)
    ship_menu.description_font = love.graphics.newFont(12)

    -- Flag to present unlock store
    ship_menu.unlock_store = false
    -- Selected option in unlock store
    -- 0 is no, 1 is yes
    ship_menu.unlock_option = 0
end

ship_menu.unload = function()
   -- ship_menu.titleImage = nil
    ship_menu.shipSelect = nil

    ship_menu.title_font = nil
    ship_menu.medium_font = nil
    ship_menu.font = nil
    ship_menu.description_font = nil

    ship_menu.unlock_store = nil
    ship_menu.unlock_option = nil
end

ship_menu.load_ship = function()
        State.activeShip = ship_menu.shipSelect
        State.menu.state = nil
        love.audio.play(sounds.chirp_down)
end

ship_menu.draw_unlock_store = function(corner)
    -- Draw unlock prompt
    love.graphics.setColor(0.1, 0.1, 0.1, 1.0)
    -- Draw background rect
    local verticies = {
        100 + corner[1], 200 + corner[2],
        100 + corner[1], 398 + corner[2],
        700 + corner[1], 398 + corner[2],
        700 + corner[1], 200 + corner[2] }
    love.graphics.polygon('fill', verticies)
    -- Draw text stating price of ship
    local price = shipList[ship_menu.shipSelect].price
    local creds = State.credits
    local can_afford = price <= creds
    if can_afford then
        love.graphics.setColor(0, 1, 0, 1)
    else
        love.graphics.setColor(1, 0, 0, 1)
    end
    love.graphics.setFont(ship_menu.x2p5font)
    local title_string = 'Unlock for ' .. price .. ' Credits?'
    love.graphics.printf(title_string, corner[1] + 100, corner[2] + 210,  600, "center", 0, 1, 1)
    love.graphics.setColor(1, 1, 1, 1)
    local credit_string = 'You have ' .. State.credits .. " Credits"
    love.graphics.setFont(ship_menu.x2font)
    love.graphics.printf(credit_string, corner[1] + 100, corner[2] + 260,  600, "center", 0, 1, 1)

    -- Draw preview of the ship in the center
    -- Center ship variables
    local ship = shipList[ship_menu.shipSelect]
    local image = Textures[ship.spritesheet.image]
    -- Normalize preview to 128x128
    local scale_x = 64 / image:getPixelWidth()
    local scale_y = 64 / image:getPixelHeight()
     -- Do some neat math to center the ship image on screen
     local shift_x = image:getPixelWidth() * (scale_x) / 2
     local shift_y = image:getPixelHeight() * (scale_y) / 2

    local scale_mod_x = (
        image:getWidth() / ship.spritesheet.width
    )
    local scale_mod_y = (
        image:getHeight() / ship.bottom_y
    )

    local quad = love.graphics.newQuad(
        0, 0, ship.spritesheet.width, image:getHeight(),
        image:getWidth(), image:getHeight()
    )

     -- Draw a preview of the left option at 64x64
     love.graphics.draw(
        image, quad,
        corner[1] + 400 - shift_x, corner[2] + 280 + shift_y,
        0,
        scale_x * scale_mod_x,
        scale_y * scale_mod_y
    )


    -- Draw Yes/No options
    love.graphics.setFont(ship_menu.x2font)
    if ship_menu.unlock_option == 0 then
        love.graphics.printf("> No <", corner[1] + 370, corner[2] + 320,  300, "center", 0, 1.0, 1.0)
        if can_afford ~= true then
            love.graphics.setColor(0.2, 0.2, 0.2, 0.9)
        end
        love.graphics.printf("Yes", corner[1] + 130, corner[2] + 320,  300, "center", 0, 1.0, 1.0)
    else
        love.graphics.printf("No", corner[1] + 370, corner[2] + 320,  300, "center", 0, 1.0, 1.0)
        if can_afford ~= true then
            love.graphics.setColor(0.2, 0.2, 0.2, 0.9)
        end
        love.graphics.printf("> Yes <", corner[1] + 130, corner[2] + 320,  300, "center", 0, 1.0, 1.0)
    end



end

ship_menu.draw = function()
    -- Alias the true corner coordinates for convienience
    local corner = { State.camera.pos_x, State.camera.pos_y }

    -- Draw ship_menu image background
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(ship_menu.titleImage, corner[1], corner[2])

    -- Draw text
    if State.menu.blink then
        love.graphics.setFont(ship_menu.x2font)
        local name = shipList[ship_menu.shipSelect].displayName
        love.graphics.printf(name, corner[1] + 252, corner[2] + 143,  300, "center", 0, 1, 1)
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

        if is_unlocked(ship_menu.shipSelect) == false then
            love.graphics.setColor(1, 1, 1, 1)
            -- Draw locks
            love.graphics.draw(Textures['lock'], corner[1] + 245, corner[2] + 143)
            love.graphics.draw(Textures['lock'],  corner[1] + 532, corner[2] + 143)
            love.graphics.setColor(1.0, 0.5, 0.5, 0.5)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end

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

        if is_unlocked(get_left_index()) == false then
            love.graphics.setColor(1.0, 0.5, 0.5, 0.5)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end

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

        if is_unlocked(get_right_index()) == false then
            love.graphics.setColor(1.0, 0.5, 0.5, 0.5)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end

        -- Draw a preview of the right option at 64x64
        love.graphics.draw(
            right_image, quad_right,
            corner[1] + 580 + shift_x, corner[2] + 240 + shift_y,
            0,
            right_scale_x * scale_mod_x,
            right_scale_y * scale_mod_y
        )

        if is_unlocked(ship_menu.shipSelect) == false then
            love.graphics.setColor(1.0, 0.1, 0.1, 1.0)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end

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
        if is_unlocked(ship_menu.shipSelect) == false then
            love.graphics.printf("LOCKED", corner[1] + 115, corner[2] + 450,  300, "left", 0, 1, 1)
        end
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

        if ship_menu.unlock_store then
            ship_menu.draw_unlock_store(corner)
        end


    end
end

ship_menu.update = function()
    -- nothing for now!
end

return ship_menu
