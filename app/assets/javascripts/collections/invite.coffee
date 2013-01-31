class Invite.Collection extends Backbone.Collection
  model: Invite

  constructor: (models, options) ->
    @team = options.team
    super

  url: ->
    @team.url() + '/invites'

  accepted: ->
    @filter (invite) -> invite.isAccepted()
