local args = love.arg.parseGameArguments(arg)
local insert = table.insert
local processed, last, cache = { }, nil, nil
for i=1, #args do
  local arg = args[i]
  local firstChar, lastChar = arg:sub(1,1), arg:sub(-1)
  local isArgument = firstChar == "-" and not cache

  if not cache and (firstChar == "\"" or firstChar == "'") then
    cache = arg:sub(2)
  else
    local CONTINUE_FLAG = false
    if cache then
      local chars = #arg
      if lastChar == "\"" or lastChar == "'" then
        arg = cache.." "..arg:sub(1, chars-1)
        cache = nil
      else
        cache = cache.." "..arg:sub(1, chars)
        CONTINUE_FLAG = true
      end
    end

    if not CONTINUE_FLAG then
      if not isArgument then
        if last then
          if type(processed[last]) ~= "table" then
            processed[last] = { }
          end
          insert(processed[last], arg)
        else
          insert(processed, arg)
        end
      else
        arg = arg:lower()
        processed[arg] = processed[arg] or true
        last = arg
      end
    end
  end
end
if cache then
  if last then
    if type(processed[last]) ~= "table" then
      processed[last] = { }
    end
    insert(processed[last], cache)
  else
    insert(processed, cache)
  end
end

return processed