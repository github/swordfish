class @Invite extends Backbone.Model
  @accept: (token) ->
    jQuery.ajax
      url: "/invite/#{token}"
