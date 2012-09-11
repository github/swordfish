#= require lib/jquery
#= require models

class @Background
  constructor: (@keypair) ->
    @submissions = {}

  # Dispatch messages from the content script and popup
  dispatch: (request, sender, response) =>
    for message, payload of request
      response(@[message](payload, sender)) if @[message]

  # Recieve private key
  key: (key) ->
    unless @keypair
      @keypair = new Keypair(key)
      @keypair.savePrivateKey()

  submit: (params, sender) ->
    @submissions[sender.tab.id] = params

  connect: (x, sender) ->
    id = sender.tab.id
    if @submissions[id]
      chrome.experimental.infobars.show
        tabId: id
        path: "infobar.html##{id}"
        height: 40

  isUnlocked: ->
    @keypair.isUnlocked()

  unlock: (passphrase) ->
    @keypair.unlock(passphrase)

  setup: ->
    chrome.extension.onMessage.addListener @dispatch

@app = new Background(Keypair.load())
@app.setup()