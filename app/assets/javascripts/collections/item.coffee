class Item.Collection extends Backbone.Collection
  model: Item
  url: '/items'

  constructor: (models, options) ->
    @keypair = options.keypair
    super

  setKeypair: (keypair) ->
    @keypair = keypair

  getKeypair: ->
    @keypair
