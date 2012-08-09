class @Item extends Backbone.Model
  save: ->
    Store.put @attributes, (err, resp) =>
      @_id  = resp.id
      @_key = resp.key
      @collection.save()
    return

  fetch: ->
  	Store.get @_id, @_key, (err, resp) =>
      @set resp.data

  reveal: ->
    @fetch().then =>
      @trigger 'reveal', @get('password')