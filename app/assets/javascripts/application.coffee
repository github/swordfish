#= require lib/jquery
#= require lib/underscore
#= require lib/backbone
#= require csrf
#= require_tree ./lib
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./controllers
#= require_tree ./views
#= require router
#= require_self

Backbone.LayoutManager.configure(
  fetch: (path) ->
    return Mustache.compile($(path).html());

  render: (template, context) ->
    template(context || {})
)

class @Application
  constructor: ->
    @vaults = new Vaults()

    @router = new Router(vaults: @vaults)

    $('#container').html(@router.layout.el)

    @router.layout.render()

    Backbone.history.start()