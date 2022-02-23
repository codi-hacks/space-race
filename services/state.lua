-- Initialize table to keep track of game state
local world = require('services/world')
local State = {}

State.paused = true
State.debugOn = false
State.activeMap = -1

-- Ship stuff duh - J.R.C 2/2/22
State.shipMenu = false;
State.activeShip = 1

State.camera = {} -- Initialized in /camera.lua

State.credits = 0 -- True value loaded in services/save.lua

State.seconds = 0 -- Keep track of map times.
State.lastCompletedTime = 0
State.world = love.physics.newWorld(0, 0)

State.world:setCallbacks(world.begin_contact_callback, world.end_contact_callback, world.pre_solve_callback, nil)


return State
