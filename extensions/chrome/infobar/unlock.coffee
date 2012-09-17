class Infobar.Unlock extends Backbone.TemplateView
  template: 'chrome/infobar/unlock'

  events:
    'submit form': 'submit'

  constructor: (options) ->
    super
    @infobar = options.infobar

  render: ->
    super
    @$('input:first').focus()
    @

  submit: (e) =>
    passphrase = @$('input[type=password]').val()
    @infobar.extension.send('unlock', passphrase).done(@done).fail(@fail)
    false

  done: =>
    @infobar.save()

  fail: =>
    @$('.error').show().text('Incorrect passphrase!')
    @$('input[type=password]').val('').focus()
