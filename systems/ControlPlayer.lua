-- Controls all objects with self.isControlled = true (typically just the player)

Systems = require('/lib/system')

ControlPlayer = System(
    {'-isControlled', 'body'},
    function(body)
        keyboard.move(body, love.timer.getDelta())
    end
)

return ControlPlayer
