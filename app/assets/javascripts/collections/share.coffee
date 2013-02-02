class Share.Collection extends Backbone.Collection
  model: Share

  initialize: (models, options) ->
    @item = options.item

  url: ->
    @item.url() + '/shares'
