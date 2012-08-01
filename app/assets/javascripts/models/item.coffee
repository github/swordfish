class @Item extends Backbone.Model
  reveal: ->
    @fetch().then =>
      @trigger 'reveal', @collection.key.decrypt(@get('password'))