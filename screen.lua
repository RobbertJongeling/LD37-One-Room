Screen = {}
Screen.__index = Screen

function Screen.create(defaultpanel, fullscreenpanel, airport)
  local screen = {}
  setmetatable(screen, Screen)

  screen.airport = airport
  screen.defaultpanel = defaultpanel
  screen.bordereddefpanel = Borderedpanel.create(defaultpanel, 50)
  screen.fullscreenpanel = fullscreenpanel
  screen.borderedfspanel = Borderedpanel.create(fullscreenpanel, 50)
  screen.sf = 0.00015
  screen.radar_green = {2, 206, 63 }
  screen.grey = {169, 169, 169, 169}

  return screen
end

function Screen:draw(fullscreen)
  if fullscreen then
    self:draw_radar(fullscreen)
  else
    self:draw_radar(default)
  end
end

function Screen:draw_radar(fullscreen)
  local bordered_panel = {}
  if fullscreen then
    bordered_panel = self.borderedfspanel
  else
    bordered_panel = self.bordereddefpanel
  end

  local smallest = 0
  if bordered_panel.width >= bordered_panel.height then
    smallest = bordered_panel.height
  else
    smallest = bordered_panel.width
  end
  love.graphics.setColor(self.radar_green)

  local a = bordered_panel.x  + (bordered_panel.width / 2)
  local b = bordered_panel.y + (bordered_panel.height / 2)

  love.graphics.setLineWidth(1)
  love.graphics.circle("line", a, b, smallest / 2)

  self:draw_planes(bordered_panel, self.airport.planes)
  self:draw_runways(bordered_panel, self.airport.runways)
  self:draw_sweep(bordered_panel)

  love.graphics.setColor(self.radar_green)
  love.graphics.print(self.airport.name, bordered_panel.x, bordered_panel.y)
end

function Screen:draw_planes(panel, planes)
  for i, p in pairs(planes) do

    local s = self.sf * panel.width
    local ox = 0
    local oy = 256
    local drawx = self:scalex(panel, p.drawx)
    local drawy = self:scaley(panel, p.drawy)

    if drawx > panel.x and drawx < (panel.x + panel.width) and drawy > panel.y and drawy < (panel.y + panel.height) then
      self:draw_trajectory(panel, p)
      if(p.crashed) then
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(crashed_plane_asset, drawx, drawy, p.drawrot, s, s, ox, oy)
      else
        if(p.selected) then
          love.graphics.setColor(255, 255, 0, 255)
          love.graphics.draw(selected_plane_asset, drawx, drawy, p.drawrot, s, s, ox, oy)
        else
          love.graphics.setColor(self.radar_green)
          love.graphics.draw(plane_asset, drawx, drawy, p.drawrot, s, s, ox, oy)
        end
      end
    end
  end
end

function Screen:draw_trajectory(panel, plane)
  love.graphics.setColor(self.grey)
  local hist = plane.drawhist
  local last_index = 1
  for i, this in pairs(hist) do
    local next = hist[i+1]
    if next ~= nil then
      love.graphics.line(
        self:scalex(panel, this.x), self:scaley(panel, this.y),
        self:scalex(panel, next.x), self:scaley(panel, next.y))
    end
    last_index = i
  end
  love.graphics.line(
    self:scalex(panel, plane.drawx), self:scaley(panel, plane.drawy),
    self:scalex(panel, hist[last_index].x), self:scaley(panel, hist[last_index].y))
end

function Screen:draw_runways(panel, runways)
  for i, r in pairs(runways) do
    local s = self.sf * panel.width

    love.graphics.setLineWidth(2)
    love.graphics.setColor(self.radar_green)

    love.graphics.line(
      self:scalex(panel, r.x1), self:scaley(panel, r.y1),
      self:scalex(panel, r.x2), self:scaley(panel, r.y2)
    )
  end
end

function Screen:draw_sweep(panel)
  local s = 0.002 * panel.width
  love.graphics.draw(sweep_asset, panel.x + panel.width/2, panel.y + panel.height/2, -game.sweep.rot, s, s)
end

function Screen:scalex(panel, x)
  return x * panel.width + panel.x
end

function Screen:scaley(panel, y)
  return y * panel.height + panel.y
end
