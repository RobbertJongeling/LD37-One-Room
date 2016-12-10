require "keyhandler"
require "mousehandler"
require "menu"

function love.load()
  if arg and arg[#arg] == "-debug" then require ("modedebug").start() end
  radar_green = {2, 206, 63}
end


function love.keypressed(key, u)
  if key == "q" then love.event.quit(0) end
end

function draw_radar(x, y, width, height)
  -- assuming that this indicates a square...
  love.graphics.setColor(radar_green)

  local a = x + (width / 2)
  local b = y + (height / 2)

  love.graphics.circle("line", a, b, width / 2)
  gameStarted = false
  wheight = love.window.fromPixels(love.graphics.getHeight())
  wwidth = love.window.fromPixels(love.graphics.getWidth())
end

function love.draw()
  if(gameStarted)
  then drawGame()
  else printMenu()
  end
end

function drawGame()
  draw_radar(120, 120, 100, 100)
end
