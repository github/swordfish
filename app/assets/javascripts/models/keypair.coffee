class @Keypair
  @localStorage: window.localStorage
  @ajax: jQuery.ajax

  @load: ->
    new @(key) if key = @localStorage['privateKey']

  constructor: (@pem) ->

  savePrivateKey: () ->
    @constructor.localStorage['privateKey'] = @pem

  # Public: Unlock the keypair with the given passphrase.
  #
  # Returns a jQuery.Deferred() that will resolve when successful.
  unlock: (password) ->
    if @privateKey = PrivateKey.decrypt(@pem, password)
      @publicKey = @privateKey.publicKey()

    @isUnlocked()

  isUnlocked: ->
    !!@privateKey

  encrypt: (data) ->
    @publicKey.encrypt(data)

  decrypt: (data) ->
    @privateKey.decrypt(data)

  publicKeyPem: ->
    forge.pki.publicKeyToPem(@publicKey)
