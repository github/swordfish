Vault.Views ?= {}

class Vault.Views.List extends Backbone.View
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
    @insertView new Vault.Views.ListItem(model: model)

  addOne: (model) =>
    @add(model).render()