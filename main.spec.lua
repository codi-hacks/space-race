local Love = require 'services/love'
require 'main'

describe('Main Program', function()
    it('should expose lifecycle hooks', function()
        assert.equal('function', type(Love.draw))
        assert.equal('function', type(Love.load))
        assert.equal('function', type(Love.update))
    end)

    it('should load', function()
        Love.load({})
    end)

    it('should update', function()
        Love.update(0.00025)
    end)

    it('should draw', function()
        Love.draw()
    end)
end)
