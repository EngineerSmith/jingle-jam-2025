local assets = {
  "ui.logoES",
  "input.pc.0",
}
local lookup = { }
for _, asset in ipairs(assets) do
  lookup[asset] = true
end

--- Music Player
local assetList = require("src.musicPlayer").music
for _, assetKey in ipairs(assetList) do
  if not lookup[assetKey] then
    table.insert(assets, assetKey)
    lookup[assetKey] = true
  end
end

return assets