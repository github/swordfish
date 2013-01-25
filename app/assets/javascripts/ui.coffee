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
  # Backbone doesn't initialize history until you define routes
  Backbone.history = new Backbone.History

  # Save the originally requested path
  Backbone.history.store()

  new KeyRouter(app: @)

  Backbone.history.start()

Application.on 'ready', ->
  new ItemRouter(app: @)
  new InviteRouter(app: @)
  Backbone.history.resume '', true
