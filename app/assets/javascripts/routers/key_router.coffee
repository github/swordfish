class @KeyRouter extends Backbone.Router
  routes:
    'key/create':   'create'
    'key/download': 'download'
    'key/load':     'load'
    'key/unlock':   'unlock'
    'key/authenticate': 'authenticate'

  constructor: (options) ->
    super
    @app = options.app
    @layout = new Backbone.LayoutManager(
      template: 'templates/setup'
    )
    @on 'all', @ensureLayout

    if @app.keypair
      window.location.hash = "#key/unlock" unless @app.keypair.isUnlocked()
    else
      window.location.hash = "#key/create"

  create: ->
    @layout.setView('#content', new Keypair.Views.Create(app: @app)).render()

  download: ->
    @layout.setView('#content', new Keypair.Views.Download(app: @app)).render()

  load: ->
    @layout.setView('#content', new Keypair.Views.Load(app: @app)).render()

  unlock: ->
    @layout.setView('#content', new Keypair.Views.Unlock(app: @app)).render()

  authenticate: ->
    @app.authenticate()

  ensureLayout: =>
    @app.layout @layout

