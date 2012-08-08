# Generate an RSA public and encrypted private key.
#
# Generating a keypair is time intensive, but this implementation works in
# chunks, pausing to allow the UI to update.
#
#   generator = new KeypairGenerator('mypassphrase').start()
#
#   generator.progress ->
#     console.log 'progress'
#     updateUI()
#
#   generator.done (pub, priv) ->
#     console.log 'generated keys', pub, priv
#     saveKeys(pub, priv)
#
class @KeypairGenerator
  keysize: 1024
  interval: 10

  constructor: (@passphrase) ->
    @deferred = jQuery.Deferred()

  start: ->
    @state = forge.pki.rsa.createKeyPairGenerationState(@keysize)
    @delay @progress
    @deferred

  progress: =>
    if forge.pki.rsa.stepKeyPairGenerationState(@state, @interval)
      @finish()
    else
      @deferred.notify(@state)
      @delay @progress

  finish: ->
    @deferred.resolve(@publicKey(), @encryptedPrivateKey())

  encryptedPrivateKey: ->
    forge.pki.encryptRsaPrivateKey(@state.keys.privateKey, @passphrase)

  publicKey: ->
    forge.pki.publicKeyToPem(@state.keys.publicKey)

  # Delay to prevent from locking the interface.
  #
  # Override in tests to allow synchronous tests.
  delay: (fn) ->
    _.delay(fn, 0)

