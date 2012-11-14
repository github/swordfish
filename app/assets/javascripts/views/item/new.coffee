Item.Views ?= {}

class Item.Views.New extends Backbone.View
  template: 'templates/item/new'

  events:
    'submit form': 'submit'

  submit: (event) =>
    event.preventDefault()
    params = @$('form').toObject(mode: 'combine')
    params.data ||= {}
    params.data.password = @password()
    @collection.create params, success: (item) =>
      Backbone.history.navigate "items/#{item.id}", true
