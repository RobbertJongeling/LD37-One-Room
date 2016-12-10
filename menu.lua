function printMenu()
  local wwidth = love.window.fromPixels(love.graphics.getWidth())
  local wheight = love.window.fromPixels(love.graphics.getHeight())
  love.graphics.setColor(255,255,255,255)
  love.graphics.rectangle("fill", 0, 0, love.window.toPixels(wwidth), love.window.toPixels(wwidth))
  love.graphics.setColor(222,222,222,255)
  love.graphics.rectangle("fill", love.window.toPixels(50), love.window.toPixels(50),love.window.toPixels(wwidth-100), love.window.toPixels(wheight-350) )
  love.graphics.setColor(0,0,0,255)
  if mousex ~= nil and mousey ~= nil then
      love.graphics.print("mousex: " .. mousex .. " mousey: " .. mousey,love.window.toPixels(100),love.window.toPixels(100))
      love.graphics.print("wwidth: " .. wwidth .. " wheight: " .. wheight,love.window.toPixels(100),love.window.toPixels(200))
  else
      love.graphics.print("click mouse")
  end
end
