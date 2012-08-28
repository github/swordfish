class @KeypairAuthenticator
  @ajax: jQuery.ajax

  constructor: (@keypair) ->
    jQuery.extend @, jQuery.Deferred()

  request: ->
    @constructor.ajax(
      type:     'POST'
      url:      '/auth/rsa'
      data:     @keypair.publicKeyPem()
      dataType: 'text'
    ).done @respond

  respond: (data) =>
    challenge = @decryptChallenge(data)

    @constructor.ajax(
      type:     'PUT'
      url:      '/auth/rsa'
      dataType: 'text'
      data:     challenge
    ).done => @resolve(challenge)

  decryptChallenge: (challenge) ->
    forge.util.encode64(@keypair.decrypt(forge.util.decode64(challenge)))