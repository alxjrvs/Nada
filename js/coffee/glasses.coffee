class Glasses
  constructor: -> 
    @skin = new Skin

  toggle: ->
    if @on
      @takeOff()
    else
      @putOn();

  putOn: ->
    @findMasks()
    @hideLies()
    @showTruths()
    @on = true;

  takeOff: ->
    @restoreLies()
    @removeTruth()
    @skin.reject()
    @on = false;

  findMasks: ->
    masks = document.getElementsByTagName 'iframe'
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

