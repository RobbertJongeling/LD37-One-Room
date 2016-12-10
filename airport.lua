function generate_airport()
  local airport = {}
  airport.runways = {}
  local runway1 = {}
  local runway2 = {}


  runway1.x1 = 0
  runway1.x2 = 1
  runway1.y1 = love.math.random()
  runway1.y2 = love.math.random()
  airport.runways[0] = runway1

  runway2.x1 = love.math.random()
  runway2.x2 = love.math.random()
  runway2.y1 = 0
  runway2.y2 = 1
  airport.runways[1] = runway2

  airport.planes = generate_planes(3)

  return airport
end
