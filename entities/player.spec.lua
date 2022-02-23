_G.love = require 'lib/love'
local player = require('entities/player')

local assert_props = function(props, idx)
    local assert_prop = function(prop)
        assert(props[prop], 'missing ' .. prop .. ' for ship index ' .. idx)
    end

    assert_prop('spritesheet')
    assert(props.spritesheet.image, 'missing ship spritesheet.image')

    assert_prop('body')
    assert_prop('fixture')
    assert_prop('gravitational_mass')
    assert_prop('shape')
    assert_prop('spritesheet')
    assert_prop('damping_force')
    assert_prop('braking_force')
    assert_prop('turning_force')
    assert_prop('thrust_force')
    assert_prop('max_spin')
    assert_prop('max_velocity')
end

describe('Player Entity', function()
    it('sets a default ship type if none specified', function()
        local p = player({})
        assert(p.spritesheet, 'no default ship type set!')
    end)

    it('has the required aspects for all variants', function()
        assert_props(player({}), 0)

        for idx = 1, 8 do
            assert_props(player({ ship_type = idx }), idx)
        end
    end)
end)
