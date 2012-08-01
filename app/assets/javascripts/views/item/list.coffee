Item.Views ?= {}

class Item.Views.List extends Backbone.View
  tagName: 'ul'

  constructor: ->
    super
    @collection.on 'add',   @addOne
    @collection.on 'reset', @reset
    @collection.fetch()

  reset: =>
    @collection.each @add
    @render()

  add: (model) =>
    @insertView new Item.Views.ListItem(model: model)

  addOne: (model) =>
    @add(model).render()