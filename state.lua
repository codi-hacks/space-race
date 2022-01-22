-- Initialize table to keep track of game state

state = {}

state.paused = true
state.debugOn = false
state.activeMap = 1

state.camera = {} -- Initialized in /camera.lua

return state
