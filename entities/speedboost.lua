
local boost = function(_, player)
    player.powerUps.speedBoost = { value = 100, time = 100 };
end
return function()
    return {
        body = {
            mass = 0
        },
        onCollision = boost,
        shape = {
            type = 'rectangle',
            width =32,
            height=32,
            offset_x =16,
            offset_y=16
        },
        spritesheet = {
            image = 'speedboost',
        }
    }
end
