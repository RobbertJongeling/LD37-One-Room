function generate_planes(amount)
  local planes = {}
  planes[0] = {}
  planes[0].x = 1
  planes[0].y = 2
  planes[0].rot = math.pi

  planes[1] = {}
  planes[1].x = 200
  planes[1].y = 300
  planes[1].rot = 0

  return planes
end
