local Love = require 'services/love'

local sounds = {}

sounds.bonk = Love.audio.newSource('/assets/sounds/bonk.mp3', 'stream')
sounds.engine = Love.audio.newSource('/assets/sounds/engine_normal.mp3', 'stream')
sounds.braking = Love.audio.newSource('/assets/sounds/engine_braking.mp3', 'stream')
sounds.chirp_up = Love.audio.newSource('/assets/sounds/chirp_up.mp3', 'stream')
sounds.chirp_down = Love.audio.newSource('/assets/sounds/chirp_down.mp3', 'stream')

return sounds
