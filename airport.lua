Airport = {}
Airport.__index = Airport

function Airport.create()
  local airport = {}
  setmetatable(airport, Airport)

  airport.runways = {}
  local runway1 = {}
  local runway2 = {}


  runway1.x1 = 0.2
  runway1.x2 = 0.8
  runway1.y1 = love.math.random()
  runway1.y2 = love.math.random()
  airport.runways[0] = runway1

  runway2.x1 = love.math.random()
  runway2.x2 = love.math.random()
  runway2.y1 = 0.2
  runway2.y2 = 0.8
  airport.runways[1] = runway2

  airport.planes = {}
  for i = 1, 3 do
    airport.planes[i] = Plane.create()
  end

  airport.name = "test"

  return airport
end

function Airport:set_name(newName)
  self.name = newName
end
