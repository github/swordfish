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

    @itemsCollection = new Item.Collection([], keypair: @app.keypair)

    @layout = new Backbone.LayoutManager({
      template: "templates/main",

      views:
        "#items":     new Item.Views.List(collection: @itemsCollection)
        "#details":   @details = new Backbone.View()
    })

  ensureLayout: =>
    @app.layout @layout

  items: =>
    # ensure items collection has access to the keypair
    @itemsCollection.keypair = @app.keypair
    @itemsCollection.fetch()

  newItem: (id) =>
    @content new Item.Views.Create(collection: @itemsCollection)

  item: (id) =>
    @itemsCollection.load(id).then (item) =>
      @content new Item.Views.Show(model: item)

  edit: (id) =>
    @itemsCollection.load(id).then (item) =>
      @content new Item.Views.Edit(model: item)

  content: (view) ->
    @details.setView(view).render()
