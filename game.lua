Game = {}
Game.__index = Game

function Game.create()
  local game = {}
  setmetatable(game, Game)

  game.gameStarted = false
  game.activescreen = 0
  game.sweep = Sweep.create()
  game.airports = {}
  game.screens = {}

  return game
end

function Game:init(fullscreenpanel)
  game.airports = self:create_airports()
  game.screens = self:create_screens(fullscreenpanel)
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
