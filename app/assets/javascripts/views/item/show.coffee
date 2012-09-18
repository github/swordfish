Item.Views ?= {}

class Item.Views.Show extends Backbone.View
  template: 'templates/item/show'

  events:
    'click a.toggle-password-visibility': 'togglePasswordVisibility'

  serialize: ->
    _.extend @model.toJSON(), data: @model.data()

  togglePasswordVisibility: (e) =>
    e.preventDefault()
    command = @$('.toggle-password-visibility').text()
    if command == "reveal"
      @$('.toggle-password-visibility').text('hide')
      @$('.password').text(@model.data().password)
    else
      @$('.toggle-password-visibility').text('reveal')
      @$('.password').text('••••••••••••')

