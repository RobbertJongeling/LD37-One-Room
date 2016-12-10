require "keyhandler"
require "mousehandler"
require "menu"

function love.load()
  if arg and arg[#arg] == "-debug" then require ("modedebug").start() end

  wwidth = love.graphics.getWidth()
  wheight = love.graphics.getHeight()
  foregroundImage = love.graphics.newImage("background.png")
  defaultBgColor = {54, 196, 180};
  gameStarted = false
  mousex = 0
  mousey = 0

  screenx = 110
  screeny = 80
  screenwidth = 1700
  screenheight = 650

  screens = {}
  screens[1] = newscreen(screenx, screeny, screenwidth/2, screenheight/2, {255, 0, 0})
  screens[2] = newscreen(screenx + screenwidth/2, screeny, screenwidth/2, screenheight/2, {0, 255, 0})
  screens[3] = newscreen(screenx, screeny + screenheight/2, screenwidth/2, screenheight/2, {0, 0, 255})
  screens[4] = newscreen(screenx + screenwidth/2, screeny + screenheight/2, screenwidth/2, screenheight/2, {255, 255, 255})

  activescreen = 0
end

function newscreen(x, y, w, h, bg)
  local self = {}
  self.x = x
  self.y = y
  self.width = w
  self.height = h
  self.backgroundcolor = bg
  return self
end


function love.update(dt)

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
        love.graphics.setColor(s.backgroundcolor)
        love.graphics.rectangle("fill", s.x, s.y, s.width, s.height)
      end
    else
      love.graphics.setColor(screens[activescreen].backgroundcolor)
      love.graphics.rectangle("fill", x, y, width, height)
    end
  end
end
