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

class Skin

  reject: ->
    $('.nada').remove()

  inject: ->
    $('head').after @font()
    $('head').after @style()

  font: ->
    $('<link />', @fontConfig())

  style: ->
    $('<link />', @styleConfig())

  fontConfig: ->
    {
      class: 'nada',
      href:'http://fonts.googleapis.com/css?family=Didact+Gothic',
      rel: 'stylesheet',
      type: 'text/css'
    }

  styleConfig: ->
    {
      class: 'nada',
      rel: "stylesheet",
      href: "./css/app.css",
      type: "text/css",
      media: "all"
    }

class Message
  @TRUTH: [
    "OBEY"
    "SLEEP"
    "BUY"
    "LIKE"
    "SHARE"
    "CONSUME"
    "CONFORM"
    "SUBMIT"
    "REPRODUCE"
    "RETWEET"
    "MARRY AND REPRODUCE"
    "WORK 8 HOURS"
    "SLEEP 8 HOURS"
    "PLAY 8 HOURS"
    "WATCH YOUTUBE"
    "NO THOUGHT"
    "THIS IS YOUR GOD"
    "NO INDEPENDENT THOUGHT"
  ]
  constructor: (@box) ->
    @text = Message.TRUTH[Math.floor(Math.random() * Message.TRUTH.length)]

  fontSize: ->
    if @box.orientation == "portrait" || @box.orientation == "square"
      quotient = @text.length / 2
      return @box.sansMargins().width / quotient
    else if @box.orientation == "landscape" 
      quotient = @text.length / 4
      return @box.sansMargins().height / quotient

class Truth
  constructor: (@mask) ->
    @buildBox()
    @assignMessage()

  reveal: ->
    $('body').append @theyframe()

  buildBox: ->
    @box = new Box @mask.height, @mask.width, @mask.left, @mask.top

  textContainer: ->
    $('<truth />', @textConfig())

  theyframe: ->
    $('<theyframe />',(@truthConfig())).append @textContainer()

  assignMessage: ->
    @message= new Message @box

  matchingClass: ->
    "#{@message.text}--#{@generateUUID()}"

  textConfig: ->
    {
      text: @message.text
      class: "#{@box.orientation}"
      css: {
        "font-size": "#{@message.fontSize()}px"
        "line-height": "#{@box.lineHeight()}px"

      }
    }

  truthConfig: ->
    {
      class: "#{@matchingClass()}"
      css: {
        height: "#{@box.height}px",
        width: "#{@box.width}px",
        left: "#{@box.left - 10}px",
        top: "#{@box.top - 10}px",
      }
    }

  generateUUID: ->
    return @uuid if @uuid
    d = new Date().getTime()
    @uuid = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, (c) ->
      r = (d + Math.random() * 16) % 16 | 0
      d = Math.floor(d / 16)
      ((if c is "x" then r else (r & 0x7 | 0x8))).toString 16) 
    @uuid


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


@g = new Glasses

@takeOffTheGlasses = ->
  @g.takeOff()

@putOnTheGlasses = ->
  @g.putOn()
