class @Keypair
  @localStorage: window.localStorage
  @ajax: jQuery.ajax

  @create: (publicKey, privateKeyPem) ->
    keypair = new @(publicKey, privateKeyPem)
    keypair.savePublicKey()
    keypair.savePrivateKey()
    keypair

  @load: (publicKey) ->
    new @(publicKey, @localStorage['privateKey']) if publicKey

  constructor: (@publicKeyPem, @privateKeyPem) ->
    @publicKey = forge.pki.publicKeyFromPem(@publicKeyPem)

  savePrivateKey: (key) ->
    @privateKeyPem = key || @privateKeyPem
    @constructor.localStorage['privateKey'] = @privateKeyPem

  savePublicKey: ->
    @constructor.ajax(
      type:     'POST'
      url:      '/key'
      data:     @publicKeyPem
    )

  unlock: (password) ->
    @privateKey = forge.pki.decryptRsaPrivateKey(@privateKeyPem, password)
    @isUnlocked()

  isUnlocked: ->
    !!@privateKey

  encrypt: (data) ->
    @publicKey.encrypt(data)

  decrypt: (data) ->
    @privateKey.decrypt(data)
