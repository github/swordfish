Invite.Views ?= {}

class Invite.Views.Show extends Backbone.View
  template: 'templates/invite/show'
  tagName: 'li'

  serialize: ->
    @model.toJSON()
