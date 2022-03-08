-- Initialize table to keep track of game state
local world = require('services/world')
local State = {}

State.paused = true
State.debugOn = false

-- Active map stuff
State.activeMap = -1
State.base_creds = 0 -- Base creds for beating active map
State.silver = 0.0 -- Time to beat to get x2 cred + unlock next map
State.gold = 0.0  -- Time to beat to get x3 cred + unlock next map

-- Ship stuff duh - J.R.C 2/2/22
State.shipMenu = false;
State.activeShip = 1

-- Unlocks and progess - J.R.C 3/8/22
State.unlocked_maps = 2 -- Starts at 1 (Happy.tmx)

State.camera = {} -- Initialized in /camera.lua

State.credits = 0 -- True value loaded in services/save.lua

State.seconds = 0 -- Keep track of map times.
State.lastCompletedTime = 0
State.world = love.physics.newWorld(0, 0)

State.world:setCallbacks(world.begin_contact_callback, world.end_contact_callback, world.pre_solve_callback, nil)


return State
