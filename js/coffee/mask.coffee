class Mask
  constructor: (@element) ->
    rect = @element.getBoundingClientRect()
    @height = rect.height
    @width = rect.width
    @left = rect.left
    @top = rect.top

  hide: ->
    @element.style.visibility = "hidden"

  show: ->
    @element.style.visibility = "visible"

