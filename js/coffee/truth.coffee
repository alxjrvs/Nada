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

