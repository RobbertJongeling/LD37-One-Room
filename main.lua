require "keyhandler"
require "mousehandler"
require "menu"
require "planes"
require "airport"

function love.load()
  if arg and arg[#arg] == "-debug" then require ("modedebug").start() end

  load_assets()

  wwidth = love.graphics.getWidth()
  wheight = love.graphics.getHeight()
  defaultBgColor = {54, 196, 180};
  gameStarted = false
  mousex = 0
  mousey = 0

  screenx = 110
  screeny = 80
  screenwidth = 1700
  screenheight = 650

  sf = 0.00005

  airports = {}
  for i = 1, 4 do
    airports[i] = generate_airport()
  end

  screens = {}
  screens[1] = newscreen(screenx, screeny, screenwidth/2, screenheight/2, {255, 0, 0}, draw_radar, airports[1])
  screens[2] = newscreen(screenx + screenwidth/2, screeny, screenwidth/2, screenheight/2, {0, 255, 0}, draw_radar, airports[2])
  screens[3] = newscreen(screenx, screeny + screenheight/2, screenwidth/2, screenheight/2, {0, 0, 255}, draw_radar, airports[3])
  screens[4] = newscreen(screenx + screenwidth/2, screeny + screenheight/2, screenwidth/2, screenheight/2, {255, 255, 255}, draw_radar, airports[4])

  activescreen = 0

  radar_green = {2, 206, 63 }
  grey = {169, 169, 169, 169}

  sweep = {}
  sweep.rot = math.pi*2;

  planes = generate_planes(100)
end

function newscreen(x, y, w, h, bg, fnct, airport)
  local self = {}
  self.x = x
  self.y = y
  self.width = w
  self.height = h
  self.backgroundcolor = bg
  self.fnct = fnct
  self.airport = airport
  self.draw = function(args)
    if self.fnct then
      if args then
        self.fnct(args, self.airport)
      else
        self.fnct({x = self.x, y = self.y, width = self.width, height = self.height}, self.airport)
      end
    end
  end
  return self
end

function love.update(dt)
  sweep.rot = (sweep.rot + ((math.pi*2)/150)) % (math.pi*2)

  for i,a in pairs(airports) do
    for j,p in pairs(a.planes) do
      p.move()
      if(false) then
        p.drawx = p.x
        p.drawy = p.y
      end
    end
  end


end

function apply_border(panel, border_size)
  local newpanel = {}
  newpanel.x = panel.x + border_size
  newpanel.y=  panel.y + border_size
  newpanel.width = panel.width - border_size * 2
  newpanel.height = panel.height - border_size * 2
  return newpanel
end

function draw_radar(panel, airport)
  local bordered_panel = apply_border(panel, 50)
  local smallest = 0
  if panel.width >= bordered_panel.height then
    smallest = bordered_panel.height
  else
    smallest = bordered_panel.width
  end
  love.graphics.setColor(radar_green)

  local a = bordered_panel.x  + (bordered_panel.width / 2)
  local b = bordered_panel.y + (bordered_panel.height / 2)

  love.graphics.setLineWidth(1)
  love.graphics.circle("line", a, b, smallest / 2)

  draw_plane(bordered_panel, airport.planes)
  draw_runways(bordered_panel, airport.runways)
  draw_sweep(bordered_panel)
end

function draw_sweep(panel)
  local s = 0.000685 * panel.width
  love.graphics.draw(sweep_asset, panel.x + panel.width/2, panel.y + panel.height/2, sweep.rot, s, s)
end

function draw_runways(panel, runways)
  for i, r in pairs(runways) do
    local s = sf * panel.width

    love.graphics.setLineWidth(2)
    love.graphics.setColor(radar_green)
    love.graphics.line((r.x1 * panel.height + panel.x + ((panel.width - panel.height) / 2)),
                        (r.y1 * panel.height + panel.y),
                        (r.x2 * panel.height + panel.x + ((panel.width - panel.height) / 2)),
                        (r.y2 * panel.height + panel.y))
  end
end

function draw_plane(panel, planes)
  for i, p in pairs(planes) do

    local s = sf * panel.width
    local ox = 0
    local oy = 0
    local drawx = scalex(panel, p.drawx)
    local drawy = scaley(panel, p.drawy)
    if drawx > panel.x and drawx < (panel.x + panel.width) and drawy > panel.y and drawy < (panel.y + panel.height) then
      draw_trajectory(panel, p)
      love.graphics.setColor(radar_green)
      love.graphics.draw(plane_asset, drawx, drawy, p.rot, s, s, ox, oy)
    end
  end
end

function scalex(panel, x)
  return x * panel.height + panel.x + ((panel.width - panel.height) / 2)
end

function scaley(panel, y)
  return y * panel.height + panel.y
end

function draw_trajectory(panel, plane)
    love.graphics.setColor(grey)
    love.graphics.line(scalex(panel, plane.drawx), scaley(panel, plane.drawy), scalex(panel, plane.startx), scaley(panel, plane.starty))
end

function love.draw()
  if(gameStarted) then
    drawGame()
  else
    printMenu()
  end
end

function drawGame()
  drawActiveScreen(screenx, screeny, screenwidth, screenheight) -- "screen" part of backgroundimage
  drawForeground()
end

function drawForeground()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(foregroundImage, 0, 0)
end

function drawActiveScreen(x, y, width, height)
  if screens == nil then
    love.graphics.setColor(defaultBgColor)
    love.graphics.rectangle("fill", x, y, width, height)
  else
    if activescreen == 0 then
      for i,s in pairs(screens) do
        s.draw()
      end
    else
      screens[activescreen].draw({x = x, y = y, width = width, height = height})
    end
  end
end

function load_assets()
  plane_asset = love.graphics.newImage("assets/black-plane.png")
  foregroundImage = love.graphics.newImage("assets/background.png")
  sweep_asset = love.graphics.newImage("assets/radar-sweep.png")
end
