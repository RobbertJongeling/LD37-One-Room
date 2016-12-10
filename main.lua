function love.load()
  if arg and arg[#arg] == "-debug" then require ("modedebug").start() end

end
