#= require jquery
#= require models

class @Application
  _.extend @prototype, Backbone.Events

  @on: (args...) ->
    @prototype.on(args...)

  constructor: (@keypair = Keypair.load()) ->
    @trigger 'initialize'
    @on 'authenticated', @bootstrap

  bootstrap: =>
    @items = new Item.Collection([], keypair: @keypair)
    @teams = new Team.Collection([], keypair: @keypair)

    @items.fetch()
    @teams.fetch()

    @trigger 'ready'

  setKey: (key) ->
    @keypair = new Keypair(key)
    @keypair.savePrivateKey()
    @keypair

  authenticate: ->
    new KeypairAuthenticator(@keypair).request().done =>
      @trigger 'authenticated'

  # FIXME: make a class for UI concerns and move this there
  layout: (layout) ->
    unless layout == @current_layout
      @current_layout = layout
      $(document.body).html(layout.el)
      layout.render()
