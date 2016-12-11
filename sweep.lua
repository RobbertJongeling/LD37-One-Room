Sweep = {}
Sweep.__index = Sweep

function Sweep.create()
  local sweep = {}
  setmetatable(sweep, Sweep)

  sweep.rot = math.pi*2

  return sweep
end

function Sweep:update()
  self.rot = (self.rot + ((math.pi*2)/150)) % (math.pi*2)
end
