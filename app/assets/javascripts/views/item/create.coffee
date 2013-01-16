Item.Views ?= {}

class Item.Views.Create extends Item.Views.Form
  template: 'templates/item/create'

  save: (params) ->
    @collection.create params, success: (item) =>
        Backbone.history.navigate "items/#{item.id}", true
