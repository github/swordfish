Keypair.Views ?= {}

class Keypair.Views.Auth extends Backbone.View

  constructor: (options) ->
    super
    @app = options.app
    @app.keypair.authenticate()
    @app.keypair.bind 'authenticated', @complete

  complete: =>
    # redirect to app

