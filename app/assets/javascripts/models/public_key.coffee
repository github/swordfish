class @PublicKey
  @fromPem: (pem) ->
    new @(forge.pki.publicKeyFromPem(pem))

  constructor: (@key) ->

  encrypt: (data) ->
    forge.util.encode64(@key.encrypt(data))

  pem: ->
    forge.pki.publicKeyToPem(@key)
