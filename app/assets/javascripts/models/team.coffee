class @Team extends Backbone.Model
  initialize: ->
    @set 'key', @collection.keypair.encrypt(ItemKey.generate()) unless @has('key')
    @key = new ItemKey(@collection.keypair.decrypt(@get('key')))

    @invites = new Invite.Collection(@get('invites') || [], team: @)

  invite: (email) ->
    @invites.create {email: email}, {wait: true}
