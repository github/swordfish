class @Team extends Backbone.Model
  initialize: ->
    @set 'key', @app.keypair.encrypt(ItemKey.generate()) unless @has('key')
    @key = new ItemKey(@app.keypair.decrypt(@get('key')))

    @invites = new Invite.Collection(@get('invites') || [], team: @)

  invite: (email) ->
    @invites.create {email: email}, {wait: true}
