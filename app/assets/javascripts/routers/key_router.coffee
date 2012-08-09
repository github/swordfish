class @KeyRouter extends Backbone.Router
  routes:
    'key/new': 'newKey'

  constructor: (options) ->
    super
    @app = options.app
    @layout = new Backbone.LayoutManager(
      template: 'templates/setup'
    )
    @on 'all', @ensureLayout

    unless @app.user.public_key
      window.location.hash = "#key/new"

  newKey: ->
    @layout.setView('#content', new Keypair.Views.New).render()

  ensureLayout: =>
    @app.layout @layout

