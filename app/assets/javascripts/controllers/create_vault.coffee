class @CreateVault extends Backbone.View
  events:
    'submit': 'submit'

  submit: (event) =>
    event.preventDefault()
    @collection.create(@params())
    false

  params: =>
    result = {}
    for input in @$el.serializeArray()
      result[input.name] = input.value
    result