class @ItemRouter extends Backbone.Router
  routes:
    '': 'items'
    'items/new': 'newItem'
    'items/:id': 'item'
    'items/:id/edit': 'edit'

  constructor: (options) ->
    super

    @app = options.app
    @on 'all', @ensureLayout

    @items = new Item.Collection([], keypair: @app.keypair)

    @layout = new Backbone.LayoutManager({
      template: "templates/main",

      views:
        "#items":     new Item.Views.List(collection: @items)
        "#details":   @details = new Backbone.View()
    })

  ensureLayout: =>
    @app.layout @layout

  items: =>
    # ensure items collection has access to the keypair
    @items.keypair ||= @app.keypair
    @items.fetch().then (items) =>
      if _.any(items)
        @item _.first(items).id

  newItem: (id) =>
    @content new Item.Views.Create(collection: @items)

  item: (id) =>
    @items.load(id).then (item) =>
      @content new Item.Views.Show(model: item)

  edit: (id) =>
    @items.load(id).then (item) =>
      @content new Item.Views.Edit(model: item)

  content: (view) ->
    @details.setView(view).render()
