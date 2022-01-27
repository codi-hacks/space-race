local keyboard = require('services/keyboard')

local speedBoost = {}

function speedBoost.boost(player, speedBoost)
    print("Speed Boost");
    keyboard.boost= 100
end

return speedBoost
