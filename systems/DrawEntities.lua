-- Call any draw functions that need to be drawn

System = require('/lib/system')

DrawEntities = System(
    {'draw', 'layer'},
    function(drawFunction, layer, currentLayer)
        if layer == currentLayer then
            drawFunction(layer)
        end
    end
)

return DrawEntities
