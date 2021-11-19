sounds = {}

sounds.loadSounds = function()
    sounds.bonk = love.audio.newSource('sounds/bonk.mp3', 'stream')
    sounds.engine = love.audio.newSource('sounds/engine.mp3', 'stream')
end

return sounds