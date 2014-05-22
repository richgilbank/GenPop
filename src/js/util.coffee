window.polygonPath = (points) ->
  console.log points
  return [] if !points || points.length < 2
  path = []
  path.push ['m', points[0], points[1]]
  for i in [2..points.length - 1] by 2
    path.push ['l', points[i], points[i+1]]
  path.push ['z']
  path

