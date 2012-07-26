class @CreateVault extends Backbone.View
  template: '#new-vault-template'

  events:
    'submit form': 'submit'

  submit: (event) =>
    event.preventDefault()
    @collection.create(@params())
    false

  params: =>
    result = {}
    for input in @$('form').serializeArray()
      result[input.name] = input.value
    result
