class @Invite extends Backbone.Model
  @accept: (token) ->
    jQuery.ajax
      url: "/invites/#{token}"

  initialize: ->
    @user = new User(user_attrs) if user_attrs = @get('user')

  # FIXME: move
  fulfill: (key) ->
    jQuery.ajax
      type: 'POST'
      url: @url() + "/fulfill"
      data:
        # FIXME: wrap public key and use in Keypair
        key: forge.util.encode64(@user.publicKey().encrypt(key))

  isAccepted: ->
    !!@user
