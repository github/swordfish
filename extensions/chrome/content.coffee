#= require lib/form2js

class Content
  constructor: ->
    @send 'connect'

  submit: (event) =>
    data = form2js(event.target, '.', true, null, true)
    @send 'submit', data

  send: (message, args...) ->
    payload = {}
    payload[message] = args
    chrome.extension.sendMessage payload

content = new Content

document.addEventListener 'submit', content.submit, true
