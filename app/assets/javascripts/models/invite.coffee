class @Invite extends Backbone.Model
  @accept: (token) ->
    jQuery.ajax
      url: "/invites/#{token}"

  constructor: ->
    super
    @user = new User(user_attrs) if user_attrs = @get('user')

  fulfill: (key) ->
    jQuery.ajax
      url: "/invites/#{@get('token')}/fulfill"
      data:
        key: @user.publicKey().encrypt(key)
