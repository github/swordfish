class @Vault extends Backbone.Model
  constructor: ->
    super
    @key = new Key(@get('key'))

  isUnlocked: ->
    false

  unlock: (password) ->
    @key.unlock(password)