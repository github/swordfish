#= require application

class @Background
  constructor: (@keypair) ->
    @app = new Application()
    @app.setKeypair(@keypair) if @keypair
    @items = new Item.Collection([], keypair: @keypair)
    @submissions = {}

  # Dispatch messages from the content script and popup
  dispatch: (request, sender, response) =>
    for message, args of request
      args.push sender
      response(@[message](args...)) if @[message]

  # Recieve private key
  key: (key) ->
    unless @app.keypair
      keypair = new Keypair(key)
      @app.setKeypair(keypair)
      @items.keypair = keypair

  submit: (params, sender) ->
    @submissions[sender.tab.id] = params

  connect: (sender) ->
    id = sender.tab.id
    if @submissions[id]
      chrome.experimental.infobars.show
        tabId: id
        path: "infobar.html##{id}"
        height: 40

  isUnlocked: ->
    @app.keypair.isUnlocked()

  unlock: (passphrase) ->
    @app.keypair.unlock(passphrase)

  setup: ->
    chrome.extension.onMessage.addListener @dispatch

@background = new Background(Keypair.load())
@background.setup()