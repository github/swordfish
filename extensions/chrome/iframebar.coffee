class @Iframebar
  styles:
    position: 'fixed'
    zIndex: 2147483648 # biggest 32bit integer
    top: 0
    left: 0
    width: '100%'
    height: '40px'
    border: 'none'
    borderBottom: '1px solid #8E8E8E'

  constructor: (@extension, path) ->
    @url = @extension.url(path)

    @iframe = document.createElement('iframe')
    @iframe.src = @url
    for property, value of @styles
      @iframe.style[property] = value

    document.body.appendChild @iframe

    window.addEventListener 'message', @message, true

  message: (event) =>
    @dismiss() if event.data == "dismiss"

  dismiss: ->
    @iframe.parentElement.removeChild(@iframe)
    @extension.send 'dismiss'
