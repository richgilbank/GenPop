class GenPop
  constructor: ->
    @setGlobals()
    @bindHandlers()

    @draw()

  bindHandlers: ->
    $('#redraw').on 'click', => @draw()
    $('.control-handle').on 'click', -> $(@).parent().toggleClass('active')

  draw: ->
    @paper.clear()
    @drawBackground()
    @drawGrid()

  drawGrid: ->
    numDotsX = Math.floor @width/@gridSpacing
    numDotsY = Math.floor @height/@gridSpacing
    for xCount in [1..numDotsX]
      for yCount in [1..numDotsY]
        # p = new Point xCount * @gridSpacing, yCount * @gridSpacing
        @drawDot xCount * @gridSpacing, yCount * @gridSpacing

  drawBackground: ->
    rect = @paper.rect 0, 0, @width, @height
    rect.attr 'fill', $('#backgroundColor').val()

  drawDot: (x, y) ->
    dot = @paper.circle x, y, 1
    dot.attr 'fill', '#fff'
    dot.attr 'stroke-width', 0

  setGlobals: ->
    @width = $(window).width()
    @height = $(window).height()
    @gridSpacing = 20
    @center =
      x: @width/2
      y: @height/2
    @paper = Raphael($('#canvas')[0], @width, @height);

$ ->
  window.App = new GenPop()

