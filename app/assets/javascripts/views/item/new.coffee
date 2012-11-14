Item.Views ?= {}

class Item.Views.New extends Backbone.View
  template: 'templates/item/new'

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
    @collection.create params,
      success: (item) =>
        Backbone.history.navigate "items/#{item.id}", true
      error: (item) =>
        alert 'boom'

  passwordConfirmed: ->
    @password() == @passwordConfirmation()

  password:             -> @$('#item-password').val()
  passwordConfirmation: -> @$('#item-confirm-password').val()
