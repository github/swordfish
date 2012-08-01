class Item.Collection extends Backbone.Collection
  model: Item

  constructor: (models, options) ->
    @vault = options.vault
    @key = @vault.key
    super

  url: ->
    "/vaults/#{@vault.id}/items"

  create: (attrs, options) ->
    attrs.password = @key.encrypt(attrs.password)
    super attrs, options
