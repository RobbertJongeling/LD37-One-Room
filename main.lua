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
require "button"

function love.load()
  if arg and arg[#arg] == "-debug" then require ("modedebug").start() end
  mousex = 0
  mousey = 0

  load_assets()
  game = Game.create()
  buttons = create_buttons()
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
    --check button clicks
    if mousex and mousey then
      for i, b in pairs(buttons) do
        if b:isclicked(mousex, mousey) then b:click() end
      end
      mousex = nil
      mousey = nil
    end

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
  local btns = {}
  btns[1] = Button.create(307, 844, 129, 42, function() game:set_active_screen(1) end)
  btns[2] = Button.create(307, 895, 129, 42, function() game:set_active_screen(2) end)
  btns[3] = Button.create(307, 946, 129, 42, function() game:set_active_screen(3) end)
  btns[4] = Button.create(307, 997, 129, 42, function() game:set_active_screen(4) end)
  btns[5] = Button.create(450, 844, 129, 590, function() game:set_active_screen(0) end)
  btns[6] = Button.create(125, 830, 105, 100,
    function()
      for i,a in pairs(game.airports) do
        for j,p in pairs(a.planes) do
          p:destroy()
        end
      end
    end)
  return btns
end
