class @InviteRouter extends Backbone.Router
  routes:
    'invites/:token': 'accept'

  accept: (token) ->
    Invite.accept(token).then ->
      Backbone.history.navigate '', true
