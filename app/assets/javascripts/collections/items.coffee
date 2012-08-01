@Collection ?= {}

class @Collection.Items extends Backbone.Collection
  model: Model.Item

  constructor: (models, options) ->
    @vault = options.vault
    super

  url: ->
    "/vaults/#{@vault.id}/items"
