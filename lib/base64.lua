-- Encode or decode strings as base64
-- Borrowed from http://lua-users.org/wiki/BaseSixtyFour

-- character table string
local chars='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

local decode = function(data)
  assert(
    type(data) == 'string',
    'Attempting to base64 decode a non-string value. Got "' ..
    type(data) .. '".'
  )
  data = string.gsub(data, '[^' .. chars .. '=]', '')
  local replace1 = function(x)
    if (x == '=') then return '' end
    local r = ''
    local f = (chars:find(x) - 1)
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
end

local encode = function(data)
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
    return chars:sub(c + 1, c + 1)
  end
  local ret = data:gsub('.', replace1) .. '0000'
  ret = ret:gsub('%d%d%d?%d?%d?%d?', replace2)
  ret = ret .. ({ '', '==', '=' })[#data% 3 + 1]
  return ret
end

return {
  decode = decode,
  encode = encode
}
