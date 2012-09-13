# API for interacting with the extension
#
# Any browser-specific extension calls should go through here so they can be
# easily overriden in other browsers.
class @Extension
  isUnlocked: ->
    @send 'isUnlocked'

  unlock: (passphrase) ->
    @send 'unlock', passphrase

  save: (attrs) ->
    @send 'save', attrs

  # Internal: Send messages to the chrome extension
  send: (message, args...) ->
    deferred = jQuery.Deferred()
    payload = {}
    payload[message] = args
    chrome.extension.sendMessage payload, ->
      deferred.resolve.apply(deferred, arguments)
    deferred
