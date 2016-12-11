Button = {}
Button.__index = Button

function Button.create(x, y, width, height, callback)
  local button = {}
  setmetatable(button, Button)

  button.x = x
  button.y = y
  button.width = width
  button.height = height
  button.callback = callback

  return button
end

function Button:isclicked(mousex, mousey)
  return mousex >= self.x and mousex <= mousex + self.width and mousey > self.y and mousey <= self.y + self.height
end

function Button:click()
  self.callback()
end
