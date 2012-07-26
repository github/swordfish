class @ItemList extends Backbone.View
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
    @insertView new ItemListItem(model: model)

  addOne: (model) =>
    @add(model).render()