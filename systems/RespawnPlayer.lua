-- Destroys player entity after copying it's values to a newly spawned one
local System = require('lib/system')
local Entity = require 'services/entity'

return System(
    {'_entity','-isControlled'},
    function(entity)

    end
)
