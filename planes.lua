function generate_planes(amount)
  local planes = {}

  for i = 1, amount do
    local p = {}
    p.sx = love.math.random()
    p.sy = love.math.random()
    p.rot = love.math.random()*2*math.pi
    planes[i] = p
  end
  return planes
end
