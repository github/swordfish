Share.Views ?= {}

class Share.Views.List extends Backbone.View
  template: 'templates/share/list'

  initialize: (options) ->
    @setView '#create-share', new Share.Views.Create(model: @model)

    @model.shares.on 'add reset', @render, @

  beforeRender: =>
    @model.shares.each @add

  add: (model) =>
    @insertView 'ul', new Share.Views.Show(model: model)
