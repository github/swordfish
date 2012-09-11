#= require lib/jquery
#= require models

class @Application
  _.extend @prototype, Backbone.Events

  # Host to make Ajax requests to
  @host: null

  # Ajax prefilter to prepend host to request url
  @prependHost: (options, originalOptions, xhr) =>
    if @host
      options.crossDomain = true
      options.url = "#{@host}#{originalOptions.url}"

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

jQuery.ajaxPrefilter Application.prependHost
