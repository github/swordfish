Item.Views ?= {}

class Item.Views.Form extends Backbone.View
  events:
    'submit form': 'submit'
    'keyup #item-password': 'checkPassword'
    'change #item-password': 'checkPassword'
    'keyup #item-confirm-password': 'checkPassword'
    'change #item-confirm-password': 'checkPassword'

  checkPassword: =>
    @$('#item-password-confirmation-status').attr 'class',
      if @passwordConfirmed()
        if @password()
          'match'
        else
          ''
      else
        'mismatch'

  submit: (event) =>
    event.preventDefault()
    return unless @passwordConfirmed()
    params = @$('form').toObject(mode: 'combine')
    params.data ||= {}
    params.data.password = @password()
    @save(params)

  passwordConfirmed: ->
    @password() == @passwordConfirmation()

  password:             -> @$('#item-password').val()
  passwordConfirmation: -> @$('#item-confirm-password').val()
