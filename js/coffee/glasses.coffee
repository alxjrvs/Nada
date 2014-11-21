class Glasses
  constructor: ->
    @skin = new Skin

  toggle: ->
    if @on()
      @takeOff()
    else
      @putOn()

  putOn: ->
    @skin.inject()
    @showTruth()

  takeOff: ->
    @skin.reject()
    @removeTruth()


  removeTruth: ->
    for container in @theyContainer()
      container.parentElement.removeChild container

  showTruth: ->
    @truths = @allMasks().map (mask) ->
      truth = new Truth mask
      truth.reveal()
      truth

  allMasks: ->
    masks = document.getElementsByTagName 'img'
    @masks = for mask in masks
      new Mask mask

  on: ->
    if @theyContainer().length > 0
      return true
    else
      return false

  theyContainer: ->
    document.getElementsByTagName('theycontainer')




