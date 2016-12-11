function love.keypressed(k)
  if k == 'escape' or k == 'q' then
    love.event.quit(0)
  end
  if k == 's' then
    game.gameStarted = not game.gameStarted
  end
  if k == '0' then
    game:set_active_screen(0)
  end
  if k == '1' then
    game:set_active_screen(1)
  end
  if k == '2' then
    game:set_active_screen(2)
  end
  if k == '3' then
    game:set_active_screen(3)
  end
  if k == '4' then
    game:set_active_screen(4)
  end
end
