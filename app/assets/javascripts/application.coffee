#= require lib/jquery
#= require models

class @Application
  _.extend @prototype, Backbone.Events

  # Host to make Ajax requests to
  @host: null

  # Ajax prefilter to prepend host to request url
  @prependHost: (options, originalOptions, xhr) =>
    if @host
      options.crossDomain = true
      options.url = "#{@host}#{originalOptions.url}"

    return # return value effects dataType

  @on: (args...) ->
    @prototype.on(args...)

  constructor: (@keypair = Keypair.load()) ->
    @trigger 'initialize'

  setKey: (key) ->
    @keypair = new Keypair(key)
    @keypair.savePrivateKey()
    @keypair

  authenticate: ->
    new KeypairAuthenticator(@keypair).request()

  # FIXME: make a class for UI concerns and move this there
  layout: (layout) ->
    unless layout == @current_layout
      @current_layout = layout
      $(document.body).html(layout.el)
      layout.render()

jQuery.ajaxPrefilter Application.prependHost
