Keypair.Views ?= {}

class Keypair.Views.Download extends Backbone.View
  template: 'templates/keypair/download'

  constructor: (options) ->
    @key = options.key
    super

  serialize: ->
    {href: @dataUri()}

  dataUri: ->
    "data:application/x-pem-file,#{encodeURIComponent(@key)}"
