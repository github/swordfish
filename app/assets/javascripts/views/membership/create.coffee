Membership.Views ?= {}

class Membership.Views.Create extends Backbone.View
  template: 'templates/memberships/create'

  events:
    'submit form': 'submit'

  submit: (event) =>
    event.preventDefault();
    input = @$el.find('input[type=email]')
    @model.invite(input.val())
    input.val('')
