class @Vault extends Backbone.Model
  constructor: ->
    super
    @key = new Key(@get('key'))

    @items = new Collection.Items [], vault: @

  isUnlocked: ->
    false

  unlock: (password) ->
    @key.unlock(password)