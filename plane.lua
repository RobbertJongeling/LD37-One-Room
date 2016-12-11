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
  plane.angle = 0

  return plane
end

function Plane:move()
  self.x = self.x + (self.speed * math.cos(self.rot))
  self.y = self.y + (self.speed * math.sin(self.rot))

  -- transform to coordinates on -1,1
  local x = 2 * (self.x - 0.5)
  local y = 2 * (0.5 - self.y)

  local sin =  math.asin(y / math.sqrt(x*x + y*y))
  local cos = math.acos(x / math.sqrt(x*x + y*y))
  if sin >= 0 then
    self.angle = cos
  else
    self.angle = 2 * math.pi - cos
  end
end

function Plane:update_draw_position()
  self.drawx = self.x
  self.drawy = self.y
end
