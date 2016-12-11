Panel = {}
Panel._index = Panel

function Panel.create(x, y, w, h)
  local panel = {}
  setmetatable(panel, Panel)

  panel.x = x
  panel.y = y
  panel.width = w
  panel.height = h
  
  return panel
end
