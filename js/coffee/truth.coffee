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

