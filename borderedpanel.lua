Borderedpanel = {}
Borderedpanel.__index = Borderedpanel

function Borderedpanel.create(panel, border_size)
  local bordered_panel = {}
  setmetatable(bordered_panel, Borderedpanel)

  bordered_panel.x = panel.x + border_size
  bordered_panel.y =  panel.y + border_size
  bordered_panel.width = panel.width - border_size * 2
  bordered_panel.height = panel.height - border_size * 2

  return bordered_panel
end
