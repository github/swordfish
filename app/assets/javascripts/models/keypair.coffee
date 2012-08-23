class @Keypair
  @localStorage: window.localStorage
  @ajax: jQuery.ajax

  @create: (privateKeyPem, passphrase) ->
    keypair = new @(privateKeyPem)
    keypair.unlock(passphrase)
    keypair.savePublicKey()
    keypair.savePrivateKey()
    keypair

  @load: ->
    new @(key) if key = @localStorage['privateKey']

  constructor: (@privateKeyPem) ->

  savePrivateKey: () ->
    @constructor.localStorage['privateKey'] = @privateKeyPem

  savePublicKey: ->
    @constructor.ajax(
      type:     'POST'
      url:      '/key'
      data:     forge.pki.publicKeyToPem(@publicKey)
    )

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
