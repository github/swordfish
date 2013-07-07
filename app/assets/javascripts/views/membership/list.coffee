Membership.Views ?= {}

class Membership.Views.List extends Backbone.View
  template: 'templates/memberships/list'

  constructor: ->
    super
    @model.invites.on 'add reset', @render, @

  beforeRender: =>
    @model.invites.each @add

  add: (model) =>
    @insertView 'ul', new Invite.Views.Show(model: model)
