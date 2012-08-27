Keypair.Views ?= {}

class Keypair.Views.Auth extends Backbone.View

  constructor: (options) ->
    super
    @app = options.app
    @auth = new KeypairAuthenticator(@app.keypair)
    @auth.request().done(@complete)

  complete: =>
    Backbone.history.navigate '', true

