-- Call any update functions that need to be updated

System = require('/lib/system')

UpdateEntities = System(
    {'update'},
    function(updateFunction)
        updateFunction()
    end
)

return UpdateEntities
