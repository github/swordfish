class @Keypair
  @localStorage: window.localStorage
  @ajax: jQuery.ajax

  @load: ->
    new @(key) if key = @localStorage['privateKey']

  constructor: (@privateKeyPem) ->

  savePrivateKey: () ->
    @constructor.localStorage['privateKey'] = @privateKeyPem

  # Public: Unlock the keypair with the given passphrase.
  #
  # Returns a jQuery.Deferred() that will resolve when successful.
  unlock: (password) ->
    if @privateKey = forge.pki.decryptRsaPrivateKey(@privateKeyPem, password)
      @publicKey = forge.pki.rsa.setPublicKey(@privateKey.n, @privateKey.e)

    @isUnlocked()

  isUnlocked: ->
    !!@privateKey

  encrypt: (data) ->
    @publicKey.encrypt(data)

  decrypt: (data) ->
    @privateKey.decrypt(data)

  publicKeyPem: ->
    forge.pki.publicKeyToPem(@publicKey)