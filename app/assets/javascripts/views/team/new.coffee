Team.Views ?= {}

class Team.Views.New extends Backbone.View
  template: 'templates/team/new'

  events:
    'submit form': 'submit'

  submit: (event) =>
    event.preventDefault();
    params = @$('form').toObject(mode: 'combine')
    @collection.create params, success: (item) =>
      Backbone.history.navigate "teams/#{item.id}", true
    false
