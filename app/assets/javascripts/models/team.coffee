class @Team extends Backbone.Model
  initialize: ->
    @set 'key', @collection.keypair.encrypt(ItemKey.generate()) unless @has('key')
    @invites = new Invite.Collection(@get('invites') || [], team: @)

  key: ->
    new ItemKey(@collection.keypair.decrypt(@get('key')))

  invite: (email) ->
    @invites.create email: email
