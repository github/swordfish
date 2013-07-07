Share.Views ?= {}

class Share.Views.Create extends Backbone.View
  template: 'templates/share/create'

  initialize: ->
    @app.teams.on 'reset', @render, @

  serialize: ->
    teams: @app.teams.toJSON()

  events:
    'submit form': 'submit'

  submit: (event) =>
    event.preventDefault();
    input = @$el.find('select[name=team]')
    team = @app.teams.get(input.val())
    @model.share(team)
    input.val('')
