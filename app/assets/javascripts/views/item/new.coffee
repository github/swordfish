Item.Views ?= {}

class Item.Views.New extends Backbone.View
  template: 'templates/item/new'

  events:
    'submit form': 'submit'

  submit: (event) =>
    params = @$('form').toObject(mode: 'combine')
    @collection.create params, success: (item) =>
      Backbone.history.navigate "items/#{item.id}", true
    false
