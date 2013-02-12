class @PrivateKey
  @decrypt: (pem, password) ->
    new @(key) if key = forge.pki.decryptRsaPrivateKey(pem, password)

  constructor: (@key) ->

  decrypt: (data) ->
    @key.decrypt(forge.util.decode64(data))

  publicKey: ->
    new PublicKey(forge.pki.rsa.setPublicKey(@key.n, @key.e))
