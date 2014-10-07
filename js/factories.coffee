class Glasses
  putOn: ->
    @findMasks()
    @hideLies()
    @showTruth()

  findMasks: ->
    masks = $('iframe')
    new Mask(mask) for mask in masks

  hideLies: ->

  showTruth: ->

class Mask
  constructor: (@mask) ->


class Messages
  constructor: (@height, @width) ->


@putOnTheGlasses = ->
  g = new Glasses
  g.putOn()
