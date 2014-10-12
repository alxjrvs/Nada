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
    masks = document.getElementsByTagName 'img'
    @masks = for mask in masks
      console.log mask
      new Mask mask

  restoreLies: ->
    for mask in @masks
      console.log mask
      mask.show()

  hideLies: ->
    for mask in @masks
      mask.hide()

  showTruths: ->
    @skin.inject()
    @truths = @masks.map (mask) ->
      truth = new Truth mask
      truth.reveal()
      truth

  removeTruth: ->
    theyframe = document.findElementsByTagName 'theyframe'


