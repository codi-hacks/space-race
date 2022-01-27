-- Controls all objects with self.isControlled = true (typically just the player)

local System = require('lib/system')
local speedBoost = require('cc/SpeedBoost')
local state = require('state')
local Entity = require('services/entity')
-- Stolen from here https://love2d.org/wiki/BoundingBox.lua
function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and
        x2 < x1 + w1 and
        y1 < y2 + h2 and
        y2 < y1 + h1
end

local function customCollision(entity)
    for index, data in ipairs(Entity.list) do
        -- entity is the the custom collision items
        -- data is the player
        if data.isControlled then
            if CheckCollision(entity.body:getX(), entity.body:getY(), 32, 32, data.body:getX(), data.body:getY(), 32, 32) then
                if entity.speedBoost then
                    speedBoost.boost(data, entity);
                end
            end
        end
    end
end
return System(
    { '_entity', '-customCollision' },
    function(entity)
        customCollision(entity)
    end
)
