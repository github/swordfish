#= require chrome/events

# API for interacting with the extension
#
# Any browser-specific extension calls should go through here so they can be
# easily overriden in other browsers.
class @Extension
  constructor: ->
    jQuery.extend @, Events
    chrome.extension.onMessage.addListener @dispatch

  send: (message, args...) ->
    deferred = jQuery.Deferred()
    payload = {}
    payload[message] = args
    chrome.extension.sendMessage payload, ->
      deferred.resolve.apply(deferred, arguments)
    deferred

  dispatch: (request, sender, response) =>
    for message, args of request
      args.push sender, response
      @trigger message, args...
