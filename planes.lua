function generate_planes(amount)
  local planes = {}

  for i = 0, amount do
    local p = {}
    p.x = love.math.random(50, 200)
    p.y = love.math.random(50, 200)
    p.rot = love.math.random()*2*math.pi
    planes[i] = p
  end
  return planes
end
