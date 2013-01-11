class @ItemRouter extends Backbone.Router
  routes:
    '': 'items'
    'items/new':      'newItem'
    'items/:id':      'item'
    'items/:id/edit': 'editItem'
    'teams/new':      'newTeam'
    'teams/:id':      'team'
    'teams/:id/edit': 'editTeam'

  constructor: (options) ->
    super

    @app = options.app
    @on 'all', @ensureLayout

    @app.on 'authenticated', @fetch

    @items = new Item.Collection([], keypair: @app.keypair)
    @teams = new Team.Collection([], keypair: @app.keypair)

    @layout = new Backbone.LayoutManager({
      template: "templates/main",

      views:
        "#teams":     new Team.Views.List(collection: @teams)
        "#items":     new Item.Views.List(collection: @items)
        "#details":   @details = new Backbone.View()
    })

  fetch: =>
    # ensure items collection has access to the keypair
    @items.keypair ||= @app.keypair
    @items.fetch()

    @teams.keypair ||= @app.keypair
    @teams.fetch()

  ensureLayout: =>
    @app.layout @layout

  items: =>

  newItem: (id) =>
    @content new Item.Views.New(collection: @items)

  item: (id) =>
    @items.load(id).then (item) =>
      @content new Item.Views.Show(model: item)

  editItem: (id) =>
    @items.load(id).then (item) =>
      @content new Item.Views.Edit(model: item)

  newTeam: =>
    @content new Team.Views.New(collection: @teams)

  team: (id) =>
    @teams.load(id).then (team) =>
      @content new Team.Views.Show(
        model: team
        views:
          '.new-membership': new Membership.Views.New(model: team)
          '.memberships': new Membership.Views.List(model: team)
      )

  editTeam: (id) =>
    @teams.load(id).then (team) =>
      @content new Team.Views.Edit(model: team)

  content: (view) ->
    @details.setView(view).render()
