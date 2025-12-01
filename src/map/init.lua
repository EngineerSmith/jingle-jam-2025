local map = {
  pointScale = 50,
}
map.__index = map

local lg = love.graphics

-- todo; generate nodes randomly
map.generate = function(size)
  local self = map.new(size)
  return self
end

-- todo; load node positions from file
map.load = function()
  local self = map.new()
  return self
end

map.new = function(size)
  local self = setmetatable({
    size = size or 30,
  }, map)
  self.grid = require("src.map.grid").new(self.size, self.pointScale)
  return self
end

map.update = function()

end

map.draw = function(self)
  lg.push("all")
  self.grid:draw()
  lg.pop()
end

return map