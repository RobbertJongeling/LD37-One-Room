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
  buttons = create_buttons()
  game = Game.create()
end

function load_assets()
  plane_asset = love.graphics.newImage("assets/black-plane.png")
  crashed_plane_asset = love.graphics.newImage("assets/crashed-plane.png")
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
  if(game.gameStarted) then
    game.sweep:update()

    for i,a in pairs(game.airports) do
      --move planes
      for j,p in pairs(a.planes) do
        p:move()

        if(p.angle > 0.91 * game.sweep.rot and p.angle < 1.01 * game.sweep.rot) then
          p:update_draw_position()
        end
      end
      --check for collisions
      for j, p1 in pairs(a.planes) do
        for k, p2 in pairs(a.planes) do
          if p1 ~= p2 and p1:has_collision_with(p2) then
            p1:destroy()
            p2:destroy()
          end
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

function create_buttons()
  
end
