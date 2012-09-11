#= require lib/form2js

class Content
  constructor: ->
    @send 'connect': true

  submit: (event) =>
    data = form2js(event.target, '.', true, null, true)
    @send submit: data

  send: (message) ->
    chrome.extension.sendMessage message

content = new Content

document.addEventListener 'submit', content.submit, true
