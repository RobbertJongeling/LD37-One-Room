require "keyhandler"
require "mousehandler"
require "menu"
require "plane"
require "airport"
require "screen"
require "panel"
require 'borderedpanel'

function love.load()
  if arg and arg[#arg] == "-debug" then require ("modedebug").start() end

  load_assets()

  wwidth = love.graphics.getWidth()
  wheight = love.graphics.getHeight()
  defaultBgColor = {54, 196, 180};
  gameStarted = false
  mousex = 0
  mousey = 0

  -- dimensions of the "full screen" panel
  local screenx = 110
  local screeny = 80
  local screenwidth = 1700
  local screenheight = 650
  local fullscreenpanel = Panel.create(screenx, screeny, screenwidth, screenheight)

  sf = 0.00005

  airports = {}
  for i = 1, 4 do
    airports[i] = Airport.create()
    airports[i]:set_name("airport " .. i) --for testing of refactoring
  end

  screens = {}
  screens[1] = Screen.create(Panel.create(screenx, screeny, screenwidth/2, screenheight/2), fullscreenpanel, airports[1])
  screens[2] = Screen.create(Panel.create(screenx + screenwidth/2, screeny, screenwidth/2, screenheight/2), fullscreenpanel, airports[2])
  screens[3] = Screen.create(Panel.create(screenx, screeny + screenheight/2, screenwidth/2, screenheight/2), fullscreenpanel, airports[3])
  screens[4] = Screen.create(Panel.create(screenx + screenwidth/2, screeny + screenheight/2, screenwidth/2, screenheight/2), fullscreenpanel, airports[4])

  activescreen = 0

  radar_green = {2, 206, 63 }
  grey = {169, 169, 169, 169}

  sweep = {}
  sweep.rot = math.pi*2;
end

function load_assets()
  plane_asset = love.graphics.newImage("assets/black-plane.png")
  foregroundImage = love.graphics.newImage("assets/background.png")
  sweep_asset = love.graphics.newImage("assets/radar-sweep.png")
end

function love.update(dt)
  sweep.rot = (sweep.rot + ((math.pi*2)/150)) % (math.pi*2)

  for i,a in pairs(airports) do
    for j,p in pairs(a.planes) do
      p:move()
      if(false) then
        p:update_draw_position()
      end
    end
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
  drawActiveScreen()
  drawForeground()
end

function drawForeground()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(foregroundImage, 0, 0)
end

function drawActiveScreen()
  local default = false
  local fullscreen = true
  if activescreen == 0 then
    for i,s in pairs(screens) do
      s:draw(default)
    end
  else
    screens[activescreen]:draw(fullscreen)
  end
end
