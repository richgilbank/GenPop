class window.Point
  constructor: (@x, @y) ->
    @alive = true

  calculateDistance: (x, y) ->
    a = x - @x
    b = y - @y
    c = Math.sqrt((a*a) + (b*b))
    Math.abs(c)

  die: ->
    @alive = false

  drawDot: ->
    @dot = App.paper.circle @x, @y, 1
    @dot.attr
      'fill': $('#pointColor').val()
      'fill-opacity': Math.random()
      'stroke-width': 0

  distanceFromCenter: ->
    @calculateDistance(App.center.x, App.center.y)

  getNeighbours: ->
    allNeighbours = []
    for point in App.points
      unless point == @ || !point.alive
        allNeighbours.push point if @inRadius(point.x, point.y, $('#sizeTriangles').val())
    allNeighbours

  inRadius: (x, y, radius) ->
    d = @calculateDistance(x, y)
    d <= radius

  survivalCoefficient: ->
    mu = @distanceFromCenter() / App.maxDistanceFromCenter
    # We weight it more towards distance than randomness
    (5*mu) * (3*Math.random())/8

