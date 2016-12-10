function printMenu()
  love.graphics.setColor(255,255,255,255)
  love.graphics.rectangle("fill", 0, 0, wwidth, wwidth)
  love.graphics.setColor(222,222,222,255)
  love.graphics.rectangle("fill", 50, 50, wwidth-100, wheight-350 )
  love.graphics.setColor(0,0,0,255)
  love.graphics.print("mousex: " .. mousex .. " mousey: " .. mousey, love.window.toPixels(100), love.window.toPixels(100))
  love.graphics.print("wwidth: " .. wwidth .. " wheight: " .. wheight, love.window.toPixels(100), love.window.toPixels(200))
end
