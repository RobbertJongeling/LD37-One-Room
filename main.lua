require "keyhandler"
require "mousehandler"
require "menu"
require "planes"
require "airports"

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

  screens = {}
  screens[1] = newscreen(screenx, screeny, screenwidth/2, screenheight/2, {255, 0, 0}, draw_radar)
  screens[2] = newscreen(screenx + screenwidth/2, screeny, screenwidth/2, screenheight/2, {0, 255, 0}, draw_radar)
  screens[3] = newscreen(screenx, screeny + screenheight/2, screenwidth/2, screenheight/2, {0, 0, 255}, draw_radar)
  screens[4] = newscreen(screenx + screenwidth/2, screeny + screenheight/2, screenwidth/2, screenheight/2, {255, 255, 255}, draw_radar)

  activescreen = 0

  radar_green = {2, 206, 63 }
  planes = generate_planes(2)
end

function newscreen(x, y, w, h, bg, fnct)
  local self = {}
  self.x = x
  self.y = y
  self.width = w
  self.height = h
  self.backgroundcolor = bg
  self.fnct = fnct
  self.draw = function(args)
    if self.fnct then
      if args then
        self.fnct(args)
      else
        self.fnct({x = self.x, y = self.y, width = self.width, height = self.height})
      end
    end
  end
  return self
end

function love.update(dt)

end

function apply_border(panel, border_size)
  local newpanel = {}
  newpanel.x = panel.x + border_size
  newpanel.y=  panel.y + border_size
  newpanel.width = panel.width - border_size * 2
  newpanel.height = panel.height - border_size * 2
  return newpanel
end

function draw_radar(panel)
  local bordered_panel = apply_border(panel, 40)
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

  draw_plane(bordered_panel, planes)
end

function draw_plane(panel, planes)
  for i, p in pairs(planes) do

    local sx = .1
    local sy = .1
    local ox = 0
    local oy = 0
    love.graphics.draw(plane_asset, p.sx * panel.width + panel.x, p.sy * panel.height + panel.y, p.rot, sx, sy, ox, oy)
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
