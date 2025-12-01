local grid = { }
grid.__index = grid

local lg = love.graphics

local subdivision = 3
local lineWidth = 1.5

grid.new = function(size, cellSize)
  local self = setmetatable({
    size = size or error(),
    cellSize = cellSize or error(),
    total
  }, grid)

  local N = self.size
  local S = subdivision + 1
  local segmentLength = self.cellSize / S
  local totalLines = N + 1
  local halfWidth = lineWidth / 2

  local vertices = { }
  for h_line = 0, totalLines - 1 do
    local y = h_line * self.cellSize
    for segment = 0, N * S - 1 do
      local x1 =  segment      * segmentLength
      local x2 = (segment + 1) * segmentLength

      vertices[#vertices + 1] = { x2, y + halfWidth }
      vertices[#vertices + 1] = { x2, y - halfWidth }
      vertices[#vertices + 1] = { x1, y - halfWidth }

      vertices[#vertices + 1] = { x1, y + halfWidth }
      vertices[#vertices + 1] = { x2, y + halfWidth }
      vertices[#vertices + 1] = { x1, y - halfWidth }
    end
  end

  self.hortLines = lg.newMesh(vertices, "triangles", "static")

  local vertices = { }
  for v_line = 0, totalLines - 1 do
    local x = v_line * self.cellSize
    for segment = 0, N * S - 1 do
      local y1 =  segment      * segmentLength
      local y2 = (segment + 1) * segmentLength

      vertices[#vertices + 1] = { x + halfWidth, y2 }
      vertices[#vertices + 1] = { x + halfWidth, y1 }
      vertices[#vertices + 1] = { x - halfWidth, y1 }

      vertices[#vertices + 1] = { x - halfWidth, y2 }
      vertices[#vertices + 1] = { x + halfWidth, y2 }
      vertices[#vertices + 1] = { x - halfWidth, y1 }
    end
  end

  self.vertLines = lg.newMesh(vertices, "triangles", "static")

  return self
end

grid.draw = function(self)
  lg.push("all")
  lg.setColor(.6,.6,.6,1)
  lg.draw(self.hortLines)
  lg.draw(self.vertLines)
  lg.pop()
end

return grid