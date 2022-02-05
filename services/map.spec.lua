local Map = require 'services/map'
local Textures = require 'services/textures'

describe('Map Service', function()
    Textures.load()

    it('loads & draws "happy"', function()
        Map.load("happy")
        Map.draw()
    end)

    it('loads & draws "no_planets"', function()
        Map.load("no_planets")
        Map.draw()
    end)

    it('loads & draws "test"', function()
        Map.load("test")
        Map.draw()
    end)
end)
