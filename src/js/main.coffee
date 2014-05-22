class window.GenPop
  constructor: ->
    @setGlobals()
    @bindHandlers()

  bindHandlers: ->
    $('#redraw').on 'click', => @draw()
    $('.control-handle').on 'click', -> $(@).parent().toggleClass('active')
    $('#save').on 'click', => @save()

  draw: ->
    @paper.clear()
    @drawBackground()
    @drawGrid()
    @drawTriangles()

  drawGrid: ->
    numDotsX = Math.floor @width/@gridSpacing
    numDotsY = Math.floor @height/@gridSpacing
    pointIndex = 0
    for xCount in [1..numDotsX]
      for yCount in [1..numDotsY]
        p = new Point xCount * @gridSpacing, yCount * @gridSpacing
        if p.survivalCoefficient() < 0.1
          @points.push p
          p.index = pointIndex
          p.drawDot()
          pointIndex++
        else
          p.die()

  drawBackground: ->
    rect = @paper.rect 0, 0, @width, @height
    rect.attr 'fill', $('#backgroundColor').val()

  drawTriangles: ->
    num = $('#numTriangles').val()
    @triangles = []
    for i in [0..num-1]
      @triangles[i] = new Triangle(i)

  save: ->
    svgString = @paper.toSVG()
    a = document.createElement 'a'
    a.download = 'art.svg'
    a.type = 'image/svg+xml'
    blob = new Blob [svgString],
      type: 'image/svg+xml'
    a.href = (window.URL || webkitURL).createObjectURL(blob)
    a.click()

  setGlobals: ->
    @width = $(window).width()
    @height = $(window).height()
    @gridSpacing = 20
    @points = []
    @center =
      x: @width/2
      y: @height/2
    @maxDistanceFromCenter = Math.sqrt((@center.x*@center.x)+(@center.y*@center.y))

    @paper = Raphael($('#canvas')[0], @width, @height);

$ ->
  window.App = new GenPop()
  App.draw()

