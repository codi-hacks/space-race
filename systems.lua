local System = require('lib/system')
require('objects')

systems = {}

systems.spawnObjects = System(
    {'position', 'body'},
    function(position, body)
        body:setX(position.x)
        body:setY(position.y)
    end
)

return systems