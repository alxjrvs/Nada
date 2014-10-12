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
  constructor: ->
  reject: ->
    $('.nada').remove()

  inject: ->
    head = document.getElementsByTagName('head')[0]
    fontElement = @fontElement()
    styleElement = @styleElement()
    head.appendChild fontElement
    head.appendChild styleElement

  fontElement: ->
    element = document.createElement 'link'
    @fontConfig element

  styleElement: ->
    element = document.createElement 'link'
    @styleConfig element

  fontConfig: (elem) ->
      elem.class = 'nada'
      elem.href = 'http://fonts.googleapis.com/css?family=Didact+Gothic'
      elem.rel = 'stylesheet'
      elem.type = 'text/css'
      elem

  styleConfig: (elem) ->
      elem.class ='nada'
      elem.rel = "stylesheet"
      elem.href = chrome.extension.getURL("css/app.css")
      elem.type = "text/css"
      elem.media = "all"
      elem

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
    body = document.getElementsByTagName('body')[0]
    theyframe = @theyframe()
    console.log theyframe
    body.appendChild theyframe

  buildBox: ->
    @box = new Box @mask.height, @mask.width, @mask.left, @mask.top

  textContainer: ->
    element = document.createElement 'truth'
    @textConfig element

  theyframe: ->
    element = document.createElement 'theyframe'
    theyframe = @truthConfig element
    theyframe.appendChild @textContainer()
    theyframe

  assignMessage: ->
    @message = new Message @box

  matchingClass: ->
    "#{@message.text}--#{@generateUUID()}"

  textConfig: (elem) ->
    elem.innerHTML = @message.text
    elem.style["font-size"] = "#{@message.fontSize()}px"
    elem.style["line-height"] = "#{@box.lineHeight()}px"
    elem

  truthConfig: (elem) ->
    elem.class = "#{@matchingClass()}"
    elem.style.height = "#{@box.height}px"
    elem.style.width = "#{@box.width}px"
    elem.style.left = "#{@box.left - 10}px"
    elem.style.top = "#{@box.top - 10}px"
    elem

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
    rect = @element.getBoundingClientRect()
    @height = rect.height
    @width = rect.width
    @left = rect.left
    @top = rect.top

  hide: ->
    @element.style.visibility = "hidden"

  show: ->
    @element.style.visibility = "visible"


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



@g = new Glasses
@g.toggle()
