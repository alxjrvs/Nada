class Glasses
  constructor: -> 
    @skin = new Skin

  putOn: ->
    @findMasks()
    @hideLies()
    @showTruths()

  takeOff: ->
    @restoreLies()
    @removeTruth()
    @skin.reject()

  findMasks: ->
    masks = $('iframe')
    @masks = for mask in masks
      new Mask mask

  restoreLies: ->
    for mask in @masks
      mask.show()

  hideLies: ->
    for mask in @masks
      mask.hide()

  showTruths: ->
    @assembleTruths()
    @skin.inject()
    for truth in @truths
      truth.reveal()

  removeTruth: ->
    $('theyframe').remove()

  assembleTruths: ->
    @truths = @masks.map (mask) ->
      new Truth mask

