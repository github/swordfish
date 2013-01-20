class @Invite extends Backbone.Model
  @accept: (key) ->
    jQuery.ajax
      url: "/invite/#{key}"
