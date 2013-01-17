Team.Views ?= {}

class Team.Views.Create extends Backbone.View
  template: 'templates/team/create'

  events:
    'submit form': 'submit'

  submit: (event) =>
    event.preventDefault();
    params = @$('form').toObject(mode: 'combine')
    @collection.create params, success: (item) =>
      Backbone.history.navigate "teams/#{item.id}", true
    false
