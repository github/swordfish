Item.Views ?= {}

class Item.Views.Edit extends Item.Views.Form
  template: 'templates/item/edit'

  save: (params) ->
    @model.save params, success: (item) =>
      Backbone.history.navigate "items/#{item.id}", true

  serialize: ->
    _.extend @model.toJSON(), data: @model.data()
