class @Router extends Backbone.Router
  routes:
    'vaults/new': 'newVault'
    'vaults/:id': 'vault'
    'vaults/:id/items/new': 'newItem'
    'vaults/:id/items/:id': 'item'

  constructor: (options) ->
    super
    @vaults = options.vaults
    @active = {}

    @layout = new Backbone.LayoutManager({
      template: "#main-template",

      views:
        "#vaults":    new VaultList(collection: @vaults)
        "#items":     @items = new Backbone.View()
        "#details":   @details = new Backbone.View()
    })

  newVault: =>
    @content new CreateVault(collection: @vaults)

  vault: (id) =>
    @vaults.load(id).then (vault) =>
      view = new ShowVault(
        model: vault
        views: {'.items': new ItemList(collection: vault.items)}
      )
      @activate vault
      @items.setView(view).render()

  newItem: (id) =>
    @vaults.load(id).then (vault) =>
      @unlock vault, => @content(new NewItem(model: vault, collection: vault.items))

  item: (vaultId, itemId) =>
    @vaults.load(vaultId).then (vault) =>
      vault.items.load(itemId).then (item) =>
        @content(new ShowItem(model: item))

  unlock: (vault, fn) ->
    if vault.key.isUnlocked()
      fn()
    else
      @content new UnlockVault(model: vault, complete: fn)

  content: (view) ->
    @details.setView(view).render()

  activate: (object) ->
    @active[object.constructor]?.trigger('deactivate')
    @active[object.constructor] = object
    object.trigger('activate')