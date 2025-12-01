local scene = { }

local lg = love.graphics

local map = require("src.map")

scene.load = function(gameInfo) -- what game to load, if nil generate map
  if gameInfo then
    scene.map = map.load(gameInfo)
  end
  if not scene.map then
    scene.map = map.generate(30)
  end
end

scene.unload = function()
  scene.map = nil
end

local distortionShader = lg.newShader("scenes/game/distortion.glsl")
scene.draw = function()
  lg.clear()

  lg.push("all")
  -- lg.translate(lg.getWidth()/2, lg.getHeight()/2)
  lg.setShader(distortionShader)
  scene.map:draw()
  lg.pop()
end



return scene