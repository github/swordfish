#= require hogan
#= require backbone.layoutmanager
#= require form2js
#= require jquery.toObject
#= require mustache
#= require ext/backbone.layoutmanager

#= require_tree ./templates
#= require_tree ./views
#= require_tree ./routers

Application.on 'initialize', ->
  new KeyRouter(app: @)
  new ItemRouter(app: @)
  new InviteRouter(app: @)
  Backbone.history.start()
