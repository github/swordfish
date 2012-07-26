class @ShowVault extends Backbone.View
  template: '#show-vault-template'

  serialize: ->
    @model.toJSON()
