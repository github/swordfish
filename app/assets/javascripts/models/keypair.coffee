class @Keypair
  @localStorage: window.localStorage
  @ajax: jQuery.ajax

  @create: (publicKey, privateKeyPem) ->
    keypair = new @(forge.pki.publicKeyFromPem(publicKey), privateKeyPem)
    keypair.savePublicKey()
    keypair.savePrivateKey()
    keypair

  @load: (publicKey) ->
    if publicKey
      publicKey = forge.pki.publicKeyFromPem(publicKey) if typeof publicKey == 'string'
      new @(publicKey, @localStorage['privateKey'])


  constructor: (@publicKey, @privateKeyPem) ->

  savePrivateKey: (key) ->
    @privateKeyPem = key || @privateKeyPem
    @constructor.localStorage['privateKey'] = @privateKeyPem

  savePublicKey: ->
    @constructor.ajax(
      type:     'POST'
      url:      '/key'
      data:     forge.pki.publicKeyToPem(@publicKey)
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
