class Item.Collection extends Backbone.Collection
  model: Item

  constructor: (models, options) ->
    @vault = options.vault
    super

  save: ->
    items = ([model._id, model._key] for model in @models)
    Store.put items, (err, resp) =>
      @vault.save items_id: resp.id, items_key: resp.key
    return

  fetch: ->
    Store.get @vault.get('items_id'), @vault.get('items_key'), (err, resp) =>
      for [id, key] in resp.data
        item = new Item
        item._id = id
        item._key = key
        item.fetch()
        @add item
    return
