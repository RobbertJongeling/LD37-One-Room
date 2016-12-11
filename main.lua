require "keyhandler"
require "mousehandler"
require "menu"
require "plane"
require "airport"
require "screen"
require "panel"
require "borderedpanel"
require "game"
require "sweep"

function love.load()
  if arg and arg[#arg] == "-debug" then require ("modedebug").start() end

  load_assets()

  -- dimensions of the "full screen" panel
  local screenx = 110
  local screeny = 80
  local screenwidth = 1700
  local screenheight = 650
  local fullscreenpanel = Panel.create(screenx, screeny, screenwidth, screenheight)

  game = Game.create()
  game:init(fullscreenpanel)
end

function load_assets()
  plane_asset = love.graphics.newImage("assets/black-plane.png")
  foregroundImage = love.graphics.newImage("assets/background.png")
  sweep_asset = love.graphics.newImage("assets/radar-sweep.png")
end

function love.update(dt)
  game.sweep:update()

  for i,a in pairs(game.airports) do
    for j,p in pairs(a.planes) do
      p:move()
      if(false) then --TODO update draw position when sweep "hits" planes position
        p:update_draw_position()
      end
    end
  end
end

function love.draw()
  if(game.gameStarted) then
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
  if game.activescreen == 0 then
    for i,s in pairs(game.screens) do
      s:draw(default)
    end
  else
    game.screens[game.activescreen]:draw(fullscreen)
  end
end
