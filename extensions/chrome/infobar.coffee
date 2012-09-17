#= require chrome/extension
#= require_self
#= require_tree ./infobar

class @Infobar
  constructor: (@id, @el) ->
    @extension = new Extension()

    @extension.send('isUnlocked').then (unlocked) =>
      if unlocked then @save() else @unlock()

  unlock: =>
    @view new Infobar.Unlock infobar: @

  save: =>
    @view new Infobar.Save infobar: @

  # Public: Dismiss the infobar
  dismiss: =>
    window.close()

  # Internal: Render this view to @el
  view: (view) ->
    @el.html view.render().el
