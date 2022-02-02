return function()
    return {
        body = {
            type = 'static'
        },
        fixture = {
            category = 1,
            mask = 65535
        },
        on_end_contact = function(self, entity_b, contact)
            contact:setEnabled(false)
            if entity_b.isControlled and self.sprite.name ~= 'close' then
                self.sprite = self.spritesheet.actions.close:clone()
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
