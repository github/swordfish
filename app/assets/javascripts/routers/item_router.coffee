class @ItemRouter extends Backbone.Router
  routes:
    '': 'items'
    'items/new':      'newItem'
    'items/:id':      'item'
    'items/:id/edit': 'editItem'
    'teams/new':      'newTeam'
    'teams/:id':      'team'
    'teams/:id/edit': 'editTeam'

  initialize: (options) ->
    @app = options.app
    @on 'all', @ensureLayout

    @items = @app.items
    @teams = @app.teams

    @layout = new Backbone.LayoutManager({
      template: "templates/main",

      views:
        "#teams":     new Team.Views.List(collection: @teams)
        "#items":     new Item.Views.List(collection: @items)
        "#details":   @details = new Backbone.View()
    })

  ensureLayout: =>
    @app.layout @layout

  items: =>

  newItem: (id) =>
    @content new Item.Views.Create(collection: @items)

  item: (id) =>
    @items.load(id).then (item) =>
      @content new Item.Views.Show(model: item)

  editItem: (id) =>
    @items.load(id).then (item) =>
      @content new Item.Views.Edit(model: item)

  newTeam: =>
    @content new Team.Views.Create(collection: @teams)

  team: (id) =>
    @teams.load(id).then (team) =>
      @content new Team.Views.Show(
        model: team
        views:
          '.new-membership': new Membership.Views.Create(model: team)
          '.memberships': new Membership.Views.List(model: team)
      )

  editTeam: (id) =>
    @teams.load(id).then (team) =>
      @content new Team.Views.Edit(model: team)

  content: (view) ->
    @details.setView(view).render()
