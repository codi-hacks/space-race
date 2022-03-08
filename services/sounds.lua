local sounds = {}

sounds.bonk = love.audio.newSource('/assets/sounds/bonk.mp3', 'stream')
sounds.engine = love.audio.newSource('/assets/sounds/engine_normal.mp3', 'stream')
sounds.braking = love.audio.newSource('/assets/sounds/engine_braking.mp3', 'stream')
sounds.chirp_up = love.audio.newSource('/assets/sounds/chirp_up.mp3', 'stream')
sounds.chirp_down = love.audio.newSource('/assets/sounds/chirp_down.mp3', 'stream')

sounds.menu_click = love.audio.newSource('/assets/sounds/Flashpoint001d.flac', 'stream')

--[[
    Flashpoint001d.flac
    Author: Tim Mortimer
    URL: http://www.archive.org/details/TimMortimer
    License: Creative Commons Attribution 3.0
    Distributior: OpenGameArt.org
]]

return sounds
