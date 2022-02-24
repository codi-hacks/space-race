_G.love = require 'lib/love'
local Map = require 'services/map'
local Textures = require 'services/textures'
local mapList = require 'maps/mapList'

describe('Map Service', function()
    Textures.load()

    for map in mapList do
        it('loads & draws ' .. map.displayName , function()
            Map.load(map.filename)
            Map.draw()
        end)
    end
end)
