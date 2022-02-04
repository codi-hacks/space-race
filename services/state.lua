-- Initialize table to keep track of game state

local State = {}

State.paused = true
State.debugOn = false
State.activeMap = -1

-- Ship stuff duh - J.R.C 2/2/22
State.shipMenu = false;
State.activeShip = 1

State.camera = {} -- Initialized in /camera.lua

State.credits = -1 -- True value loaded in services/save.lua

return State
