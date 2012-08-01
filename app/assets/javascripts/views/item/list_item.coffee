Item.Views ?= {}

class Item.Views.ListItem extends Backbone.View
  template: 'templates/item/list_item'
  className: 'item'

  serialize: ->
    this.model.toJSON()