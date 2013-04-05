class Item.Collection extends Backbone.Collection
  model: Item
  url: '/items'

  initialize: (models, options) ->
    @keypair = options.keypair
    _.extend @, new Backbone.Picky.SingleSelect(@)
