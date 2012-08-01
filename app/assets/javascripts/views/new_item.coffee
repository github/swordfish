class @NewItem extends Backbone.View
  template: '#new-item-template'

  events:
    'submit form': 'submit'

  submit: (event) =>
    @collection.create @$('form').serializeObject(), success: (item) =>
      Backbone.history.navigate "#/vaults/#{@model.id}/items/#{item.id}", true
    false
