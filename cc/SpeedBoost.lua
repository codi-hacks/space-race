local keyboard = require('services/keyboard')

local speedBoost = {}

function speedBoost.boost(player, speedBoost)
    player.powerUps.speedBoost = { value = 100, time = 1 };
end

return speedBoost
