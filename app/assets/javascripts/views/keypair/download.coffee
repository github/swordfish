Keypair.Views ?= {}

class Keypair.Views.Download extends Backbone.View
  template: 'templates/keypair/download'

  events:
    'click a.download': 'done'

  done: ->
    Backbone.history.navigate '', true

  constructor: (options) ->
    @app = options.app
    super

  serialize: ->
    {href: @dataUri()}

  dataUri: ->
    "data:application/x-pem-file,#{encodeURIComponent(@app.keypair.privateKeyPem)}"
