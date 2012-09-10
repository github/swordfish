#= require lib/jquery
#= require lib/underscore
#= require lib/backbone
#= require forge
#= require_tree ./lib
#= require hogan
#= require_tree ./ext
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers
#= require_self

class @Application

  constructor: ->
    new KeyRouter(app: @)
    new ItemRouter(app: @)
    Backbone.history.start()

  layout: (layout) ->
    unless layout == @current_layout
      @current_layout = layout
      $(document.body).html(layout.el)
      layout.render()
