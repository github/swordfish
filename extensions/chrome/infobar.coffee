#= require_self
#= require_tree ./infobar

class @Extension
  isUnlocked: ->
    @send isUnlocked: true

  unlock: (passphrase) ->
    @send unlock: passphrase

  send: (message) ->
    deferred = jQuery.Deferred()
    chrome.extension.sendMessage message, ->
      deferred.resolve.apply(deferred, arguments)
    deferred

class @Infobar extends Backbone.View
  constructor: (options) ->
    super()

    @el = options.el
    @extension = new Extension()

    @extension.isUnlocked().then (unlocked) =>
      if unlocked then @save() else @unlock()

  unlock: =>
    @view new Infobar.Unlock infobar: @

  save: =>
    @view new Infobar.Save infobar: @

  view: (view) ->
    @el.html view.render().el
