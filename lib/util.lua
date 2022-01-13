--- Util service
-- Miscellaneous, general-purpose helper functions

local is_array = function(x)
  return (type(x) == "table" and x[1] ~= nil) and true or false
end

local math_atan2 = math.atan2
local math_sqrt = math.sqrt

local function angle(x1, y1, x2, y2)
  return math_atan2(y2 - y1, x2 - x1)
end

local function copy(orig)
  -- Primitive types: number, string, boolean, etc
  if type(orig) ~= 'table' then
    return orig
  end
  local new_table = {}
    for orig_key, orig_value in next, orig, nil do
      new_table[copy(orig_key)] = copy(orig_value)
    end
    setmetatable(new_table, copy(getmetatable(orig)))
  return new_table
end

local function distance(x1, y1, x2, y2, squared)
  local dx = x1 - x2
  local dy = y1 - y2
  local s = dx * dx + dy * dy
  return squared ~= false and s or math_sqrt(s)
end

local function getiter(x)
  if is_array(x) then
    return ipairs
  elseif type(x) == "table" then
    return pairs
  end
  error("expected table", 3)
end

local function identity(x)
  return x
end

local function iteratee(x)
  if x == nil then return identity end
  if type(x) == 'function' then return x end
  if type(x) == "table" then
    return function(z)
      for k, v in pairs(x) do
        if z[k] ~= v then return false end
      end
      return true
    end
  end
  return function(z) return z[x] end
end

local function map(t, fn)
  fn = iteratee(fn)
  local iter = getiter(t)
  local rtn = {}
  for k, v in iter(t) do rtn[k] = fn(v) end
  return rtn
end

local function push(t, ...)
  local n = select('#', ...)
  for i = 1, n do
    t[#t + 1] = select(i, ...)
  end
  return ...
end

local function reduce(t, fn, first)
  local acc = first
  local started = first and true or false
  local iter = getiter(t)
  for _, v in iter(t) do
    if started then
      acc = fn(acc, v)
    else
      acc = v
      started = true
    end
  end
  assert(started, 'Attempted to reduce an empty table with no first value.')
  return acc
end

local function split(str, sep)
  local array = function(...)
    local t = {}
    for x in ... do
      t[#t + 1] = x
    end
    return t
  end
  local patternescape = function(s)
    return s:gsub('[%(%)%.%%%+%-%*%?%[%]%^%$]', '%%%1')
  end
  if not sep then
    return array(str:gmatch('([%S]+)'))
  else
    assert(sep ~= '', 'empty separator')
    local psep = patternescape(sep)
    return array((str..sep):gmatch('(.-)(' .. psep .. ')'))
  end
end

return {
  -- Get the arctangent between two vectors.
  -- @param {number} x1 first x coordinate
  -- @param {number} y1 first y coordinate
  -- @param {number} x2 second x coordinate
  -- @param {number} y2 second x coordinate
  -- @returns {number} the angle in radians
  angle = angle,
  -- Return a deep clone (new reference) of a non-primitive
  -- or the same primitive if a primitive is given.
  -- @param {*} anything you want a copy of
  -- @return {*} return a clone of the same type given
  copy = copy,
  -- Get the distance between two points
  -- @param {number} x1 point 1 x-axis
  -- @param {number} y1 point 1 y-axis
  -- @param {number} x2 point 2 x-axis
  -- @param {number} y2 point 2 y-axis
  -- @param {boolean=true} squared - If true, then the squared distance
  --  is returned. This is faster to calculate and can still be used when
  --  comparing distances.
  -- @returns {number} the distance between the two points
  distance = distance,
  -- Applies the function fn to each value in table t.
  -- @param {table} t - The table to remap
  -- @param {function} fn - Function used to transform each element. The return value is the new element value.
  -- @returns {table} A new table mapped with the function's resulting values
  -- @example
  --   map({1, 2, 3}, function(x) return x * 2 end) -- Returns {2, 4, 6}
  map = map,
  -- Push values to a table. This will mutate the original table!
  -- @params {table} the table
  -- @params {*} any arbitrary number of unpacked values
  -- @return the values that were passed in
  push = push,
  -- Applies fn on two arguments cumulative to the items of the array t,
  -- from left to right, so as to reduce the array to a single value. If
  -- a first value is specified the accumulator is initialised to this,
  -- otherwise the first value in the array is used.
  -- @param {table} t - a table to reduce
  -- @param {function} fn - the filter for comparing the two values
  -- @param {*} first - The initial value of the accumulation. If the array is
  --   empty, the will also be the returned value. If the array is empty and
  --   no first value is specified an error is raised.
  -- @example
  --   -- returns 'zxy'
  --   reduce(
  --     { 'x', 'y' },
  --     function(a, b) return a + b end,
  --     'z'
  --    )
  reduce = reduce,
  -- Split a string into an array of strings
  -- @param {string} str - the string to split
  -- @param {string} sep - the separator identifying where to split
  -- @returns {table} array of strings with the original separators removed
  split = split
}
