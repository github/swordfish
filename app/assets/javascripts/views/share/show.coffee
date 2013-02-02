Share.Views ?= {}

class Share.Views.Show extends Backbone.View
  template: 'templates/share/show'
  tagName: 'li'

  serialize: ->
    @model.toJSON()
