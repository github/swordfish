Item.Views ?= {}

class Item.Views.ListItem extends Backbone.View
  template: 'templates/item/list_item'
  className: 'item'

  constructor: ->
    super
    @model.on 'change', @render, @

  serialize: ->
    _.extend @model.toJSON(), data: @model.data(), url_domain: @url_domain()

  url_domain: ->
    @model.data().url.replace(/http(s)?:\/\//,"");

