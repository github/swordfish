Vault.Views ?= {}

class Vault.Views.Show extends Backbone.View
  template: '#show-vault-template'

  serialize: ->
    @model.toJSON()
