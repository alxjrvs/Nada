class Box
  constructor: (@height, @width, @left, @top) ->
    @determineOrientation()

  determineOrientation: ->
    if @height > @width
      @orientation = 'portrait'
    else if @width > @height
      @orientation = 'landscape'
    else
      @orientation = 'square'

  lineHeight: ->
    return @height
