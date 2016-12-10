require "keyhandler"
require "mousehandler"
require "menu"
require "planes"

function love.load()
  if arg and arg[#arg] == "-debug" then require ("modedebug").start() end
  radar_green = {2, 206, 63 }
  load_assets()
  gameStarted = true
  planes = generate_planes(2)
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

  local panel = { x = x, y = y}
  draw_plane(panel, planes)
end

function draw_plane(panel, planes)
  for i, v in pairs(planes) do
    local p = v

    local sx = .1
    local sy = .1
    local ox = 0
    local oy = 0
    love.graphics.draw(plane_asset, p.x + panel.x, p.y + panel.y, p.rot, sx, sy, ox, oy)
  end
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
