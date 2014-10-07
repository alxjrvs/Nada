class Glasses
  putOn: ->
    @findMasks()
    @hideLies()
    @showTruth()

  findMasks: ->
    masks = $('iframe')
    @masks = _.map masks, (mask) ->
      new Mask mask

  hideLies: ->
    _.each @masks, (mask) ->
      mask.hide()

  showTruth: ->

class Mask
  constructor: (@mask) ->
    @buildMask()

  buildMask: ->
    @height = @mask.offsetHeight
    @width = @mask.offsetWidth
    @left = @mask.offsetLeft
    @top = @mask.offsetTop

  hide: ->
    @mask.style.visibility = "hidden"
    @placeMessage()

  show: ->
    @removeMessage()
    @mask.style.visibility = "visible"

  message: ->
    return new Message @height, @width, @left, @top

  removeMessage: ->

  placeMessage: ->
    $('head').after @message().skin()
    $('body').after @message().truth()

class Message
  constructor: (@height, @width, @left, @top) ->

  skin: ->
    $('<link />', @skinConfig())

  skinConfig: ->
    {
      rel: "stylesheet",
      href: "./css/skin.css",
      type: "text/css",
      media: "all"
    }


  truth: ->
    $('<theyframe />', @truthConfig())

  truthConfig: ->
    {
      text: "OBEY"
      css: {
        height: "#{@height}px",
        width: "#{@width}px",
        left: "#{@left}px",
        top: "#{@top}px",
        position: "absolute",
        background: "white",
        color: "black",
        border: "solid 10px black",
        "text-align": "center",
        "font-size": "32px",
        "line-height": "#{@height}px"
      }
    }
@g = new Glasses

@putOnTheGlasses = ->
  @g.putOn()
