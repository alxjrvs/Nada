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
