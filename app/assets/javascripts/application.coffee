#= require jquery
#= require models

class @Application
  _.extend @prototype, Backbone.Events

  @on: (args...) ->
    @prototype.on(args...)

  constructor: (@keypair = Keypair.load()) ->
    for base in [Backbone.View, Backbone.Model, Backbone.Collection]
      base.prototype.app = @

    @trigger 'initialize'
    @on 'authenticated', @bootstrap

  bootstrap: =>
    @teams = new Team.Collection()
    @items = new Item.Collection()

    new InviteFulfiller(@teams)

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
