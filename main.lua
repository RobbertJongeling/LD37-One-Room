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
  for i,a in pairs(airports) do
    for j,p in pairs(a.planes) do
      p.move()
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

  love.graphics.circle("line", a, b, smallest / 2)

  draw_plane(bordered_panel, airport.planes)
end

function draw_plane(panel, planes)
  for i, p in pairs(planes) do

    local sx = .00005 * panel.width
    local sy = .00005 * panel.width
    local ox = 0
    local oy = 0    
    love.graphics.draw(plane_asset, p.x * panel.height + panel.x + ((panel.width - panel.height) / 2), p.y * panel.height + panel.y, p.rot, sx, sy, ox, oy)
  end
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
end
