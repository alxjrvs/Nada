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
