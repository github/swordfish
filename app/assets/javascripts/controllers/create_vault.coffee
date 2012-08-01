class @CreateVault extends Backbone.View
  template: '#new-vault-template'

  events:
    'submit form': 'submit'

  submit: (event) =>
    event.preventDefault()
    vault = @collection.create @params(), success: (vault) =>
      Backbone.history.navigate "#/vaults/#{vault.id}", true

    false

  params: =>
    result = {}
    for input in @$('form').serializeArray()
      result[input.name] = input.value
    result
