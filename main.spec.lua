_G.love = require 'lib/love'
require 'main'

describe('Main Program', function()
    it('should expose lifecycle hooks', function()
        assert.equal('function', type(love.draw))
        assert.equal('function', type(love.load))
        assert.equal('function', type(love.update))
    end)

    it('should load', function()
        love.load({})
    end)

    it('should update', function()
        love.update(0.00025)
    end)

    it('should draw', function()
        love.draw()
    end)
end)
