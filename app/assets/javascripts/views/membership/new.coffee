Membership.Views ?= {}

class Membership.Views.New extends Backbone.View
  template: 'templates/memberships/new'

  events:
    'submit form': 'submit'

  submit: (event) =>
    event.preventDefault();
    input = @$el.find('input[type=email]')
    @model.invite(input.val())
    input.val('')
