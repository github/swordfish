# Fulfills accepted invites
#
# Looks for invites that have been accepted and fulfills them by re-encrypting
# the team key with the user's public key.
class @InviteFulfiller
  constructor: (@teams) ->
    @teams.on 'refresh', @refresh

  refresh: =>
    @teams.each (team) ->
      invite.fulfill(team.key().key) for invite in team.invites.accepted()
