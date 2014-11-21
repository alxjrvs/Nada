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

  lineHeight: ->
    return @height

class Skin
  constructor: ->
  reject: ->
    for link in ['http://fonts.googleapis.com/css?family=Didact+Gothic', chrome.extension.getURL("css/app.css")]
      match = @findLink(link)
      if match.length > 0
        skin = match[0]
        skin.parentElement.removeChild skin

  inject: ->
    @injectHead()
    @injectContainer()

  injectContainer: ->
    body = document.getElementsByTagName('body')[0]
    containerElement = @containerElement()
    body.appendChild containerElement

  injectHead: ->
    head = document.getElementsByTagName('head')[0]
    fontElement = @fontElement()
    styleElement = @styleElement()
    head.appendChild fontElement
    head.appendChild styleElement

  containerElement: ->
    containers = document.getElementsByTagName 'theycontainer'
    if containers.length > 0
      @element = containers[0]
    else
      @element = document.createElement 'theycontainer'
    @element

  fontElement: ->
    @findOrCreateLink @fontConfig(), 'http://fonts.googleapis.com/css?family=Didact+Gothic'

  styleElement: ->
    @findOrCreateLink @styleConfig(), chrome.extension.getURL("css/app.css")


  findOrCreateLink: (config, link) ->
    matches = @findLink(link)
    element = null
    if matches.length > 0
      element = matches[0]
    else
      element = config
    element


  findLink: (link) ->
    elements = document.getElementsByTagName('link')
    matches = []
    elements = for element in elements
      if element.href == link
        matches.push (element)
    matches

  fontConfig: ->
    elem = document.createElement 'link'
    elem.class = 'nada'
    elem.href = 'http://fonts.googleapis.com/css?family=Didact+Gothic'
    elem.rel = 'stylesheet'
    elem.type = 'text/css'
    elem

  styleConfig: ->
    elem = document.createElement 'link'
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
    quotient = @text.length / 1.3
    fontSize = @box.width / quotient

class Truth
  constructor: (@mask) ->
    @buildBox()
    @assignMessage()

  reveal: ->
    container = document.getElementsByTagName('theycontainer')[0]
    theyframe = @theyframe()
    container.appendChild theyframe

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
    elem.class = "#{@matchingClass()}"
    elem.innerHTML = @message.text
    elem.style["font-size"] = "#{@message.fontSize()}px"
    elem.style["line-height"] = "#{@box.lineHeight()}px"
    elem

  truthConfig: (elem) ->
    elem.class = "#{@matchingClass()}"
    elem.style.height = "#{@box.height}px"
    elem.style.width = "#{@box.width}px"
    elem.style.left = "#{@box.left}px"
    elem.style.top = "#{@box.top}px"
    elem.style.border = "solid #{@borderWidth()}px black"
    elem

  borderWidth: ->
    borderWidth = @box.width / 50

    if borderWidth > 4
      borderwidth = 4
    else if borderWidth < 1
      borderWidth = 1
    borderWidth

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





unless @g
  @g = new Glasses

@g.toggle()
