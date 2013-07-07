Team.Views ?= {}

class Team.Views.ListItem extends Backbone.View
  template: 'templates/team/list_item'
  className: 'team'

  constructor: ->
    super
    @model.on 'change', @render, @

  serialize: ->
    this.model.toJSON()