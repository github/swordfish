Item.Views ?= {}

class Item.Views.Show extends Backbone.View
  template: 'templates/item/show'

  events:
    'click a.reveal': 'reveal'

  serialize: ->
    _.extend @model.toJSON(), data: @model.data()

  reveal: (e) =>
    e.preventDefault()
    @$('.password').text(@model.data().password)
