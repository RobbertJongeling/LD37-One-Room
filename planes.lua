function generate_planes(amount)
  local planes = {}

  for i = 0, amount do
    local p = {}
    p.x = math.floor(love.math.random(100))
    p.y = math.floor(love.math.random(100))
    p.rot = love.math.random(math.pi)
    planes[i] = p
  end
  return planes
end
