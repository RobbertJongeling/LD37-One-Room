function love.keypressed(k)
  if k == 'escape' or k == 'q' then
    love.event.quit(0)
  end
end
