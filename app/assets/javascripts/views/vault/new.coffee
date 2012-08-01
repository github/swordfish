Vault.Views ?= {}

class Vault.Views.New extends Backbone.View
  template: '#new-vault-template'

  events:
    'submit form': 'submit'

  submit: (event) =>
    event.preventDefault()
    @collection.create @$('form').serializeObject(), success: (vault) =>
      Backbone.history.navigate "#/vaults/#{vault.id}", true

    false
