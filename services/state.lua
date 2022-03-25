-- Initialize table to keep track of game state
local world = require('services/world')
local State = {}

State.paused = true
State.debugOn = false

-- Active map stuff
State.activeMap = -1
-- True values loaded in map->loadmap
State.base_creds = 0 -- Base creds for beating active map
State.silver = 0.0 -- Time to beat to get x2 cred + unlock next map
State.gold = 0.0  -- Time to beat to get x3 cred + unlock next map

State.menu = {} -- Initialized in /menu/menu.lua

-- Ship stuff duh - J.R.C 2/2/22
State.activeShip = 2
-- Ships that are currently unlocked
State.unlocked_ships = {2} -- Starts off with only ship two

State.camera = {} -- Initialized in /camera.lua

State.credits = 0 -- True value loaded in services/save.lua

State.seconds = 0 -- Keep track of map times.
State.lastCompletedTime = 0
State.world = love.physics.newWorld(0, 0)

State.volume = 1

State.world:setCallbacks(world.begin_contact_callback, world.end_contact_callback, world.pre_solve_callback, nil)


return State
