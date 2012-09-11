class Backbone.TemplateView extends Backbone.View
  fetch: (path) ->
    HoganTemplates[path]

  context: ->
    {}

  render: (context = @context()) ->
    @$el.html @fetch(@template).render(context)
    @
