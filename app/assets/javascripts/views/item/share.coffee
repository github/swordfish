Item.Views ?= {}

class Item.Views.Share extends Backbone.View
  template: 'templates/item/share'

  events:
    'submit form': 'share'

  serialize: ->
    {
      id: @model.id
      teams: @app.teams.toJSON()
    }

  share: (e) =>
    e.preventDefault()
    team = @app.teams.get(@$('form .team_id').val())
    @model.share(team)
