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
end)
