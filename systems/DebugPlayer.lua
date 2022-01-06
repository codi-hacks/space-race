local System = require('lib/system')
local debug = require('services/debug')

return System(
    { '_entity','-isControlled' },
    function(entity)
        debug(entity)
    end
)
