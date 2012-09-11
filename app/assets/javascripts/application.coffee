#= require lib/jquery
#= require models
#= require_self
#= require ui

class @Application
  _.extend @prototype, Backbone.Events

  @on: (args...) ->
    @prototype.on(args...)

  constructor: ->
    @trigger 'initialize'

  # FIXME: make a class for UI concerns and move this there
  layout: (layout) ->
    unless layout == @current_layout
      @current_layout = layout
      $(document.body).html(layout.el)
      layout.render()
