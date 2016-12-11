Button = {}
Button.__index = Button

function Button.create(x, y, width, height, callback, args)
  button = {}
  setmetatable(button, Button)

  button.x = x
  button.y = y
  button.width = width
  button.height = height

  return button
end

function button:isclicked(mousex, mousey)
  return mousex >= self.x and mousex <= mousex + self.width and mousey > self.y and mousey <= self.y + self.height
end

function Button:click()
  callback(args)
end
