Plane = {}
Plane.__index = Plane

function Plane.create()
  local plane = {}
  setmetatable(plane, Plane)

  plane.x = love.math.random()
  plane.y = love.math.random()
  plane.rot = love.math.random()*2*math.pi
  plane.speed = 0.00025;
  plane.startx = plane.x
  plane.starty = plane.y
  plane.drawx = plane.x
  plane.drawy = plane.y

  return plane
end

function Plane:move()
  self.x = self.x + (self.speed * math.cos(self.rot))
  self.y = self.y + (self.speed * math.sin(self.rot))
end

function Plane:update_draw_position()
  self.drawx = self.x
  self.drawy = self.y
end
