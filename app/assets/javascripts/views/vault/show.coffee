Vault.Views ?= {}

class Vault.Views.Show extends Backbone.View
  template: 'templates/vault/show'

  serialize: ->
    @model.toJSON()
