# Swordfish customizations to LayoutManager

Backbone.LayoutManager.configure(
  manage: true

  fetch: (path) ->
    HoganTemplates[path]

  render: (template, context) ->
    template.render(context || {})
)
