-- Initialize table to keep track of game state

state = {}

state.paused = false
state.debugOn = false
state.activeMap = {filename = 'happy'}

state.camera = {} -- Initialized in /camera.lua

return state
