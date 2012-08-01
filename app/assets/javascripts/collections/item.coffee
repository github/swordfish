class Item.Collection extends Backbone.Collection
  model: Item

  constructor: (models, options) ->
    @vault = options.vault
    super

  url: ->
    "/vaults/#{@vault.id}/items"
