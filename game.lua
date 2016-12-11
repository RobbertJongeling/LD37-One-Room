Game = {}
Game.__index = Game

function Game.create()
  local game = {}
  setmetatable(game, Game)

  game.gameStarted = false
  game.activescreen = 0
  game.airports = {}
  game.screens = {}

  return game
end

function Game:init(fullscreenpanel)
  game.airports = self:create_airports()
  game.screens = self:create_screens(fullscreenpanel)
  game.sweep = Sweep.create()
end

function Game:create_airports()
  local airports = {}
  local alphabet = {"A", "B", "C", "D"}
  for i = 1, 4 do
    airports[i] = Airport.create()
    airports[i]:set_name("airport " .. alphabet[i]) --for testing of refactoring
  end
  return airports
end

function Game:create_screens(fullscreenpanel)
  local screenx = fullscreenpanel.x
  local screeny = fullscreenpanel.y
  local screenwidth = fullscreenpanel.width
  local screenheight = fullscreenpanel.height
  local screens = {}
  screens[1] = Screen.create(Panel.create(screenx, screeny, screenwidth/2, screenheight/2), fullscreenpanel, self.airports[1])
  screens[2] = Screen.create(Panel.create(screenx + screenwidth/2, screeny, screenwidth/2, screenheight/2), fullscreenpanel, self.airports[2])
  screens[3] = Screen.create(Panel.create(screenx, screeny + screenheight/2, screenwidth/2, screenheight/2), fullscreenpanel, self.airports[3])
  screens[4] = Screen.create(Panel.create(screenx + screenwidth/2, screeny + screenheight/2, screenwidth/2, screenheight/2), fullscreenpanel, self.airports[4])
  return screens
end

function Game:set_active_screen(index)
  self.activescreen = index
end

function Game:handle_key_pressed(key)
  if self.activescreen == 0 then
    for i=1, 4 do
      self:handle_rotation(self.airports[i].planes, key)
    end
  else
    self:handle_rotation(self.screens[self.activescreen].airport.planes, key)
  end
end

function Game:handle_rotation(planes, key)
  for i, p in pairs(planes) do
    if key == "left" then p:apply_rotation(-0.1) end
    if key == "right" then p:apply_rotation(0.1) end
  end
end

function Game:unselect_all()
  for i, a in pairs(self.airports) do
    for j, p in pairs(a.planes) do
      p:unselect()
    end
  end
end
