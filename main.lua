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
  game = Game.create()
  frame = 0
end

function load_assets()
  plane_asset = love.graphics.newImage("assets/black-plane.png")
  foregroundImage = love.graphics.newImage("assets/background.png")
  sweep_asset = love.graphics.newImage("assets/radar-sweep.png")
end

function start_game()
  -- dimensions of the "full screen" panel
  --local screenx = 110
  local screenx = 625
  local screeny = 80
  --local screenwidth = 1700
  local screenwidth = 650
  local screenheight = 650
  local fullscreenpanel = Panel.create(screenx, screeny, screenwidth, screenheight)
  game:init(fullscreenpanel)
  game.gameStarted = true
end

function love.update(dt)
  frame = (frame + 1) % 80
  if(game.gameStarted) then
    game.sweep:update()

    for i,a in pairs(game.airports) do
      for j,p in pairs(a.planes) do
        p:move()

        if(p.angle > 0.97 * game.sweep.rot and p.angle < 1.03 * game.sweep.rot) then
          p:update_draw_position()
        end
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
