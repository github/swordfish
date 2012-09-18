Item.Views ?= {}

class Item.Views.Show extends Backbone.View
  template: 'templates/item/show'

  events:
    'click a.reveal': 'reveal'
    'click a.hide':   'hide'

  serialize: ->
    _.extend @model.toJSON(), data: @model.data()

  reveal: (e) =>
    window.view = @
    e.preventDefault()
    @$('.password').text(@model.data().password)
    @$el.addClass('revealed')

  hide: (e) =>
    e.preventDefault()
    @$('.password').text('••••••••••••')
    @$el.removeClass('revealed')
