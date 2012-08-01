class @ShowItem extends Backbone.View
  template: '#show-item-template'

  events:
    'click a.reveal': 'reveal'

  serialize: ->
    @model.toJSON()

  reveal: (e) =>
    e.preventDefault()
    @model.reveal().then(@display)

  display: =>
    @$('.password').text(@model.get('password'))