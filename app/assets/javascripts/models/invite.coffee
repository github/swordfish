class @Invite extends Backbone.Model
  @accept: (token) ->
    jQuery.ajax
      url: "/invites/#{token}"

  initialize: ->
    @user = new User(user_attrs) if user_attrs = @get('user')

  fulfill: (key) ->
    jQuery.ajax
      type: 'POST'
      url: @url() + "/fulfill"
      data:
        key: @user.publicKey().encrypt(key)

  isAccepted: ->
    !!@user
