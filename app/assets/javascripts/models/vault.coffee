class @Vault extends Backbone.Model
  constructor: ->
    super
    @key = new Key(@get('key'))

    @items = new Collection.Items
    @items.url = "/vaults/#{@id}/items"

  isUnlocked: ->
    false

  unlock: (password) ->
    @key.unlock(password)