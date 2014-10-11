class Mask
  constructor: (@element) ->
    @height = @element.offsetHeight
    @width = @element.offsetWidth
    @left = @element.offsetLeft
    @top = @element.offsetTop

  hide: ->
    @element.style.visibility = "hidden"

  show: ->
    @element.style.visibility = "visible"

