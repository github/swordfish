#= require lib/jquery
#= require models/keypair

class @Background
  constructor: ->
    @keypair = Keypair.load()

  # Dispatch messages from the content script and popup
  dispatch: (request, sender, response) =>
    for message, payload of request
      @[message]?(payload, sender, response)

  # Recieve private key
  key: (key) ->
    unless @keypair
      @keypair = new Keypair(key)
      @keypair.savePrivateKey()

  setup: ->
    chrome.extension.onMessage.addListener @dispatch

@app = new Background
@app.setup()