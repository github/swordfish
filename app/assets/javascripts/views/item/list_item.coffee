Item.Views ?= {}

class Item.Views.ListItem extends Backbone.View
  template: '#item-template'
  className: 'item'

  serialize: ->
    this.model.toJSON()