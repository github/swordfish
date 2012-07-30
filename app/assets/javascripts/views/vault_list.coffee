class @VaultList extends Backbone.View
  template: '#vault-list-template'

  constructor: ->
    super
    @collection.on 'add',   @addOne
    @collection.on 'reset', @reset
    @collection.fetch()

  reset: =>
    @collection.each @add
    @render()

  add: (model) =>
    @insertView new VaultListItem(model: model)

  addOne: (model) =>
    @add(model).render()