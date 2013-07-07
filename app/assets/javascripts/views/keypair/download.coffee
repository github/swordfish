Keypair.Views ?= {}

class Keypair.Views.Download extends Backbone.View
  template: 'templates/keypair/download'

  initialize: (options) ->
    @app = options.app

  serialize: ->
    {href: @dataUri()}

  dataUri: ->
    "data:application/x-pem-file,#{encodeURIComponent(@app.keypair.pem)}"
