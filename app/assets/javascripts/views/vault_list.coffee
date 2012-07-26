class @VaultList extends Backbone.View
  template: '#vault-list-template'

  constructor: ->
    super
    @collection.on 'add',   @add
    @collection.on 'reset', @reset
    @collection.fetch()

  reset: =>
    @collection.each @add
    @render()

  add: (model) =>
    @insertView new VaultListItem(model: model)
