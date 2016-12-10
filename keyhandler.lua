function love.keypressed(k)
  if k == 'escape' or k == 'q' then
    love.event.quit(0)
  end
  if k == 's' then
    gameStarted = not gameStarted
  end
  if k == '0' then
    activescreen = 0
  end
  if k == '1' then
    activescreen = 1
  end
  if k == '2' then
    activescreen = 2
  end
  if k == '3' then
    activescreen = 3
  end
  if k == '4' then
    activescreen = 4
  end
end
