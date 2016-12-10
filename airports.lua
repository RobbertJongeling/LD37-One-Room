function generate_airports(amount)
  local airports = {}

  for i = 0, amount do
    local airport = {}
    local runways = {}
    nrRunways = 2 + love.math.random()*2
    for i = 0, nrRunways do
      --runway 1
      runway.y1 = love.math.random()
      runway.y2 = love.math.random()
      --runway 2
      runway.x1 = love.math.random()
      runway.x1 = love.math.random()
      airport.runways[i] = runways
    end
    airports[i] = airport
  end
  return planes
end
