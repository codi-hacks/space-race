local checkpoint_factory = require 'entities/checkpoint'

return function()
    local checkpoint = checkpoint_factory()

    checkpoint.on_pre_solve = function(self, entity_b, contact)
        if entity_b.isControlled and self.sprite.name == 'default' then
            contact:setEnabled(false)
        end
    end

    checkpoint.spritesheet = {
        image = 'checkpoint-gate',
        width = 32,
        scale_x = 2,
        actions = {
            default = {
                frames = { 1, 1 }
            },
            close = {
                duration = 0.05,
                frames = { '2-10', 1 },
                on_loop = function(animation)
                    animation:gotoFrame(9)
                end
            },
            open = {
                duration = 0.05,
                frames = { '10-2', 1 }
            }
        }
    }

    return checkpoint
end
