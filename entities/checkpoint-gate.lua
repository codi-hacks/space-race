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
        on_pre_solve = function(self, entity_b, contact)
            if entity_b.isControlled and self.sprite.name == 'default' then
                contact:setEnabled(false)
            end
        end,
        shape = {
            type = 'rectangle',
            width = 64,
            height = 256,
            offset_x = 32,
            offset_y = 128
        },
        spritesheet = {
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
    }
end
