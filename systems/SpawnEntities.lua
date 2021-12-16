-- Spawn objects at their first position

System = require('/lib/system')

SpawnEntities = System(
    {'position', 'body'},
    function(position, body)
        body:setX(position.x)
        body:setY(position.y)
    end
)

return SpawnEntities
