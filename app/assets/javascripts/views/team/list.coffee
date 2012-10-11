Team.Views ?= {}

class Team.Views.List extends Backbone.View
  template: 'templates/team/list'

  constructor: ->
    super
    @collection.on 'add reset', @render, @

  beforeRender: =>
    @collection.each @add

  add: (model) =>
    @insertView '.teams', new Team.Views.ListItem(model: model)
