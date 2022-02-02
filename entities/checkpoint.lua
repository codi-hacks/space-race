return function()
    local CompleteLevel = require 'systems/CompleteLevel'

    return {
        body = {
            type = 'static'
        },
        fixture = {
            category = 1,
            mask = 65535
        },
        on_begin_contact = function(_, entity_b)
            CompleteLevel(entity_b)
        end,
        on_end_contact = function(self, entity_b)
            if entity_b.isControlled and self.sprite.name ~= 'close' then
                self.sprite = self.spritesheet.actions.close:clone()
                entity_b.checkpoints = entity_b.checkpoints - 1
            end
        end,
        on_pre_solve = function(_, _, contact)
            contact:setEnabled(false)
        end,
        shape = {
            type = 'rectangle',
            width = 64,
            height = 256,
            offset_x = 32,
            offset_y = 128
        },
        spritesheet = {
            image = 'checkpoint',
            width = 32,
            scale_x = 2,
            actions = {
                default = {
                    duration = 0.2,
                    frames = { '2-3', 1 }
                },
                close = {
                    frames = { 1, 1 }
                }
            }
        }
    }
end
