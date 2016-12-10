function generate_planes(amount)
  local planes = {}

  for i = 1, amount do
    local p = {}
    p.x = love.math.random()
    p.y = love.math.random()
    p.startx = p.x
    p.starty = p.y
    p.rot = love.math.random()*2*math.pi
    p.speed = 0.00025;
    p.move = function()
      p.x = p.x + (p.speed * math.cos(p.rot))
      p.y = p.y + (p.speed * math.sin(p.rot))
    end
    planes[i] = p
  end
  return planes
end
