# Swordfish customizations to Backbone

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

