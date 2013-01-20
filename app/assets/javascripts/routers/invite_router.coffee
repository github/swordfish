class @InviteRouter extends Backbone.Router
  routes:
    'invite/:token': 'accept'

  accept: (token) ->
    Invite.accept(token).then ->
      Backbone.history.navigate '', true
