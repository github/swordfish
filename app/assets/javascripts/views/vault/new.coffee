Vault.Views ?= {}

class Vault.Views.New extends Backbone.View
  template: 'templates/vault/new'

  events:
    'submit form': 'submit'

  submit: (event) =>
    event.preventDefault()
    @collection.create @$('form').serializeObject(), success: (vault) =>
      Backbone.history.navigate "#/vaults/#{vault.id}", true

    false
