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
