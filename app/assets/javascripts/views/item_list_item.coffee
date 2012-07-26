class @ItemListItem extends Backbone.View
  template: '#item-template'
  className: 'item'

  serialize: ->
    this.model.toJSON()