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

