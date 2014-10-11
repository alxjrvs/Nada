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

  sansMargins: ->
    {
      height: @height - (@height * .2),
      width: @width - (@width * .2)
    }

  lineHeight: ->
    return @height
