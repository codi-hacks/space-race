-- Call any draw functions that need to be drawn

System = require('/lib/system')

DrawEntities = System(
    {'draw'},
    function(drawFunction)
        drawFunction()
    end
)

return DrawEntities
