--- RegisterSprites
-- Load graphics for spawning sprites

local System = require 'lib/system'

local Anim8 = require 'lib/anim8'
local textures = require 'services/textures'

local components = {
    '_entity',
    '=spritesheet'
}

local system = function(entity, spritesheet)
    assert(textures[spritesheet.image], 'Attempted to load undefined sprite: "' .. spritesheet.image .. '"')

    local loaded_set = {}
    loaded_set.image = textures[spritesheet.image]
    loaded_set.actions = {}
    loaded_set.offset_x = spritesheet.offset_x
    loaded_set.offset_y = spritesheet.offset_y
    loaded_set.scale_x = spritesheet.scale_x
    loaded_set.scale_y = spritesheet.scale_y
    local img_w = loaded_set.image:getWidth()
    local img_h = loaded_set.image:getHeight()

    -- Entities we didn't specify actions are typically 1-frame static images
    local spritesheet_actions = spritesheet.actions or {
        default = {
            frames = { 1, 1 }
        }
    }

    for key, sprite_action in pairs(spritesheet_actions) do
        local grid = Anim8.newGrid(
            sprite_action.width or spritesheet.width or img_w,
            sprite_action.height or spritesheet.height or img_h,
            img_w,
            img_h,
            sprite_action.x or spritesheet.x or 0,
            sprite_action.y or spritesheet.y or 0,
            sprite_action.gap or spritesheet.gap or 0
        )

        local frames = sprite_action.frames or spritesheet.frames or { 1, 1 }

        loaded_set.actions[key] = Anim8.newAnimation(
            grid:getFrames(unpack(frames)),
            sprite_action.duration or spritesheet.duration or 1,
            sprite_action.on_loop or spritesheet.on_loop or nil
        )
        -- I know we don't own this table but
        -- what's the worst that could happen...
        loaded_set.actions[key].offset_x = sprite_action.offset_x
        loaded_set.actions[key].offset_y = sprite_action.offset_y
        -- When this sprite action is active, you can check
        -- the name to understand what the entity is doing.
        loaded_set.actions[key].name = key
    end

    -- Initialize the default sprite
    entity.sprite = loaded_set.actions.default:clone()

    return loaded_set
end

return System(components, system)
