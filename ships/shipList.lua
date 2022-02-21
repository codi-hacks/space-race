--[[
    This is a table of all ships available
    All ships have a:
    displayName - The display name of the ship.
    shape with:
        points
        type
    spritesheet with:
        image
        offset_x
        scale_x
    description - A string that describes anyhing interesting about the ship
    speed - Force modifier value for acceleration
    handling - Force modifer value for turning, braking, etc...

        - J.R.C 2/1/22
]]

local ship = require('ships/ship')
local ship_2 = require('ships/ship_2')
local ship_ufo = require('ships/ship_2')
local ship_shuttle = require('ships/ship_shuttle')
local ship_shuttle_2 = require('ships/ship_shuttle_2')
local ship_purple = require('ships/ship_purple')
local ship_green = require('ships/ship_green')
local ship_big = require('ships/ship_big')

return {
    [1] = ship,
    [2] = ship_2,
    [3] = ship_ufo,
    [4] = ship_shuttle,
    [5] = ship_shuttle_2,
    [6] = ship_purple,
    [7] = ship_green,
    [8] = ship_big
}
