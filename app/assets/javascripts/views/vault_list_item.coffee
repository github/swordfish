class @VaultListItem extends Backbone.View
  template: '#vault-template'
  className: 'vault'

  serialize: ->
    this.model.toJSON()