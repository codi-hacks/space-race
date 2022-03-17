-- luacheck: allow defined
local love = {}

assert(jit ~= nil, '"jit" global not found. Is this LuaJIT?')
local is_windows = jit.os == 'Windows'

-- Encode or decode strings as base64
-- Borrowed from http://lua-users.org/wiki/BaseSixtyFour
local base64 = {
    -- character table string
    chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/',
    decode = function(self, data)
      assert(
        type(data) == 'string',
        'Attempting to base64 decode a non-string value. Got "' ..
        type(data) .. '".'
      )
      data = string.gsub(data, '[^' .. self.chars .. '=]', '')
      local replace1 = function(x)
        if (x == '=') then return '' end
        local r = ''
        local f = (self.chars:find(x) - 1)
        for i = 6, 1, -1 do
          r = r .. (f % 2^i - f % 2^(i - 1) > 0 and '1' or '0')
        end
        return r
      end
      local replace2 = function(x)
        if (#x ~= 8) then return '' end
        local c = 0
        for i = 1 , 8 do
          c = c + (x:sub(i, i )== '1' and 2^(8 - i) or 0)
        end
        return string.char(c)
      end
      return (data:gsub('.', replace1):gsub('%d%d%d?%d?%d?%d?%d?%d?', replace2))
    end,
    encode = function(self, data)
      assert(
        type(data) == 'string',
        'Attempting to base64 encode a non-string value. Got "' ..
        type(data) .. '".'
      )
      local replace1 = function(x)
        local r, b = '', x:byte()
        for i = 8, 1, -1 do
          r = r .. (b % 2^i - b % 2^(i - 1) > 0 and '1' or '0')
        end
        return r
      end
      local replace2 = function(x)
        if (#x < 6) then return '' end
        local c = 0
        for i = 1, 6 do c = c + (x:sub(i, i) == '1' and 2^(6 - i) or 0) end
        return self.chars:sub(c + 1, c + 1)
      end
      local ret = data:gsub('.', replace1) .. '0000'
      ret = ret:gsub('%d%d%d?%d?%d?%d?', replace2)
      ret = ret .. ({ '', '==', '=' })[#data% 3 + 1]
      return ret
    end
}

love.audio = {}
love.audio.newSource = function() end
love.audio.play = function() end
love.audio.setVolume = function() end

love.data = {}
love.data.decode = function(container, format, str)
    assert(container, 'string', 'only string container decoding is implemented in this mock... sorry about that...')
    assert(format, 'base64', 'only base64 decoding is implemented in this mock... sorry about that... so so sorry')
    return base64:decode(str)
end

love.filesystem = {}
love.filesystem.getDirectoryItems = function(directory)
    directory = directory:gsub("^/", "")
    local i, t, popen = 0, {}, io.popen
    local pfile
    if is_windows then
        pfile = popen('dir "'..directory..'" /b /ad')
    else
        pfile = popen('ls -a "'..directory..'"')
    end
    for filename in pfile:lines() do
            i = i + 1
            t[i] = filename
    end
    pfile:close()
    return t
end
love.filesystem.read = function(file_path)
    file_path = file_path:gsub("^/", "")
    local file = io.open(file_path, "r")
    local content = file:read('*all')
    file:close()
    return content
end
love.filesystem.load = function(file_path)
    return function()
        local v1={["lastShip"]=1,["time"]="2:33:44",["credits"]=18}
        return v1
    end
end
love.filesystem.write = function(file_path, data)
    return {}
end
love.filesystem.getInfo = function(file_path)
    return {}
end

love.graphics = {}
love.graphics.circle = function() end
love.graphics.draw = function() end
love.graphics.getDimensions = function()
    return 512, 512
end
love.graphics.newImage = function()
    return {
        getHeight = function()
            return 512
        end,
        getWidth = function()
            return 512
        end
    }
end
love.graphics.newQuad = function()
    return {
        getViewport = function()
            return nil, nil, 32, 32
        end
    }
end
love.graphics.newShader = function()
    return {}
end
love.graphics.polygon = function()
    return true
end
love.graphics.pop = function() end
love.graphics.print = function() end
love.graphics.push = function() end
love.graphics.rotate = function() end
love.graphics.scale = function() end
love.graphics.setColor = function()
    return true
end
love.graphics.setDefaultFilter = function() end
love.graphics.setNewFont = function() end
love.graphics.newFont = function() end
love.graphics.setFont = function() end
love.graphics.translate = function() end

love.keyboard = {}
love.keyboard.hasKeyRepeat = function()
    return false
end
love.keyboard.isDown = function()
    return false
end
love.keyboard.isScancodeDown = function()
    return false
end

love.math = {}
-- TODO, implement real decompression
love.math.decompress = function()
    -- Ascii representation of the decompressed byte string
    return base64:decode('pAAAAKQAAACkAAAAoQAAAA==')
end
love.math.random = function()
    return 4 -- chosen by fair dice roll. guaranteed to be random.
end

love.physics = {}
love.physics.newBody = function()
    return {
        __angle = 0,
        __x = 0,
        __y = 0,
        getAngle = function(self)
            return self.__angle
        end,
        getX = function(self)
            return self.__x
        end,
        getY = function(self)
            return self.__y
        end,
        setAngle = function(self, value)
            self.__angle = value
        end,
        setX = function(self, value)
            self.__x = value
        end,
        setY = function(self, value)
            self.__y = value
        end,
        setFixedRotation = function() end,
        getWorldPoints = function() end
    }
end
love.physics.newCircleShape = function()
    return {
        'circle',
        getType = function()
            return 'circle'
        end,
        getPoint = function() end
    }
end
love.physics.newFixture = function(body, shape)
    return {
        body = body,
        getBody = function()
            return body
        end,
        getShape = function()
            return shape
        end,
        getUserData = function(self)
            return self.__userData
        end,
        setDensity = function() end,
        setFilterData = function() end,
        setFriction = function() end,
        setGroupIndex = function() end,
        setUserData = function(self, value)
            self.__userData = value
        end,
        shape = shape
    }
end
love.physics.newPolygonShape = function()
    return {
        'polygon',
        getType = function()
            return 'polygon'
        end
        ,
        getPoints = function() end
    }
end
love.physics.newRectangleShape = function()
    return {
        'polygon',
        getType = function()
            return 'polygon'
        end,
        getPoints = function() end
    }
end
love.physics.newWorld = function()
    local world = {}
    function world:setCallbacks()
        return self
    end
    function world:setContactFilter()
        return self
    end
    return world
end
love.physics.setMeter = function() end

love.window = {}
love.window.setMode = function() end
love.window.updateMode = function() end

return love
