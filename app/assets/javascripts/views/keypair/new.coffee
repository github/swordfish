Keypair.Views ?= {}

class Keypair.Views.New extends Backbone.View
  template: 'templates/keypair/new'

  events:
    'submit form':  'generate'

  generate: (event) =>
    passphrase = @$('input[name=passphrase]').val()
    generator = new KeypairGenerator(passphrase).start()
    @start()
    generator.done @done
    false

  start: =>
    @$('#status').text('Generating keys…')

  done: (publicKey, privateKey) =>
    @keypair = new Keypair(publicKey, privateKey)
    @keypair.save()

    view = new Keypair.Views.Download(key: privateKey)
    @setView view
    view.render()
