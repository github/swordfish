class @InviteRouter extends Backbone.Router
  routes:
    'invite/:key': 'accept'

  accept: (key) ->
    Invite.accept(key).then ->
      Backbone.history.navigate '', true
