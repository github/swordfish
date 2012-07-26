class @NewItem extends Backbone.View
  template: '#new-item-template'

  events:
    'submit form': 'submit'

  submit: (event) =>
    @collection.create @$('form').serializeObject()
    false
