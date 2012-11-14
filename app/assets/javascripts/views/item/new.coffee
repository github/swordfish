Item.Views ?= {}

class Item.Views.New extends Item.Views.Form
  template: 'templates/item/new'

  save: (params) ->
    @collection.create params, success: (item) =>
        Backbone.history.navigate "items/#{item.id}", true
