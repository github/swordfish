class @ItemRouter extends Backbone.Router
  routes:
    '': 'items'
    'items/new': 'newItem'
    'items/:id': 'item'

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
    # noop

  newItem: (id) =>
    @content new Item.Views.New(collection: @items)

  item: (id) =>
    @items.load(id).then (item) =>
      @content new Item.Views.Show(model: item)

  content: (view) ->
    @details.setView(view).render()
