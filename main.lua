require "keyhandler"
require "mousehandler"
require "menu"

function love.load()
  if arg and arg[#arg] == "-debug" then require ("modedebug").start() end
  gameStarted = false
end

function love.draw()
  if(gameStarted)
  then drawGame()
  else printMenu()
  end
end
