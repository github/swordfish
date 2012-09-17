class Item.Collection extends Backbone.Collection
  model: Item
  url: '/items'

  constructor: (models, options) ->
    @keypair = options.keypair
    super

  forHost: (host) ->
    @find (item) -> item.get('host') == host