Item.Views ?= {}

class Item.Views.Edit extends Backbone.View
  template: 'templates/item/edit'

  events:
    'submit form': 'submit'

  submit: (event) =>
    params = @$('form').toObject(mode: 'combine')
    @model.save params, success: (item) =>
      Backbone.history.navigate "items/#{item.id}", true
    false

  serialize: ->
    _.extend @model.toJSON(), data: @model.data()
