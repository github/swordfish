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
      @app.authenticate().done(@done).fail(@fail)
    else
      @fail()

    false

  done: =>
    Backbone.history.navigate '', true

  fail: =>
    @$('p.error').text('Your passphrase was incorrect!')
    @$('input[type=password]').val('')
