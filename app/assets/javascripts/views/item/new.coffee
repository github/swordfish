Item.Views ?= {}

class Item.Views.New extends Backbone.View
  template: 'templates/item/new'

  events:
    'submit form': 'submit'

  submit: (event) =>
    @collection.create @$('form').serializeObject(), success: (item) =>
      Backbone.history.navigate "#/vaults/#{@model.id}/items/#{item.id}", true
    false
