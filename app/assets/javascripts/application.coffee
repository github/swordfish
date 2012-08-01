#= require lib/jquery
#= require lib/underscore
#= require lib/backbone
#= require csrf
#= require_tree ./lib
#= require hogan
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require router
#= require_self

Backbone.LayoutManager.configure(
  fetch: (path) ->
    HoganTemplates[path]

  render: (template, context) ->
    template.render(context || {})
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
    @vaults = new Vault.Collection()
    @vaults.fetch()

    @router = new Router(vaults: @vaults)

    $('#container').html(@router.layout.el)

    @router.layout.render()

    Backbone.history.start()