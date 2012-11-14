#= require hogan
#= require lib/backbone.layoutmanager
#= require lib/form2js
#= require lib/jquery.toObject
#= require lib/mustache
#= require ext/backbone.layoutmanager

#= require_tree ./templates
#= require_tree ./views
#= require_tree ./routers

Application.on 'initialize', ->
  new KeyRouter(app: @)
  new ItemRouter(app: @)
  Backbone.history.start()
