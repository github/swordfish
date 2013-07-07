Team.Views ?= {}

class Team.Views.Edit extends Backbone.View
  template: 'templates/team/edit'

  events:
    'submit form': 'submit'

  submit: (event) =>
    params = @$('form').toObject(mode: 'combine')
    @model.save params, success: (team) =>
      Backbone.history.navigate "teams/#{team.id}", true
    false

  serialize: ->
    @model.toJSON()
