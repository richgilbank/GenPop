class window.Triangle
  constructor: (@index) ->
    rootPoint = @pickRandomPoint()
    @points = [rootPoint]
    @alive = true
    @selectNeighbouringPoints()
    @draw()

  calculateDistanceFromCenter: ->
    avgX = (@points[0].x + @points[1].x + @points[2].x)/3
    avgY = (@points[0].y + @points[1].y + @points[2].y)/3
    a = App.center.x - avgX
    b = App.center.y - avgY
    c = Math.sqrt((a*a) + (b*b))
    Math.abs(c)

  draw: ->
    if @alive
      pathString = "M #{@points[0].x} #{@points[0].y} L #{@points[1].x} #{@points[1].y} L #{@points[2].x} #{@points[2].y} z"
      @el = App.paper.path pathString
      @el.attr
        'fill': @triangleColor()
        'fill-opacity': @triangleAlpha()
        'stroke-width': 0.5
        'stroke': $('#pointColor').val()
        'stroke-opacity': Math.random() - 0.5

  pickRandomPoint: ->
    index = Math.floor(Math.random() * App.points.length)
    App.points[index]

  selectNeighbouringPoints: ->
    neighbours = @points[0].getNeighbours()
    if neighbours.length >= 2
      @points.push neighbours[Math.floor(Math.random() * neighbours.length)]
      @points.push neighbours[Math.floor(Math.random() * neighbours.length)]
    else
      delete App.triangles[@index]
      @alive = false

  triangleAlpha: ->
    dfc = @calculateDistanceFromCenter()
    dfc / App.maxDistanceFromCenter

  triangleColor: ->
    num = Math.floor(Math.random() * 2) + 1
    $("#color#{num}").val()

