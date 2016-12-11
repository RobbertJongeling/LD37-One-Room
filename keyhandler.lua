function love.keypressed(k)
  if k == 'escape' or k == 'q' then
    love.event.quit(0)
  end
  if k == 's' then
    start_game()
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
  if k == 'a' then
    game:handle_key_pressed("left")
  end
  if k == 'd' then
    game:handle_key_pressed("right")
  end
end
