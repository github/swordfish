class @Router extends Backbone.Router
  routes:
    'vaults/new': 'new'
    'vaults/:id': 'show'
    'vaults/:id/items/new': 'newItem'

  constructor: (options) ->
    super
    @vaults = options.vaults

    @layout = new Backbone.LayoutManager({
      template: "#main-template",

      views:
        "#vaults":    new VaultList(collection: @vaults)
        "#items":     @items = new Backbone.View()
        "#details":   @details = new Backbone.View()
    })

  new: =>
    @content new CreateVault(collection: @vaults)

  show: (id) =>
    @vaults.load id, (vault) =>
      view = new ShowVault(
        model: vault
        views: {'.items': new ItemList(collection: vault.items)}
      )
      @items.setView(view).render()

  newItem: (id) =>
    @vaults.load id, (vault) =>
      @unlock vault, => @content(new NewItem(model: vault, collection: vault.items))

  unlock: (vault, fn) ->
    if vault.key.isUnlocked()
      fn()
    else
      @content new UnlockVault(model: vault, complete: fn)

  content: (view) ->
    @details.setView(view).render()
