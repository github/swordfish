Keypair.Views ?= {}

class Keypair.Views.Unlock extends Backbone.View
  template: 'templates/keypair/unlock'

  events:
    'submit form': 'submit'

  constructor: (options) ->
    super
    @app = options.app

  submit: (e) =>
    @app.keypair.unlock(@$('input[type=password]').val())
    Backbone.history.navigate '', true
    false