#= require lib/jquery
#= require models

class @Application
  _.extend @prototype, Backbone.Events

  @on: (args...) ->
    @prototype.on(args...)

  constructor: ->
    @trigger 'initialize'

  setKeypair: (@keypair) ->
    @keypair.savePrivateKey()

  authenticate: ->
    new KeypairAuthenticator(@keypair).request()

  # FIXME: make a class for UI concerns and move this there
  layout: (layout) ->
    unless layout == @current_layout
      @current_layout = layout
      $(document.body).html(layout.el)
      layout.render()
