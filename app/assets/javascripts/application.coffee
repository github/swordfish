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

_.extend Backbone.Collection.prototype,
  load: (id) ->
    result = @deferred()
    if record = @get(id)
      result.resolve(record)
    else
      finder = =>
        @off 'reset', finder
        result.resolve(@get(id))
      @on 'reset', finder
    result

  deferred: ->
    jQuery.Deferred()

class @Application
  constructor: ->
    @vaults = new Vaults()

    @router = new Router(vaults: @vaults)

    $('#container').html(@router.layout.el)

    @router.layout.render()

    Backbone.history.start()