#= require chrome/extension
#= require_self
#= require_tree ./infobar

class @Infobar
  constructor: (@id, @el) ->
    @extension = new Extension()

    @extension.send('isUnlocked').then (unlocked) =>
      if unlocked then @save() else @unlock()

    $(document).on 'click', '.dismiss', @dismiss

  unlock: =>
    @view new Infobar.Unlock infobar: @

  save: =>
    @view new Infobar.Save infobar: @

  # Public: Dismiss the infobar
  dismiss: =>
    parent.postMessage 'dismiss', '*'

  # Internal: Render this view to @el
  view: (view) ->
    @el.html view.render().el
