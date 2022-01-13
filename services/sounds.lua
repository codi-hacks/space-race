local sounds = {}

sounds.load = function()
    sounds.bonk = love.audio.newSource('/assets/sounds/bonk.mp3', 'stream')
    sounds.engine = love.audio.newSource('/assets/sounds/engine_normal.mp3', 'stream')
    sounds.braking = love.audio.newSource('/assets/sounds/engine_braking.mp3', 'stream')
    sounds.chirp_up = love.audio.newSource('/assets/sounds/chirp_up.mp3', 'stream')
    sounds.chirp_down = love.audio.newSource('/assets/sounds/chirp_down.mp3', 'stream')
end

return sounds
