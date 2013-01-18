class Invite.Collection extends Backbone.Collection
  constructor: (models, options) ->
    @team = options.team
    super

  url: ->
    @team.url() + '/invites'
