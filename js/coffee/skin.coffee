class Skin
  constructor: -> 
  reject: ->
    $('.nada').remove()

  inject: ->
    head = document.getElementsByTagName('head').item().innerHTML
    head +  @font()
    head + @style()

  font: ->
    debugger
    "<link #{@digest @fontConfig() }>"

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
      href: chrome.extension.getURL("css/app.css")
      type: "text/css",
      media: "all"
    }

  digest: (map) ->
    line = null
    for key, value in map
      line = line + "#{key}=#{value}"
    line
