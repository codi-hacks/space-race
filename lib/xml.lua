--- XML parser for pasing tiled map files

-- LoadXML from http://lua-users.org/wiki/LuaXml
local parse = function(s)
  local function LoadXML_parseargs(str)
    local arg = {}
    string.gsub(str, "(%w+)=([\"'])(.-)%2", function (w, _, a)
    arg[w] = a
    end)
    return arg
  end
  local stack = {}
  local top = {}
  table.insert(stack, top)
  local ni, c, label, xarg, empty
  local i = 1
  local j
  while true do
    ni, j, c, label, xarg, empty = string.find(s, '<(%/?)([%w:]+)(.-)(%/?)>', i)
    if not ni then break end
    local text = string.sub(s, i, ni - 1)
    if not string.find(text, '^%s*$') then
      table.insert(top, text)
    end
    if empty == '/' then -- empty element tag
      table.insert(top, {
        label = label,
        xarg = LoadXML_parseargs(xarg),
        empty = 1
      })
    elseif c == '' then -- start tag
      top = {
        label = label,
        xarg = LoadXML_parseargs(xarg)
      }
      table.insert(stack, top) -- new level
    else  -- end tag
      local toclose = table.remove(stack) -- remove top
      top = stack[#stack]
      if #stack < 1 then
        error('nothing to close with ' .. label)
      end
      if toclose.label ~= label then
        error('trying to close ' .. toclose.label .. ' with ' .. label)
      end
      table.insert(top, toclose)
    end
    i = j + 1
  end
  local text = string.sub(s, i)
  if not string.find(text, '^%s*$') then
    table.insert(stack[#stack], text)
  end
  if #stack > 1 then
    error('unclosed ' .. stack[stack.n].label)
  end
  return stack[1]
end

return {
  parse = parse
}
