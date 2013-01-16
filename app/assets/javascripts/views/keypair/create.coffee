Keypair.Views ?= {}

class Keypair.Views.Create extends Backbone.View
  template: 'templates/keypair/create'

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
    keypair = @app.setKey(privateKey)
    keypair.unlock(@passphrase)
    Backbone.history.navigate "key/download", true
