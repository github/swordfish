Item.Views ?= {}

class Item.Views.ListItem extends Backbone.View
  template: 'templates/item/list_item'
  className: 'item'

  constructor: ->
    super
    @model.on 'change', @render, @

  serialize: ->
    _.extend @model.toJSON(), data: @model.data(), domain: @domain()

  domain: ->
    a = document.createElement('a')
    a.href = @model.data().url
    a.hostname

