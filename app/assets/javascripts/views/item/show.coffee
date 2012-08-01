Item.Views ?= {}

class Item.Views.Show extends Backbone.View
  template: 'templates/item/show'

  events:
    'click a.reveal': 'reveal'

  constructor: ->
    super
    @model.on 'reveal', @display

  serialize: ->
    @model.toJSON()

  reveal: (e) =>
    e.preventDefault()
    @model.reveal()

  display: (password) =>
    @$('.password').text(password)