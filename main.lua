require "keyhandler"
require "mousehandler"
require "menu"

function love.load()
  if arg and arg[#arg] == "-debug" then require ("modedebug").start() end
  radar_green = {2, 206, 63 }
  load_assets()
  gameStarted = true
end


function love.keypressed(key, u)
  if key == "q" then love.event.quit(0) end
end

function draw_radar(x, y, width, height)
  local dim = 0
  if width >= height then dim = height else dim = width end
  love.graphics.setColor(radar_green)

  local a = x + (dim / 2)
  local b = y + (dim / 2)

  love.graphics.circle("line", a, b, dim / 2)
  draw_plane(x, y, math.pi * .25)
  draw_plane(x + dim, y + dim, math.pi * 1.25)
  draw_plane(x, y + dim, math.pi * 1.75)
  draw_plane(x + dim, y, math.pi * .75)
end

function draw_plane(x, y, rot)
  sx = .1
  sy = .1
  ox = 0
  oy = 0
  love.graphics.draw(plane_asset, x, y, rot, sx, sy, ox, oy)
end

function love.draw()
  if(gameStarted)
  then drawGame()
  else printMenu()
  end
end

function drawGame()
  draw_radar(120, 120, 500, 500)
end

function load_assets()
  plane_asset = love.graphics.newImage("assets/black-plane.png")
end
