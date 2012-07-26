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
        "#new-vault":  new CreateVault(collection: @vaults)
        "#vault-list": new VaultList(collection: @vaults)
        "#content":    @main = new Backbone.View()
    })

  new: =>
    # @create = new CreateVault collection: @vaults, el: $('#create-vault')

  show: (id) =>
    @vaults.load id, (vault) =>
      @content new ShowVault(model: vault)

  newItem: (id) =>
    @vaults.load id, (vault) =>
      @unlock vault, => @content(new NewItem(model: vault, collection: vault.items))

  unlock: (vault, fn) ->
    if vault.key.isUnlocked()
      fn()
    else
      @content new UnlockVault(model: vault, complete: fn)

  content: (view) ->
    @main.setView(view).render()
