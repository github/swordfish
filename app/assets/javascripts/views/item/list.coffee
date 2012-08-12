Item.Views ?= {}

class Item.Views.List extends Backbone.View
  template: 'templates/item/list'

  constructor: ->
    super
    @collection.on 'add reset', @render, @
    @collection.fetch()

  beforeRender: =>
    @collection.each @add

  add: (model) =>
    @insertView '.items', new Item.Views.ListItem(model: model)
