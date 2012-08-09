class @Vault extends Backbone.Model
  constructor: ->
    super
    @key = new Key(@get('key'))

    @items = new Item.Collection [], vault: @

  isUnlocked: ->
    false

  unlock: (password) ->
    @key.unlock(password)
