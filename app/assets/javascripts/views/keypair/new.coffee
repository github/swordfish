Keypair.Views ?= {}

class Keypair.Views.New extends Backbone.View
  template: 'templates/keypair/new'

  events:
    'submit form':  'generate'

  constructor: (options) ->
    super
    @app = options.app

  generate: (event) =>
    @passphrase = @$('input[name=passphrase]').val()
    generator = new KeypairGenerator(@passphrase).start()
    @start()
    generator.done @done
    false

  start: =>
    @$('#status').text('Generating keys…')

  done: (publicKey, privateKey) =>
    @app.keypair = Keypair.create(publicKey, privateKey)
    @app.keypair.unlock(@passphrase)
    Backbone.history.navigate "key/download", true
