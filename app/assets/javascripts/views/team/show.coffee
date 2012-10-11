Team.Views ?= {}

class Team.Views.Show extends Backbone.View
  template: 'templates/team/show'

  serialize: ->
    @model.toJSON()
