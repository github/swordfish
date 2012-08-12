class @KeyRouter extends Backbone.Router
  routes:
    'key/new':      'newKey'
    'key/download': 'download'
    'key/load':     'load'
    'key/unlock':   'unlock'

  constructor: (options) ->
    super
    @app = options.app
    @layout = new Backbone.LayoutManager(
      template: 'templates/setup'
    )
    @on 'all', @ensureLayout

    if !@app.keypair
      window.location.hash = "#key/new"
    else if !@app.keypair.privateKeyPem
      window.location.hash = "#key/load"
    else if !@app.keypair.isUnlocked()
      window.location.hash = "#key/unlock"

  newKey: ->
    @layout.setView('#content', new Keypair.Views.New(app: @app)).render()

  download: ->
    @layout.setView('#content', new Keypair.Views.Download(app: @app)).render()

  load: ->
    @layout.setView('#content', new Keypair.Views.Load(app: @app)).render()

  unlock: ->
    @layout.setView('#content', new Keypair.Views.Unlock(app: @app)).render()

  ensureLayout: =>
    @app.layout @layout

