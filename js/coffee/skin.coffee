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
