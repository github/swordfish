class @Keypair
  localStorage: window.localStorage
  ajax: jQuery.ajax

  constructor: (@publicKey, @privateKey) ->

  save: ->
    @savePrivateKey()
    @savePublicKey()

  savePrivateKey: ->
    @localStorage['key'] = @privateKey

  savePublicKey: ->
    @ajax({
      type:     'POST'
      url:      '/key'
      data:     @publicKey
    })