Keypair.Views ?= {}

class Keypair.Views.Unlock extends Backbone.View
  template: 'templates/keypair/unlock'

  events:
    'submit form': 'submit'

  constructor: (options) ->
    super
    @app = options.app

  afterRender: ->
    @$('input:first').focus()

  submit: (e) =>
    if @app.keypair.unlock(@$('input[type=password]').val())
      Backbone.history.navigate 'key/auth', true
    else
      @$('p.error').text('Your passphrase was incorrect!')
      @$('input[type=password]').val('')

    false
