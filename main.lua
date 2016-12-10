require "keyhandler"
require "mousehandler"
require "menu"

function love.load()
  if arg and arg[#arg] == "-debug" then require ("modedebug").start() end
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
