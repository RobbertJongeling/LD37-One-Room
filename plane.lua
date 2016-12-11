Plane = {}
Plane.__index = Plane

function Plane.create()
  local plane = {}
  setmetatable(plane, Plane)

  local rand  = love.math.random()
  local random_angle = love.math.random() - math.pi/8
  if rand < .25 then -- ceiling
    plane.x = love.math.random()
    plane.y = 0.01
    plane.rot = math.pi * 0.5 + random_angle
  elseif rand < .5 then -- floor
    plane.x = love.math.random()
    plane.y = 0.99
    plane.rot = math.pi * 1.5 + random_angle
  elseif rand < .75 then -- left
    plane.x = 0.01
    plane.y = love.math.random()
    plane.rot = 0 + random_angle
  else -- right
    plane.x = 0.99
    plane.y = love.math.random()
    plane.rot = math.pi + random_angle
  end

  plane.selected = false
  plane.angle = 0
  plane.crashed = false
  plane.speed = 0.00025;
  plane.hist = {{x = plane.x, y = plane.y}}

  plane.drawx = plane.x
  plane.drawy = plane.y
  plane.drawrot = plane.rot
  plane.drawhist = plane.hist

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
  if not self.crashed then
    self.drawx = self.x
    self.drawy = self.y
    self.drawrot = self.rot
    self.drawhist = self.hist
  end
end

function Plane:destroy()
  self.speed = 0
  self.crashed = true
end

function Plane:has_collision_with(plane)
  if not self.crashed and not plane.crashed then
    local r = math.sqrt((plane.x - self.x) * (plane.x - self.x) + (plane.y - self.y) * (plane.y - self.y))
    return r < 0.05 --magic value
  end
  return false
end

function Plane:apply_rotation(rotation)
  if not self.crashed and self.selected then
    self.rot = self.rot + rotation
    table.insert(self.hist, {x = self.x, y = self.y})
  end
end

function Plane:select()
  self.selected = true
end

function Plane:unselect()
  self.selected = false
end
