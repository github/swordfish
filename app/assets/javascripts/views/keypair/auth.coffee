Keypair.Views ?= {}

class Keypair.Views.Auth extends Backbone.View

  constructor: (options) ->
    super
    @app = options.app
    @auth = new KeypairAuthenticator(@app.keypair).done(@setHeader).done(@complete)
    @auth.request()

  complete: =>
    Backbone.history.navigate '', true

  setHeader: (challenge) =>
    jQuery.ajaxPrefilter (options, originalOptions, xhr) ->
      xhr.setRequestHeader('X-Challenge', challenge)
